import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/notification_item.dart';

class NotificationCard extends StatelessWidget {
  static const Color _readMessageColor = Color(0xCCFF6B5A);
  static const Color _unreadBackground = Color(0xFFFFF0EE);
  static const Color _softPinBackground = Color(0xFFFFF0EE);

  final NotificationItem notification;
  final VoidCallback onTap;

  const NotificationCard({
    super.key,
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isUnread = !notification.isRead;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(minHeight: 94),
          decoration: BoxDecoration(
            color: isUnread ? _unreadBackground : Colors.white,
            border: Border(
              left: BorderSide(
                color: isUnread ? AppColors.primary : Colors.transparent,
                width: 4,
              ),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _NotificationAvatar(notification: notification),
              const SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        notification.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.heading3.copyWith(
                          color: AppColors.textPrimary.withValues(
                            alpha: notification.isRead ? 0.86 : 1,
                          ),
                          height: 1.05,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        notification.message,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.body1.copyWith(
                          color: notification.isRead
                              ? _readMessageColor
                              : AppColors.primary,
                          height: 1.12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  notification.relativeTime,
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.primary.withValues(
                      alpha: notification.isRead ? 0.75 : 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationAvatar extends StatelessWidget {
  final NotificationItem notification;

  const _NotificationAvatar({required this.notification});

  @override
  Widget build(BuildContext context) {
    final isUnread = !notification.isRead;

    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _backgroundColorFor(notification.type),
            border: Border.all(color: _borderColorFor(notification.type)),
          ),
          child: ClipOval(child: _buildAvatarContent(notification)),
        ),
        if (isUnread)
          Positioned(
            right: 2,
            top: 1,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.5),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildAvatarContent(NotificationItem notification) {
    switch (notification.type) {
      case NotificationType.sosAlert:
        return const Icon(
          Icons.warning_amber_rounded,
          size: 34,
          color: Colors.white,
        );
      case NotificationType.locationVerified:
        return const Icon(
          Icons.location_on_rounded,
          size: 34,
          color: AppColors.primary,
        );
      case NotificationType.palRequest:
      case NotificationType.recommendation:
      case NotificationType.tagged:
        final imagePath = notification.imagePath;
        if (imagePath == null) {
          return Container(
            color: AppColors.primarySoft,
            alignment: Alignment.center,
            child: Text(
              notification.title.characters.first.toUpperCase(),
              style: AppTextStyles.heading3.copyWith(color: AppColors.primary),
            ),
          );
        }
        return Image.asset(imagePath, fit: BoxFit.cover);
    }
  }

  Color _backgroundColorFor(NotificationType type) {
    switch (type) {
      case NotificationType.sosAlert:
        return AppColors.primary;
      case NotificationType.locationVerified:
        return NotificationCard._softPinBackground;
      case NotificationType.palRequest:
      case NotificationType.recommendation:
      case NotificationType.tagged:
        return Colors.white;
    }
  }

  Color _borderColorFor(NotificationType type) {
    switch (type) {
      case NotificationType.palRequest:
        return Colors.white;
      case NotificationType.sosAlert:
        return AppColors.primary;
      case NotificationType.locationVerified:
        return NotificationCard._softPinBackground;
      case NotificationType.recommendation:
      case NotificationType.tagged:
        return AppColors.primary;
    }
  }
}
