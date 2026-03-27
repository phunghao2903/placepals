import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/notification_item.dart';

class NotificationTile extends StatelessWidget {
  final NotificationItem item;
  final VoidCallback onTap;
  final VoidCallback onMarkAsRead;

  const NotificationTile({
    super.key,
    required this.item,
    required this.onTap,
    required this.onMarkAsRead,
  });

  @override
  Widget build(BuildContext context) {
    final isUnread = !item.isRead;
    final titleColor = AppColors.textPrimary.withValues(
      alpha: isUnread ? 1 : 0.82,
    );
    final bodyColor = AppColors.primary.withValues(alpha: isUnread ? 0.9 : 0.8);

    return Material(
      color: isUnread ? const Color(0xFFFFF0EE) : Colors.white,
      child: InkWell(
        onTap: onTap,
        onLongPress: isUnread ? onMarkAsRead : null,
        child: Container(
          constraints: const BoxConstraints(minHeight: 94),
          decoration: BoxDecoration(
            color: isUnread ? const Color(0xFFFFF0EE) : Colors.white,
            border: Border(
              left: BorderSide(
                color: isUnread ? AppColors.primary : Colors.white,
                width: 4,
              ),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(16, 10, 15, 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _NotificationAvatar(item: item),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      item.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.heading3.copyWith(
                        color: titleColor,
                        height: 1.0,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.message,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.body1.copyWith(
                        color: bodyColor,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  item.timeLabel,
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.primary.withValues(
                      alpha: isUnread ? 1 : 0.8,
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
  final NotificationItem item;

  const _NotificationAvatar({required this.item});

  @override
  Widget build(BuildContext context) {
    final bool isUnread = !item.isRead;

    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned.fill(child: _buildAvatarBody()),
          if (isUnread)
            Positioned(
              right: 0,
              top: -1,
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAvatarBody() {
    switch (item.type) {
      case NotificationItemType.sosAlert:
        return _IconAvatar(
          backgroundColor: AppColors.primary,
          icon: Icons.warning_amber_rounded,
          iconColor: Colors.white,
        );
      case NotificationItemType.locationVerified:
        return const _IconAvatar(
          backgroundColor: Color(0xFFFFF0EE),
          icon: Icons.location_on_rounded,
          iconColor: AppColors.primary,
        );
      case NotificationItemType.palRequest:
      case NotificationItemType.placeSpotlight:
      case NotificationItemType.taggedYou:
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: item.isRead ? AppColors.primary : Colors.white,
            ),
          ),
          child: ClipOval(
            child: Image.asset(item.imagePath!, fit: BoxFit.cover),
          ),
        );
    }
  }
}

class _IconAvatar extends StatelessWidget {
  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;

  const _IconAvatar({
    required this.backgroundColor,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: Icon(icon, size: 34, color: iconColor),
    );
  }
}
