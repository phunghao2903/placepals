import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../domain/entities/ai_recommendation_feed.dart';
import '../bloc/ai_recommendation_bloc.dart';
import 'ai_ask_page.dart';
import '../widgets/ai_recommendation_highlight_tile.dart';

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
  static const Color _heroBackground = Color(0xFFF9DDD9);
  static const Color _heroCircle = Color(0xFFF8C9C3);
  static const Color _closeColor = Color(0xFF9C9493);

  final AiRecommendationFeed feed;

  const _AiRecommendationContent({
    required this.feed,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(25, 14, 25, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context).maybePop(),
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Icon(
                  Icons.close_rounded,
                  size: 22,
                  color: _closeColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const _AiHeroCard(),
          const SizedBox(height: 42),
          Padding(
            padding: const EdgeInsets.only(left: 14),
            child: SizedBox(
              width: 342,
              child: Text(
                feed.headline,
                maxLines: 2,
                style: AppTextStyles.heading2.copyWith(
                  fontSize: 30,
                  height: 1.1,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 44),
          ...List<Widget>.generate(feed.highlights.length, (index) {
            final item = feed.highlights[index];
            return Padding(
              padding: EdgeInsets.only(
                right: 8,
                bottom: index == feed.highlights.length - 1 ? 0 : 36,
              ),
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
                    : null,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _AiHeroCard extends StatelessWidget {
  const _AiHeroCard();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned.fill(
            top: 16,
            child: Container(
              decoration: BoxDecoration(
                color: _AiRecommendationContent._heroBackground,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 98,
              height: 98,
              decoration: const BoxDecoration(
                color: _AiRecommendationContent._heroCircle,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.map_outlined,
                  size: 42,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          Positioned(
            left: 115,
            bottom: 0,
            child: _HeroMiniTile(
              icon: Icons.groups_2_rounded,
            ),
          ),
          Positioned(
            right: 115,
            bottom: 0,
            child: _HeroMiniTile(
              icon: Icons.location_on_outlined,
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
      ),
      child: Icon(
        icon,
        size: 24,
        color: AppColors.primary,
      ),
    );
  }
}
