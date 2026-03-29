import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/sos_feed.dart';

class SosVisibilitySwitch extends StatelessWidget {
  final List<SosVisibilityScope> items;
  final ValueChanged<String> onSelected;

  const SosVisibilitySwitch({
    super.key,
    required this.items,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: NeutralColors.neutral100,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        children: items
            .map(
              (item) => Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: item == items.first ? 0 : 8,
                  ),
                  child: Material(
                    color: item.isSelected
                        ? AppSemanticColors.primary
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(999),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(999),
                      onTap: () => onSelected(item.id),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 9,
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              item.label,
                              maxLines: 1,
                              softWrap: false,
                              style: AppTextStyles.body1.copyWith(
                                color: item.isSelected
                                    ? Colors.white
                                    : AppSemanticColors.primary,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
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
