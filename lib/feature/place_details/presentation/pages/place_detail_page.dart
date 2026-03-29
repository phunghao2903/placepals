import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../bloc/place_details_bloc.dart';
import '../widgets/place_feature_chip.dart';
import '../widgets/place_icon_circle_button.dart';
import '../widgets/place_map_snippet_card.dart';
import '../widgets/place_review_preview_card.dart';
import 'place_comment_page.dart';
import 'place_map_page.dart';
import 'place_review_page.dart';

class PlaceDetailPage extends StatelessWidget {
  const PlaceDetailPage({super.key});

  void _openMapPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider.value(
          value: context.read<PlaceDetailsBloc>(),
          child: const PlaceMapPage(),
        ),
      ),
    );
  }

  void _openCommentPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider.value(
          value: context.read<PlaceDetailsBloc>(),
          child: const PlaceCommentPage(),
        ),
      ),
    );
  }

  void _openReviewPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider.value(
          value: context.read<PlaceDetailsBloc>(),
          child: const PlaceReviewPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceDetailsBloc, PlaceDetailsState>(
      builder: (context, state) {
        switch (state.status) {
          case PlaceDetailsStatus.initial:
          case PlaceDetailsStatus.loading:
            return const Scaffold(
              backgroundColor: Color(0xFFFCF9F8),
              body: Center(child: CircularProgressIndicator()),
            );
          case PlaceDetailsStatus.failure:
            return Scaffold(
              backgroundColor: const Color(0xFFFCF9F8),
              body: Center(
                child: Text(
                  state.errorMessage ?? 'Something went wrong.',
                  style: AppTextStyles.body2,
                ),
              ),
            );
          case PlaceDetailsStatus.success:
            final detail = state.feed!.detail;
            return Scaffold(
              backgroundColor: const Color(0xFFFCF9F8),
              body: Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 530,
                          width: double.infinity,
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              Image.asset(detail.heroImagePath, fit: BoxFit.cover),
                              const DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: <Color>[
                                      Color(0x00FCF9F8),
                                      Color(0x00FCF9F8),
                                      Color(0xFFFCF9F8),
                                    ],
                                    stops: <double>[0, .5, 1],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 24,
                                right: 24,
                                bottom: 32,
                                child: _GlassSummaryCard(
                                  statusLabel: detail.statusLabel,
                                  rating: detail.rating,
                                  title: detail.title,
                                  locationLabel: detail.locationLabel,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                detail.aboutTitle,
                                style: AppTextStyles.heading5.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                detail.aboutDescription,
                                style: AppTextStyles.body1.copyWith(
                                  color: AppColors.textPrimary,
                                  height: 28 / 16,
                                ),
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                height: 64,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: detail.tags.length,
                                  separatorBuilder: (_, _) =>
                                      const SizedBox(width: 18),
                                  itemBuilder: (context, index) {
                                    return PlaceFeatureChip(tag: detail.tags[index]);
                                  },
                                ),
                              ),
                              const SizedBox(height: 40),
                              PlaceMapSnippetCard(
                                data: detail.mapSnippet,
                                onDirectionsTap: () => _openMapPage(context),
                              ),
                              const SizedBox(height: 40),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      detail.reviewsTitle,
                                      style: AppTextStyles.heading5.copyWith(
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => _openReviewPage(context),
                                    style: TextButton.styleFrom(
                                      foregroundColor: AppColors.primary,
                                      padding: EdgeInsets.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      minimumSize: Size.zero,
                                    ),
                                    child: Text(
                                      detail.reviewsActionLabel,
                                      style: AppTextStyles.heading7.copyWith(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              ...detail.previewReviews.map((review) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 24),
                                  child: PlaceReviewPreviewCard(
                                    review: review,
                                    onTap: () => _openCommentPage(context),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 18,
                    left: 0,
                    right: 0,
                    child: _PlaceTopBar(title: detail.headerTitle),
                  ),
                ],
              ),
            );
        }
      },
    );
  }
}

class _PlaceTopBar extends StatelessWidget {
  final String title;

  const _PlaceTopBar({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Container(
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            color: Colors.white.withValues(alpha: 0.70),
            child: Row(
              children: <Widget>[
                PlaceIconCircleButton(
                  icon: Icons.arrow_back_rounded,
                  size: 40,
                  iconSize: 16,
                  backgroundColor: Colors.transparent,
                  boxShadow: const <BoxShadow>[],
                  iconColor: AppColors.primary,
                  onTap: () => Navigator.of(context).pop(),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      title,
                      style: AppTextStyles.heading3.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                const PlaceIconCircleButton(
                  icon: Icons.favorite_border_rounded,
                  size: 40,
                  iconSize: 18,
                  backgroundColor: Colors.transparent,
                  boxShadow: <BoxShadow>[],
                  iconColor: AppColors.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GlassSummaryCard extends StatelessWidget {
  final String statusLabel;
  final double rating;
  final String title;
  final String locationLabel;

  const _GlassSummaryCard({
    required this.statusLabel,
    required this.rating,
    required this.title,
    required this.locationLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x0FAB332A),
            blurRadius: 40,
            offset: Offset(0, 24),
            spreadRadius: -4,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(24),
            color: Colors.white.withValues(alpha: 0.70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        statusLabel,
                        style: AppTextStyles.heading8.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.star_rounded,
                      size: 12,
                      color: AppColors.warning,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      rating.toStringAsFixed(1),
                      style: AppTextStyles.heading7.copyWith(
                        color: AppColors.warning,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: AppTextStyles.heading1.copyWith(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: AppColors.textPrimary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      locationLabel,
                      style: AppTextStyles.heading7.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
