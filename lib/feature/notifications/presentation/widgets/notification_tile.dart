import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/notifications_feed.dart';

class NotificationTile extends StatelessWidget {
  final NotificationItem item;
  final VoidCallback onTap;

  const NotificationTile({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSos = item.type == 'help_sos';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
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
                  if (item.isUnread)
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

  const _NotificationAvatar({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    if (item.type == 'help_sos') {
      return Container(
        width: 44,
        height: 44,
        decoration: const BoxDecoration(
          color: AppSemanticColors.primary,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.warning_amber_rounded,
          size: 24,
          color: Colors.white,
        ),
      );
    }

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
          item.leadingAssetPath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
