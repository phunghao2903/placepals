import { initializeApp } from 'firebase-admin/app';
import { FieldValue, getFirestore } from 'firebase-admin/firestore';
import { getMessaging } from 'firebase-admin/messaging';
import * as logger from 'firebase-functions/logger';
import { HttpsError, onCall } from 'firebase-functions/v2/https';

initializeApp();

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
