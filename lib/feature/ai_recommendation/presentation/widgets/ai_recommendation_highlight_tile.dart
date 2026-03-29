import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class AiRecommendationHighlightTile extends StatelessWidget {
  static const Color _iconBackground = Color(0xFFFCE9E6);
  static const Color _descriptionColor = Color(0xFF6A7B97);

  final String title;
  final String description;
  final String iconKey;
  final VoidCallback? onTap;

  const AiRecommendationHighlightTile({
    super.key,
    required this.title,
    required this.description,
    required this.iconKey,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: _iconBackground,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Center(child: _HighlightIcon(iconKey: iconKey)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: AppTextStyles.heading5.copyWith(
                        fontSize: 20,
                        height: 1.2,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      description,
                      style: AppTextStyles.body1.copyWith(
                        fontSize: 16,
                        height: 1.25,
                        color: _descriptionColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HighlightIcon extends StatelessWidget {
  final String iconKey;

  const _HighlightIcon({required this.iconKey});

  @override
  Widget build(BuildContext context) {
    return Icon(
      switch (iconKey) {
        'sparkles' => Icons.auto_awesome_rounded,
        'smile' => Icons.sentiment_satisfied_alt_rounded,
        _ => Icons.auto_awesome_rounded,
      },
      size: 24,
      color: AppColors.primary,
    );
  }
}
