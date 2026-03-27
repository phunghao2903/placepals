import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/notification_filter.dart';

class NotificationsFilterTabBar extends StatelessWidget {
  final List<NotificationFilter> filters;
  final ValueChanged<String> onSelected;

  const NotificationsFilterTabBar({
    super.key,
    required this.filters,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF3DFDB), width: 1)),
      ),
      child: Row(
        children: filters
            .map((filter) {
              return Padding(
                padding: EdgeInsets.only(
                  right: filter == filters.last ? 0 : 28,
                ),
                child: _FilterTab(
                  filter: filter,
                  onTap: () => onSelected(filter.id),
                ),
              );
            })
            .toList(growable: false),
      ),
    );
  }
}

class _FilterTab extends StatelessWidget {
  final NotificationFilter filter;
  final VoidCallback onTap;

  const _FilterTab({required this.filter, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: filter.isSelected
                    ? AppColors.primary
                    : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Text(
            filter.label,
            style: AppTextStyles.heading3.copyWith(
              color: filter.isSelected
                  ? AppColors.textPrimary
                  : AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}
