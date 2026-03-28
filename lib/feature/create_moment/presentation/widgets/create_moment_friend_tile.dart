import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/create_moment_friend.dart';

class CreateMomentFriendTile extends StatelessWidget {
  final CreateMomentFriend friend;
  final bool isSelected;
  final VoidCallback onTap;

  const CreateMomentFriendTile({
    super.key,
    required this.friend,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final initials = friend.name
        .split(' ')
        .where((part) => part.isNotEmpty)
        .take(2)
        .map((part) => part[0])
        .join();

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.transparent,
              width: 1.2,
            ),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              _FriendAvatar(
                initials: initials,
                avatarPath: friend.avatarPath,
                colorSeed: friend.id.hashCode,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      friend.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.body1.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      friend.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.body2.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.border,
                  ),
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check_rounded,
                        color: SemanticTextColors.onBrand,
                        size: 16,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FriendAvatar extends StatelessWidget {
  final String initials;
  final String? avatarPath;
  final int colorSeed;

  const _FriendAvatar({
    required this.initials,
    required this.avatarPath,
    required this.colorSeed,
  });

  @override
  Widget build(BuildContext context) {
    if (avatarPath != null) {
      return ClipOval(
        child: Image.asset(
          avatarPath!,
          width: 48,
          height: 48,
          fit: BoxFit.cover,
        ),
      );
    }

    final palette = <Color>[
      const Color(0xFFFFD8D2),
      const Color(0xFFFFEDCC),
      const Color(0xFFDDEAFE),
      const Color(0xFFE7D9FF),
      const Color(0xFFD9F7E5),
    ];
    final background = palette[colorSeed.abs() % palette.length];

    return Container(
      width: 48,
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: background, shape: BoxShape.circle),
      child: Text(
        initials,
        style: AppTextStyles.body2.copyWith(color: AppColors.textPrimary),
      ),
    );
  }
}
