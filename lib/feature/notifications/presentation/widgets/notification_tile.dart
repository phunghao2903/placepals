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
    final bool isSos = item.type == NotificationItemType.sosAlert;
    final bool isUnread = !item.isRead;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        onLongPress: isUnread ? onMarkAsRead : null,
        child: Ink(
          padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
          decoration: BoxDecoration(
            color: isSos ? const Color(0xFFFFF2F0) : Colors.transparent,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (isSos)
                Container(
                  width: 4,
                  height: 72,
                  margin: const EdgeInsets.only(right: 12, top: 2),
                  decoration: BoxDecoration(
                    color: AppSemanticColors.primary,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              if (!isSos) const SizedBox(width: 2),
              Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  _NotificationAvatar(item: item),
                  if (isUnread)
                    Positioned(
                      right: -2,
                      top: -2,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: BrandColors.primary400,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            item.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.heading6.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w700,
                              height: 1.25,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          item.timeLabel,
                          style: AppTextStyles.caption.copyWith(
                            color: AppSemanticColors.primary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.message,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.body2.copyWith(
                        color: AppSemanticColors.primary,
                        height: 1.35,
                      ),
                    ),
                  ],
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
    switch (item.type) {
      case NotificationItemType.sosAlert:
        return const _IconAvatar(
          size: 44,
          backgroundColor: AppSemanticColors.primary,
          icon: Icons.warning_amber_rounded,
          iconSize: 24,
          iconColor: Colors.white,
        );
      case NotificationItemType.locationVerified:
        return const _IconAvatar(
          size: 46,
          backgroundColor: Color(0xFFFFF2F0),
          icon: Icons.location_on_rounded,
          iconSize: 24,
          iconColor: AppSemanticColors.primary,
        );
      case NotificationItemType.palRequest:
      case NotificationItemType.placeSpotlight:
      case NotificationItemType.taggedYou:
        return Container(
          width: 46,
          height: 46,
          decoration: const BoxDecoration(
            color: NeutralColors.neutral100,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(2),
          child: ClipOval(
            child: Image.asset(
              item.imagePath!,
              fit: BoxFit.cover,
            ),
          ),
        );
    }
  }
}

class _IconAvatar extends StatelessWidget {
  final double size;
  final Color backgroundColor;
  final IconData icon;
  final double iconSize;
  final Color iconColor;

  const _IconAvatar({
    required this.size,
    required this.backgroundColor,
    required this.icon,
    required this.iconSize,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: iconSize,
        color: iconColor,
      ),
    );
  }
}
