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
      width: 238,
      height: 44,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
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
                        : AppSemanticColors.secondary,
                    borderRadius: BorderRadius.circular(24),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () => onSelected(item.id),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
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
