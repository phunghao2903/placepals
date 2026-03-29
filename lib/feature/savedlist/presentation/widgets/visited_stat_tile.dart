import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/savedlist_feed.dart';

class VisitedStatTile extends StatelessWidget {
  final VisitedStat stat;

  const VisitedStatTile({
    super.key,
    required this.stat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEFEAE9)),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Text(
            stat.value,
            style: AppTextStyles.heading2.copyWith(
              fontSize: 28,
              color: stat.accentColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            stat.label,
            style: AppTextStyles.body2.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
