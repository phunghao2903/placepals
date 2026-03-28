import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../bloc/ai_recommendation_bloc.dart';
import 'ai_trip_detail_page.dart';

class AiTripPlaceInformationPage extends StatelessWidget {
  const AiTripPlaceInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AiRecommendationBloc>();
    final tripPlace = bloc.state.feed?.tripPlanner.placeDetail;
    if (tripPlace == null) {
      return const SizedBox.shrink();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(30),
                        ),
                        child: SizedBox(
                          height: 320,
                          width: double.infinity,
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              Image.asset(
                                tripPlace.headerImagePath,
                                fit: BoxFit.cover,
                              ),
                              const DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: <Color>[
                                      Color(0x99000000),
                                      Color(0x00000000),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: <Widget>[
                              _DarkCircleButton(
                                icon: Icons.arrow_back_rounded,
                                onTap: () => Navigator.of(context).pop(),
                              ),
                              const Spacer(),
                              _DarkCircleButton(
                                icon: Icons.favorite_border_rounded,
                                onTap: () {},
                              ),
                              const SizedBox(width: 12),
                              _DarkCircleButton(
                                icon: Icons.share_outlined,
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Transform.translate(
                    offset: const Offset(0, -32),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(21),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: const Color(0xFFFCFAFA)),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                  color: Color(0x0D000000),
                                  blurRadius: 10,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            tripPlace.title,
                                            style: AppTextStyles.heading2,
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: <Widget>[
                                              const Icon(
                                                Icons.location_on_outlined,
                                                size: 16,
                                                color: AppColors.textSecondary,
                                              ),
                                              const SizedBox(width: 4),
                                              Expanded(
                                                child: Text(
                                                  tripPlace.subtitle,
                                                  style: AppTextStyles.body2,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF9FAFB),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            tripPlace.rating.toStringAsFixed(1),
                                            style: AppTextStyles.heading3
                                                .copyWith(
                                              color: AppColors.primary,
                                            ),
                                          ),
                                          Text(
                                            'RATING',
                                            style: AppTextStyles.caption.copyWith(
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: tripPlace.tags.map((tag) {
                                    return _TripTagChip(label: tag);
                                  }).toList(growable: false),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              const Icon(
                                Icons.auto_awesome_rounded,
                                color: AppColors.primary,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                tripPlace.vibeTitle,
                                style: AppTextStyles.heading5.copyWith(
                                  fontSize: 18,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0x1AFF6B5A),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  tripPlace.vibeBadgeLabel,
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(21),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0x33FF6B5A),
                              ),
                            ),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Based on 1.2k+ reviews',
                                            style: AppTextStyles.caption,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            tripPlace.vibeSummary,
                                            style: AppTextStyles.body2.copyWith(
                                              color: AppColors.textPrimary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 56,
                                      height: 56,
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: <Widget>[
                                          CircularProgressIndicator(
                                            value: 0.9,
                                            strokeWidth: 4,
                                            backgroundColor:
                                                const Color(0xFFFFE4DE),
                                            valueColor:
                                                const AlwaysStoppedAnimation<
                                                    Color>(
                                              AppColors.primary,
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                              tripPlace.vibeScoreLabel,
                                              style: AppTextStyles.heading7
                                                  .copyWith(
                                                color: AppColors.textPrimary,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 18),
                                _AnalysisCard(
                                  title: tripPlace.positiveTitle,
                                  description: tripPlace.positiveDescription,
                                  foregroundColor: const Color(0xFF22C55E),
                                  backgroundColor: const Color(0xFFF0FDF4),
                                  icon: Icons.thumb_up_alt_outlined,
                                ),
                                const SizedBox(height: 12),
                                _AnalysisCard(
                                  title: tripPlace.cautionTitle,
                                  description: tripPlace.cautionDescription,
                                  foregroundColor: const Color(0xFFEF4444),
                                  backgroundColor: const Color(0xFFF4F1F0),
                                  icon: Icons.info_outline_rounded,
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: <Widget>[
                                    const Icon(
                                      Icons.shield_outlined,
                                      size: 14,
                                      color: Color(0xFF666666),
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        tripPlace.filteredLabel,
                                        style: AppTextStyles.caption.copyWith(
                                          color: const Color(0xFF666666),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      tripPlace.updatedLabel,
                                      style: AppTextStyles.caption.copyWith(
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            tripPlace.aboutTitle,
                            style: AppTextStyles.heading5.copyWith(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            tripPlace.aboutDescription,
                            style: AppTextStyles.body2.copyWith(
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                tripPlace.aboutActionLabel,
                                style: AppTextStyles.body2.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                              const Icon(
                                Icons.expand_more_rounded,
                                color: AppColors.primary,
                                size: 16,
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  tripPlace.photosTitle,
                                  style: AppTextStyles.heading5.copyWith(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Text(
                                tripPlace.photosActionLabel,
                                style: AppTextStyles.body2.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: List<Widget>.generate(
                              tripPlace.photoPaths.length,
                              (index) {
                                final isLast =
                                    index == tripPlace.photoPaths.length - 1;
                                return Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      right: isLast ? 0 : 8,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: SizedBox(
                                        height: 96,
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: <Widget>[
                                            Image.asset(
                                              tripPlace.photoPaths[index],
                                              fit: BoxFit.cover,
                                            ),
                                            if (isLast)
                                              Container(
                                                color: const Color(0x66000000),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '+42',
                                                  style: AppTextStyles.body1
                                                      .copyWith(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
        decoration: const BoxDecoration(
          color: Color(0xF2FFFFFF),
          border: Border(top: BorderSide(color: Color(0xFFFCFAFA))),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textPrimary,
                  side: const BorderSide(color: Color(0xFFE5E7EB)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                icon: const Icon(Icons.map_outlined, size: 18),
                label: Text(tripPlace.mapButtonLabel),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => BlocProvider.value(
                        value: bloc,
                        child: const AiTripDetailPage(),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: Text(tripPlace.addButtonLabel),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DarkCircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _DarkCircleButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: Color(0x4D000000),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }
}

class _TripTagChip extends StatelessWidget {
  final String label;

  const _TripTagChip({
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = switch (label) {
      'Specialty Coffee' => const Color(0xFFFFF4F2),
      'Quiet' => const Color(0xFFEFF6FF),
      _ => const Color(0xFFF0FDF4),
    };
    final foregroundColor = switch (label) {
      'Specialty Coffee' => AppColors.primary,
      'Quiet' => const Color(0xFF3B82F6),
      _ => const Color(0xFF22C55E),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(color: foregroundColor),
      ),
    );
  }
}

class _AnalysisCard extends StatelessWidget {
  final String title;
  final String description;
  final Color foregroundColor;
  final Color backgroundColor;
  final IconData icon;

  const _AnalysisCard({
    required this.title,
    required this.description,
    required this.foregroundColor,
    required this.backgroundColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Icon(icon, color: foregroundColor, size: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: AppTextStyles.caption.copyWith(
                    color: foregroundColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppTextStyles.body2.copyWith(
                    color: foregroundColor,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
