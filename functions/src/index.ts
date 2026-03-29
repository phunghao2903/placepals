import { initializeApp } from 'firebase-admin/app';
import { getAuth } from 'firebase-admin/auth';
import { FieldValue, getFirestore } from 'firebase-admin/firestore';
import { getMessaging } from 'firebase-admin/messaging';
import * as logger from 'firebase-functions/logger';
import { HttpsError, onCall } from 'firebase-functions/v2/https';

initializeApp();

const auth = getAuth();
const firestore = getFirestore();
const messaging = getMessaging();
const functionsRegion = 'asia-southeast1';

export const sendWelcomePushOnLogin = onCall(
  {
    region: functionsRegion,
  },
  async (request) => {
    const uid = request.auth?.uid;
    if (!uid) {
      throw new HttpsError('unauthenticated', 'Authentication is required.');
    }

    logger.info('sendWelcomePushOnLogin invoked.', {
      region: functionsRegion,
      uid,
    });

    const loginEventId = asNonEmptyString(request.data?.loginEventId);
    const token = asNonEmptyString(request.data?.token);

    if (!loginEventId || !token) {
      throw new HttpsError(
        'invalid-argument',
        'loginEventId and token are required.',
      );
    }

    const userRef = firestore.collection('users').doc(uid);
    const userSnapshot = await userRef.get();
    const registeredToken = asNonEmptyString(
      userSnapshot.data()?.androidFcmToken,
    );

    if (!registeredToken || registeredToken !== token) {
      throw new HttpsError(
        'failed-precondition',
        'The provided token is not registered for the current user.',
      );
    }

    const eventRef = userRef.collection('loginPushEvents').doc(loginEventId);

    try {
      await eventRef.create({
        token,
        status: 'pending',
        createdAt: FieldValue.serverTimestamp(),
      });
    } catch (error) {
      if (isAlreadyExistsError(error)) {
        logger.info('Duplicate welcome push skipped.', { uid, loginEventId });
        return { sent: false, duplicate: true };
      }

      logger.error('Failed to create login push event.', error);
      throw new HttpsError('internal', 'Unable to register login push event.');
    }

    try {
      const messageId = await messaging.send({
        token,
        notification: {
          title: 'Welcome back to PlacePals',
          body: 'You have signed in successfully.',
        },
        data: {
          type: 'welcome_login',
          route: 'home',
          loginEventId,
          title: 'Welcome back to PlacePals',
          body: 'You have signed in successfully.',
        },
        android: {
          priority: 'high',
          notification: {
            channelId: 'welcome_messages',
            clickAction: 'FLUTTER_NOTIFICATION_CLICK',
            color: '#FF6B5A',
            icon: 'ic_stat_welcome',
          },
        },
      });

      await eventRef.set(
        {
          status: 'sent',
          sentAt: FieldValue.serverTimestamp(),
          messageId,
        },
        { merge: true },
      );

      logger.info('Welcome push sent successfully.', {
        region: functionsRegion,
        uid,
        loginEventId,
        messageId,
      });

      return { sent: true, messageId };
    } catch (error) {
      await eventRef.set(
        {
          status: 'failed',
          sentAt: null,
          errorMessage: serializeError(error),
        },
        { merge: true },
      );

      logger.error('Failed to send welcome push.', {
        region: functionsRegion,
        uid,
        loginEventId,
        error: serializeError(error),
      });
      throw new HttpsError('internal', 'Unable to send welcome notification.');
    }
  },
);

export const upsertCurrentUserProfile = onCall(
  {
    region: functionsRegion,
  },
  async (request) => {
    const uid = request.auth?.uid;
    if (!uid) {
      throw new HttpsError('unauthenticated', 'Authentication is required.');
    }

    const displayName = normalizeDisplayName(request.data?.displayName);
    const username = normalizeUsername(request.data?.username);
    const bio = normalizeBio(request.data?.bio);
    const rawPhoneNumber = asNonEmptyString(request.data?.phoneNumber);
    const phoneNumber = normalizePhoneNumber(request.data?.phoneNumber);
    const rawAvatarUrl = asNonEmptyString(request.data?.avatarUrl);
    const avatarUrl = normalizeOptionalUrl(request.data?.avatarUrl);
    const rawCoverUrl = asNonEmptyString(request.data?.coverUrl);
    const coverUrl = normalizeOptionalUrl(request.data?.coverUrl);
    const clearAvatar = request.data?.clearAvatar === true;
    const clearCover = request.data?.clearCover === true;

    if (!displayName) {
      throw new HttpsError(
        'invalid-argument',
        'Display name is required.',
      );
    }

    if (!username) {
      throw new HttpsError(
        'invalid-argument',
        'Username must match ^[a-z0-9._]{3,20}$.',
      );
    }

    if (bio.length > 150) {
      throw new HttpsError(
        'invalid-argument',
        'Bio must be 150 characters or fewer.',
      );
    }

    if (rawPhoneNumber && !phoneNumber) {
      throw new HttpsError(
        'invalid-argument',
        'Phone number format is invalid.',
      );
    }

    if (rawAvatarUrl && !avatarUrl) {
      throw new HttpsError(
        'invalid-argument',
        'Avatar URL format is invalid.',
      );
    }

    if (rawCoverUrl && !coverUrl) {
      throw new HttpsError(
        'invalid-argument',
        'Cover URL format is invalid.',
      );
    }

    logger.info('upsertCurrentUserProfile invoked.', {
      region: functionsRegion,
      uid,
      username,
    });

    const userRef = firestore.collection('users').doc(uid);
    const usernamesRef = firestore.collection('usernames').doc(username);

    try {
      await firestore.runTransaction(async (transaction) => {
        const userSnapshot = await transaction.get(userRef);
        const currentData = userSnapshot.data();
        const existingUsername =
          normalizeUsername(currentData?.usernameLowercase) ??
          normalizeUsername(currentData?.username);
        const usernameSnapshot = await transaction.get(usernamesRef);
        const usernameOwner = asNonEmptyString(usernameSnapshot.data()?.uid);

        if (usernameSnapshot.exists && usernameOwner && usernameOwner !== uid) {
          throw new HttpsError(
            'already-exists',
            'Username is already taken.',
          );
        }

        transaction.set(
          usernamesRef,
          {
            uid,
            username,
            updatedAt: FieldValue.serverTimestamp(),
          },
          { merge: true },
        );

        if (existingUsername && existingUsername !== username) {
          transaction.delete(firestore.collection('usernames').doc(existingUsername));
        }

        const email =
          asNonEmptyString(request.auth?.token.email) ??
          asNonEmptyString(currentData?.email);
        const updatePayload: Record<string, unknown> = {
          fullName: displayName,
          username,
          usernameLowercase: username,
          bio: bio.length > 0 ? bio : null,
          phoneNumber,
          email,
          updatedAt: FieldValue.serverTimestamp(),
        };

        if (!userSnapshot.exists) {
          updatePayload.createdAt = FieldValue.serverTimestamp();
        }

        if (clearAvatar) {
          updatePayload.avatarUrl = null;
        } else if (avatarUrl) {
          updatePayload.avatarUrl = avatarUrl;
        }

        if (clearCover) {
          updatePayload.coverUrl = null;
        } else if (coverUrl) {
          updatePayload.coverUrl = coverUrl;
        }

        transaction.set(userRef, updatePayload, { merge: true });
      });

      await auth.updateUser(uid, { displayName });

      logger.info('Current user profile updated successfully.', {
        region: functionsRegion,
        uid,
        username,
      });

      return {
        success: true,
        username,
        displayName,
      };
    } catch (error) {
      if (error instanceof HttpsError) {
        throw error;
      }

      logger.error('Failed to upsert current user profile.', {
        region: functionsRegion,
        uid,
        username,
        error: serializeError(error),
      });
      throw new HttpsError('internal', 'Unable to update profile.');
    }
  },
);

function asNonEmptyString(value: unknown): string | null {
  if (typeof value != 'string') {
    return null;
  }

  const trimmed = value.trim();
  return trimmed.length > 0 ? trimmed : null;
}

function isAlreadyExistsError(error: unknown): boolean {
  if (typeof error !== 'object' || error === null) {
    return false;
  }

  const code = (error as { code?: unknown }).code;
  return code === 6 || code === 'already-exists';
}

function serializeError(error: unknown): string {
  if (error instanceof Error) {
    return error.message;
  }

  return 'Unknown error';
}

function normalizeDisplayName(value: unknown): string | null {
  const trimmed = asNonEmptyString(value);
  return trimmed ? trimmed.substring(0, 80) : null;
}

function normalizeUsername(value: unknown): string | null {
  const trimmed = asNonEmptyString(value)?.replace(/^@+/, '').toLowerCase();
  if (!trimmed) {
    return null;
  }

  return /^[a-z0-9._]{3,20}$/.test(trimmed) ? trimmed : null;
}

function normalizeBio(value: unknown): string {
  if (typeof value != 'string') {
    return '';
  }

  return value.trim();
}

function normalizePhoneNumber(value: unknown): string | null {
  const trimmed = asNonEmptyString(value);
  if (!trimmed) {
    return null;
  }

  return /^[+\d\s\-()]{8,20}$/.test(trimmed) ? trimmed : null;
}

function normalizeOptionalUrl(value: unknown): string | null {
  const trimmed = asNonEmptyString(value);
  if (!trimmed) {
    return null;
  }

  return /^https?:\/\//.test(trimmed) ? trimmed : null;
}
