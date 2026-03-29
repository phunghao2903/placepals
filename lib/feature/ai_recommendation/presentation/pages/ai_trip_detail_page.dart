import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../domain/entities/ai_recommendation_trip_itinerary_item.dart';
import '../bloc/ai_recommendation_bloc.dart';

class AiTripDetailPage extends StatelessWidget {
  const AiTripDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiRecommendationBloc, AiRecommendationState>(
      builder: (context, state) {
        final tripPlanner = state.feed?.tripPlanner;
        if (tripPlanner == null) {
          return const SizedBox.shrink();
        }

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8F6F5),
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFF3F4F6)),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.arrow_back_rounded),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_horiz_rounded),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          tripPlanner.detailTitle,
                          style: AppTextStyles.heading2.copyWith(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: <Widget>[
                            const Icon(
                              Icons.auto_awesome_rounded,
                              color: AppColors.primary,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              tripPlanner.detailSubtitle,
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 36,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: tripPlanner.dayChips.length,
                          separatorBuilder: (_, _) => const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            final isSelected = index == state.selectedTripDayIndex;
                            return GestureDetector(
                              onTap: () {
                                context.read<AiRecommendationBloc>().add(
                                      AiRecommendationTripDaySelected(
                                        dayIndex: index,
                                      ),
                                    );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.textPrimary
                                      : const Color(0xFFFCFAFA),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  tripPlanner.dayChips[index],
                                  style: AppTextStyles.body2.copyWith(
                                    color: isSelected
                                        ? Colors.white
                                        : AppColors.textPrimary,
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
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                    itemCount: tripPlanner.itinerary.length,
                    itemBuilder: (context, index) {
                      final item = tripPlanner.itinerary[index];
                      return _TripTimelineItem(
                        item: item,
                        isFirst: index == 0,
                        isLast: index == tripPlanner.itinerary.length - 1,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
            decoration: const BoxDecoration(
              color: Color(0xCCFFFFFF),
              border: Border(top: BorderSide(color: Color(0xFFF3F4F6))),
            ),
            child: SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  tripPlanner.detailActionLabel,
                  style: AppTextStyles.body1.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TripTimelineItem extends StatelessWidget {
  final AiRecommendationTripItineraryItem item;
  final bool isFirst;
  final bool isLast;

  const _TripTimelineItem({
    required this.item,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            width: 24,
            child: Column(
              children: <Widget>[
                if (!isFirst)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: const Color(0xFFE5E7EB),
                    ),
                  ),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: isFirst
                        ? AppColors.primary
                        : const Color(0xFFD1D5DB),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: const Color(0xFFE5E7EB),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 12,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          child: SizedBox(
                            height: 184,
                            width: double.infinity,
                            child: Image.asset(item.imagePath, fit: BoxFit.cover),
                          ),
                        ),
                        Positioned(
                          top: 12,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xE6FFFFFF),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              item.timeLabel,
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
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
                                      item.title,
                                      style: AppTextStyles.heading3,
                                    ),
                                    const SizedBox(height: 2),
                                    Row(
                                      children: <Widget>[
                                        const Icon(
                                          Icons.location_on_outlined,
                                          size: 14,
                                          color: AppColors.textSecondary,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          item.locationLabel,
                                          style: AppTextStyles.body2,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.more_vert_rounded,
                                color: Color(0xFF9CA3AF),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          _InsightBox(
                            icon: Icons.favorite_border_rounded,
                            title: item.whyTitle,
                            description: item.whyDescription,
                          ),
                          const SizedBox(height: 8),
                          _InsightBox(
                            icon: Icons.restaurant_menu_rounded,
                            title: item.tipTitle,
                            description: item.tipDescription,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: AppColors.textPrimary,
                                    side: const BorderSide(
                                      color: Color(0xFFF4F1F0),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.map_outlined,
                                    size: 16,
                                  ),
                                  label: const Text('Map'),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.textPrimary,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: const Text('Details'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InsightBox extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _InsightBox({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0x0DFA7C70),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0x1AFA7C70)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Icon(icon, color: AppColors.primary, size: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: AppTextStyles.body2.copyWith(
                  color: const Color(0xFF5C403D),
                  height: 1.35,
                ),
                children: <InlineSpan>[
                  TextSpan(
                    text: '$title ',
                    style: AppTextStyles.heading7.copyWith(fontSize: 14),
                  ),
                  TextSpan(text: description),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
