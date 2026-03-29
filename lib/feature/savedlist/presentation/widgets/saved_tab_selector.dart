import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/savedlist_feed.dart';

class SavedTabSelector extends StatelessWidget {
  final List<SavedTab> tabs;
  final SavedTabType activeTab;
  final ValueChanged<SavedTabType> onTabChanged;

  const SavedTabSelector({
    super.key,
    required this.tabs,
    required this.activeTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: tabs
            .map(
              (tab) => Expanded(
                child: GestureDetector(
                  onTap: () => onTabChanged(tab.type),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: activeTab == tab.type
                          ? Colors.white
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: activeTab == tab.type
                          ? const <BoxShadow>[
                              BoxShadow(
                                color: Color(0x12000000),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ]
                          : const <BoxShadow>[],
                    ),
                    child: Text(
                      tab.label,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body1.copyWith(
                        color: activeTab == tab.type
                            ? AppColors.primary
                            : AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(growable: false),
      ),
    );
  }
}
