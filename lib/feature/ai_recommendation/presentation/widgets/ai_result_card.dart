import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/ai_recommendation_result_item.dart';
import '../../domain/entities/ai_recommendation_result_tag.dart';

class AiResultCard extends StatelessWidget {
  final AiRecommendationResultItem item;
  final VoidCallback? onTap;

  const AiResultCard({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x14FF6B5A),
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _ResultImage(item: item),
              const SizedBox(width: 14),
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
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.heading4.copyWith(
                              fontSize: 15,
                              height: 1.1,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1ECEB),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: <Widget>[
                              const Icon(
                                Icons.star_rounded,
                                size: 18,
                                color: AppColors.warning,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                item.rating.toStringAsFixed(1),
                                style: AppTextStyles.heading7.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.body2.copyWith(
                        fontSize: 12.5,
                        height: 1.2,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      child: Row(
                        children: item.tags
                            .map(
                              (tag) => Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: _ResultTagChip(tag: tag),
                              ),
                            )
                            .toList(growable: false),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item.metaLine
                          .replaceAll('Â·', '-')
                          .replaceAll('â€¢', '-'),
                      style: AppTextStyles.body1.copyWith(
                        fontSize: 12.5,
                        color: AppColors.textSecondary,
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

class _ResultImage extends StatelessWidget {
  final AiRecommendationResultItem item;

  const _ResultImage({required this.item});

  @override
  Widget build(BuildContext context) {
    final badgeColor = item.id == 'leaf-latte'
        ? const Color(0xFF333333)
        : AppColors.primary;

    return SizedBox(
      width: 98,
      height: 98,
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Image.asset(
              item.imagePath,
              width: 98,
              height: 98,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 6,
            top: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(17),
              ),
              child: Text(
                item.matchLabel,
                style: AppTextStyles.heading8.copyWith(
                  fontSize: 9.5,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultTagChip extends StatelessWidget {
  final AiRecommendationResultTag tag;

  const _ResultTagChip({required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFF1ECEB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            switch (tag.iconKey) {
              'power' => Icons.power_rounded,
              'wifi' => Icons.wifi_rounded,
              'mute' => Icons.volume_off_rounded,
              'chair' => Icons.weekend_outlined,
              'tree' => Icons.park_rounded,
              'sun' => Icons.light_mode_rounded,
              'coffee' => Icons.local_cafe_outlined,
              _ => Icons.circle,
            },
            size: 16,
            color: AppColors.primary,
          ),
          const SizedBox(width: 5),
          Text(
            tag.label,
            style: AppTextStyles.body2.copyWith(
              fontSize: 11.5,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
