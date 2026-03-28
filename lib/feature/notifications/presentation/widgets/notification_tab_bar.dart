import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/notification_filter.dart';

class NotificationTabBar extends StatelessWidget {
  final List<NotificationFilter> filters;
  final ValueChanged<String> onSelected;

  const NotificationTabBar({
    super.key,
    required this.filters,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFFFE8E3))),
      ),
      child: Row(
        children: filters
            .map((filter) {
              final isSelected = filter.isSelected;
              return Padding(
                padding: EdgeInsets.only(
                  left: filter == filters.first ? 14 : 20,
                  right: filter == filters.last ? 14 : 0,
                ),
                child: InkWell(
                  onTap: () => onSelected(filter.id),
                  borderRadius: BorderRadius.circular(999),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        filter.label,
                        style: AppTextStyles.heading3.copyWith(
                          color: isSelected
                              ? AppColors.textPrimary
                              : AppColors.primary,
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        curve: Curves.easeOut,
                        width: filter.label == 'SOS Alerts' ? 72 : 28,
                        height: 3,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            })
            .toList(growable: false),
      ),
    );
  }
}
