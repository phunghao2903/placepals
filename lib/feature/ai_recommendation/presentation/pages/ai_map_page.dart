import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../domain/entities/ai_recommendation_map_pick.dart';
import '../bloc/ai_recommendation_bloc.dart';
import '../widgets/ai_screen_header.dart';
import 'ai_compare_page.dart';

class AiMapPage extends StatelessWidget {
  const AiMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final feed = context.read<AiRecommendationBloc>().state.feed;
    if (feed == null) {
      return const SizedBox.shrink();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                'assets/images/map.png',
                fit: BoxFit.cover,
              ),
            ),
            const Positioned.fill(child: ColoredBox(color: Color(0x12FFFFFF))),
            Positioned(
              top: 10,
              left: 12,
              child: AiCircleIconButton(
                icon: Icons.arrow_back_rounded,
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
            Positioned(
              top: 10,
              right: 12,
              child: const AiCircleIconButton(icon: Icons.tune_rounded),
            ),
            Positioned(
              top: 14,
              left: 74,
              right: 74,
              child: Column(
                children: <Widget>[
                  _HeaderPill(label: feed.mapTitle),
                  const SizedBox(height: 10),
                  _HeaderPill(
                    label: feed.mapRefineLabel,
                    leading: Icons.auto_awesome_outlined,
                  ),
                ],
              ),
            ),
            const Positioned(
              left: 36,
              top: 280,
              child: _MapMarker(label: '', isCurrentLocation: true),
            ),
            const Positioned(
              left: 90,
              top: 154,
              child: _MapMarker(label: 'B'),
            ),
            Positioned(
              right: 94,
              top: 178,
              child: Column(
                children: <Widget>[
                  const _MatchMarker(),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Color(0x1A000000),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      feed.mapCenterMatchLabel,
                      style: AppTextStyles.body2.copyWith(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              right: 22,
              top: 304,
              child: _MapMarker(label: 'C'),
            ),
            Positioned(
              right: 16,
              bottom: 250,
              child: AiCircleIconButton(
                icon: Icons.navigation_outlined,
                size: 54,
                iconSize: 24,
                backgroundColor: const Color(0xFF2D2D2D),
                iconColor: Colors.white,
                boxShadow: const <BoxShadow>[],
                onTap: () {},
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 24),
                decoration: const BoxDecoration(
                  color: Color(0xFFFDF9F8),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Container(
                        width: 58,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0E6E3),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 18, 18, 12),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              feed.mapSheetTitle,
                              style: AppTextStyles.heading5.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.auto_awesome_outlined,
                            color: AppColors.primary,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    ...feed.mapPicks.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                      return Padding(
                        padding: EdgeInsets.fromLTRB(
                          18,
                          0,
                          18,
                          index == feed.mapPicks.length - 1 ? 0 : 14,
                        ),
                        child: _MapPickCard(
                          item: item,
                          isTopCard: index == 0,
                          onTap: index == 0
                              ? () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                      builder: (_) => BlocProvider.value(
                                        value:
                                            context.read<AiRecommendationBloc>(),
                                        child: const AiComparePage(),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderPill extends StatelessWidget {
  final String label;
  final IconData? leading;

  const _HeaderPill({
    required this.label,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (leading != null) ...<Widget>[
            Icon(leading, color: AppColors.primary, size: 18),
            const SizedBox(width: 8),
          ],
          Text(
            label,
            style: AppTextStyles.heading5.copyWith(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class _MapMarker extends StatelessWidget {
  final String label;
  final bool isCurrentLocation;

  const _MapMarker({
    required this.label,
    this.isCurrentLocation = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isCurrentLocation) {
      return Container(
        width: 54,
        height: 54,
        decoration: const BoxDecoration(
          color: Color(0x33498CFF),
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: CircleAvatar(
            radius: 7,
            backgroundColor: Color(0xFF4B88FF),
          ),
        ),
      );
    }

    return Container(
      width: 34,
      height: 34,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          label,
          style: AppTextStyles.heading7.copyWith(fontSize: 14),
        ),
      ),
    );
  }
}

class _MatchMarker extends StatelessWidget {
  const _MatchMarker();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 74,
      height: 74,
      decoration: const BoxDecoration(
        color: Color(0x40FF6B5A),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          width: 56,
          height: 56,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.star_border_rounded,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}

class _MapPickCard extends StatelessWidget {
  final AiRecommendationMapPick item;
  final bool isTopCard;
  final VoidCallback? onTap;

  const _MapPickCard({
    required this.item,
    required this.isTopCard,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: isTopCard
                ? Border.all(color: const Color(0xFFF7C4BE))
                : null,
          ),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: isTopCard ? 78 : 60,
                  height: isTopCard ? 78 : 60,
                  child: Image.asset(item.imagePath, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        if (item.badgeLabel != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: item.badgeLabel == 'Best Match'
                                  ? AppColors.primary
                                  : const Color(0xFFF1ECEB),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              item.badgeLabel!,
                              style: AppTextStyles.heading8.copyWith(
                                fontSize: 10,
                                color: item.badgeLabel == 'Best Match'
                                    ? Colors.white
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ),
                        if (item.highlightLabel != null) ...<Widget>[
                          const SizedBox(width: 8),
                          Text(
                            item.highlightLabel!,
                            style: AppTextStyles.body2.copyWith(fontSize: 14),
                          ),
                        ],
                        const Spacer(),
                        const Icon(
                          Icons.star_rounded,
                          color: AppColors.warning,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          item.rating.toStringAsFixed(1),
                          style: AppTextStyles.heading7.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.title,
                      style: AppTextStyles.heading5.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.subtitle.replaceAll('â€¢', '-').replaceAll('•', '-'),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.body2.copyWith(
                        color: const Color(0xFFA29594),
                      ),
                    ),
                  ],
                ),
              ),
              if (isTopCard)
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFFCFC3C1),
                    size: 26,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
