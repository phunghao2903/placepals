import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../domain/entities/place_details_feed.dart';
import '../bloc/place_details_bloc.dart';
import '../widgets/place_icon_circle_button.dart';

class PlaceReviewPage extends StatelessWidget {
  const PlaceReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceDetailsBloc, PlaceDetailsState>(
      builder: (context, state) {
        final feed = state.feed;
        if (feed == null) {
          return const SizedBox.shrink();
        }

        final PlaceReviewInsightsData review = feed.reviewInsights;

        return Scaffold(
          backgroundColor: const Color(0xFFFCF9F8),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(14, 6, 14, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 6, 4, 10),
                    child: Row(
                      children: <Widget>[
                        PlaceIconCircleButton(
                          icon: Icons.arrow_back_rounded,
                          onTap: () => Navigator.of(context).pop(),
                        ),
                        Expanded(
                          child: Text(
                            review.title,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.heading5.copyWith(fontSize: 18),
                          ),
                        ),
                        const PlaceIconCircleButton(
                          icon: Icons.help_outline_rounded,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFF1E7E4)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    review.summaryTitle,
                                    style:
                                        AppTextStyles.body2.copyWith(fontSize: 14),
                                  ),
                                  const SizedBox(height: 4),
                                  RichText(
                                    text: TextSpan(
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text: review.sentimentValue,
                                          style: AppTextStyles.heading2.copyWith(
                                            fontSize: 32,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' ${review.sentimentLabel}',
                                          style: AppTextStyles.heading5.copyWith(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    review.basedOnLabel,
                                    style:
                                        AppTextStyles.body2.copyWith(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 42,
                              height: 42,
                              decoration: const BoxDecoration(
                                color: Color(0x1FFF6B5A),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.auto_awesome_rounded,
                                color: AppColors.primary,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ...review.breakdowns.map(_BreakdownRow.new),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  Text(review.themesTitle, style: AppTextStyles.heading5),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: review.themes.map((theme) {
                      final bool isPrimary = theme == 'Great Service';
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isPrimary
                              ? const Color(0xFFFFF1EE)
                              : const Color(0xFFF5F1F0),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: isPrimary
                                ? const Color(0xFFF8C5BE)
                                : Colors.transparent,
                          ),
                        ),
                        child: Text(
                          theme,
                          style: AppTextStyles.body2.copyWith(
                            fontSize: 14,
                            color: isPrimary
                                ? AppColors.primary
                                : AppColors.textPrimary,
                          ),
                        ),
                      );
                    }).toList(growable: false),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFF7C4BE)),
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Color(0x1FFF6B5A),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.psychology_alt_outlined,
                            color: AppColors.primary,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                review.transparencyTitle,
                                style: AppTextStyles.heading7.copyWith(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                review.transparencySubtitle,
                                style:
                                    AppTextStyles.body2.copyWith(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: state.isTransparencyEnabled,
                          onChanged: (_) {
                            context.read<PlaceDetailsBloc>().add(
                                  const PlaceDetailsTransparencyToggled(),
                                );
                          },
                          activeThumbColor: Colors.white,
                          activeTrackColor: const Color(0xFFFF8F82),
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: const Color(0xFFE5DDDB),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          review.recentReviewsTitle,
                          style: AppTextStyles.heading5,
                        ),
                      ),
                      Text(
                        review.sortLabel,
                        style: AppTextStyles.body2.copyWith(
                          fontSize: 14,
                          color: AppColors.primary,
                        ),
                      ),
                      const Icon(
                        Icons.expand_more_rounded,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...review.reviews.map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: _ReviewCard(
                        item: item,
                        isTransparencyEnabled: state.isTransparencyEnabled,
                        isRevealed: state.isHiddenReviewRevealed,
                        onReveal: () {
                          context.read<PlaceDetailsBloc>().add(
                                const PlaceDetailsHiddenReviewRevealToggled(),
                              );
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _BreakdownRow extends StatelessWidget {
  final PlaceReviewBreakdown item;

  const _BreakdownRow(this.item);

  @override
  Widget build(BuildContext context) {
    final Color color = switch (item.label) {
      'Love' => AppColors.primary,
      'Normal' => const Color(0xFF9E9796),
      _ => const Color(0xFF2D3342),
    };

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 56,
            child: Text(
              item.label,
              style: AppTextStyles.body2.copyWith(
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                minHeight: 6,
                value: item.progress,
                backgroundColor: const Color(0xFFF0E8E6),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            item.valueLabel,
            style: AppTextStyles.body2.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final PlaceReviewItem item;
  final bool isTransparencyEnabled;
  final bool isRevealed;
  final VoidCallback onReveal;

  const _ReviewCard({
    required this.item,
    required this.isTransparencyEnabled,
    required this.isRevealed,
    required this.onReveal,
  });

  @override
  Widget build(BuildContext context) {
    if (item.isHidden) {
      final bool canShowReason = isTransparencyEnabled || isRevealed;
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFF1E7E4)),
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(
                  Icons.visibility_off_outlined,
                  color: Color(0xFF9E9796),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.hiddenTitle ?? '',
                        style: AppTextStyles.heading7.copyWith(fontSize: 16),
                      ),
                      Text(
                        item.hiddenSubtitle ?? '',
                        style: AppTextStyles.body2.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: onReveal,
                  child: Text(
                    isRevealed ? 'HIDE' : (item.actionLabel ?? ''),
                    style: AppTextStyles.heading7.copyWith(
                      fontSize: 14,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            if (canShowReason) ...<Widget>[
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBFA),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFF0E8E6)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.flaggedTitle ?? '',
                      style: AppTextStyles.heading7.copyWith(fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.flaggedDescription ?? '',
                      style: AppTextStyles.body2.copyWith(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF1E7E4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                radius: 20,
                backgroundColor: const Color(0xFFF4ECEA),
                child: Text(
                  item.initials,
                  style: AppTextStyles.heading7.copyWith(fontSize: 14),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.author ?? '',
                      style: AppTextStyles.heading7.copyWith(fontSize: 18),
                    ),
                    Text(
                      item.meta ?? '',
                      style: AppTextStyles.body2.copyWith(fontSize: 13),
                    ),
                  ],
                ),
              ),
              Row(
                children: List<Widget>.generate(5, (index) {
                  return Icon(
                    index < item.rating
                        ? Icons.star_rounded
                        : Icons.star_outline_rounded,
                    size: 16,
                    color: index < item.rating
                        ? AppColors.primary
                        : const Color(0xFFE5DDDB),
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            item.content ?? '',
            style: AppTextStyles.body1.copyWith(
              fontSize: 16,
              color: AppColors.textPrimary,
            ),
          ),
          if (item.tags.isNotEmpty) ...<Widget>[
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: item.tags.map((tag) {
                final bool isHelpful = tag == 'Helpful';
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isHelpful
                        ? const Color(0xFFEFFDF4)
                        : const Color(0xFFF5F1F0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    tag,
                    style: AppTextStyles.body2.copyWith(
                      fontSize: 13,
                      color: isHelpful
                          ? const Color(0xFF22C55E)
                          : AppColors.textPrimary,
                    ),
                  ),
                );
              }).toList(growable: false),
            ),
          ],
        ],
      ),
    );
  }
}
