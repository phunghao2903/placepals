import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../domain/entities/ai_recommendation_feed.dart';
import '../bloc/ai_recommendation_bloc.dart';
import '../widgets/ai_recommendation_highlight_tile.dart';
import 'ai_ask_page.dart';
import 'ai_trip_plan_page.dart';

class AiRecommendationPage extends StatelessWidget {
  const AiRecommendationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AiRecommendationBloc>(
      create: (_) =>
          getIt<AiRecommendationBloc>()..add(const AiRecommendationStarted()),
      child: const _AiRecommendationView(),
    );
  }
}

class _AiRecommendationView extends StatelessWidget {
  const _AiRecommendationView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<AiRecommendationBloc, AiRecommendationState>(
          builder: (context, state) {
            switch (state.status) {
              case AiRecommendationStatus.initial:
              case AiRecommendationStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case AiRecommendationStatus.failure:
                return Center(
                  child: Text(
                    state.errorMessage ?? 'Something went wrong.',
                    style: AppTextStyles.body2,
                  ),
                );
              case AiRecommendationStatus.success:
                final feed = state.feed;
                if (feed == null) {
                  return const SizedBox.shrink();
                }
                return _AiRecommendationContent(feed: feed);
            }
          },
        ),
      ),
    );
  }
}

class _AiRecommendationContent extends StatelessWidget {
  final AiRecommendationFeed feed;

  const _AiRecommendationContent({
    required this.feed,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: IconButton(
                onPressed: () => Navigator.of(context).maybePop(),
                icon: const Icon(
                  Icons.close_rounded,
                  color: Color(0xFF9C9493),
                  size: 24,
                ),
              ),
            ),
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: _AiHeroCard(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 30, 24, 0),
            child: Text(
              feed.headline,
              maxLines: 3,
              textAlign: TextAlign.center,
              style: AppTextStyles.heading2.copyWith(
                height: 1.15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: feed.highlights.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: AiRecommendationHighlightTile(
                    title: item.title,
                    description: item.description,
                    iconKey: item.iconKey,
                    onTap: item.id == 'ai-location'
                        ? () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => BlocProvider.value(
                                  value: context.read<AiRecommendationBloc>(),
                                  child: const AiAskPage(),
                                ),
                              ),
                            );
                          }
                        : item.id == 'trip-plan'
                            ? () {
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (_) => BlocProvider.value(
                                      value: context
                                          .read<AiRecommendationBloc>(),
                                      child: const AiTripPlanPage(),
                                    ),
                                  ),
                                );
                              }
                        : null,
                  ),
                );
              }).toList(growable: false),
            ),
          ),
        ],
      ),
    );
  }
}

class _AiHeroCard extends StatelessWidget {
  const _AiHeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 188,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0x33FF6B5A),
            Color(0x12FF6B5A),
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: 236,
            height: 122,
            decoration: BoxDecoration(
              color: const Color(0x40FF6B5A),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 20),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Image.asset(
                  AppAssets.logo,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            child: Row(
              children: const <Widget>[
                _HeroMiniTile(icon: Icons.groups_rounded),
                SizedBox(width: 12),
                _HeroMiniTile(icon: Icons.location_on_outlined),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroMiniTile extends StatelessWidget {
  final IconData icon;

  const _HeroMiniTile({
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Icon(icon, color: AppColors.primary, size: 22),
    );
  }
}
