import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../bloc/ai_recommendation_bloc.dart';
import '../widgets/ai_screen_header.dart';
import 'ai_location_detail_page.dart';

class AiTopPickPage extends StatelessWidget {
  const AiTopPickPage({super.key});

  @override
  Widget build(BuildContext context) {
    final feed = context.read<AiRecommendationBloc>().state.feed;
    if (feed == null) {
      return const SizedBox.shrink();
    }

    final pick = feed.topPick;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFBFA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 6, 18, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AiScreenHeader(
                title: 'Your Top Pick',
                onBack: () => Navigator.of(context).pop(),
                trailing: const AiCircleIconButton(icon: Icons.tune_rounded),
                padding: const EdgeInsets.fromLTRB(0, 6, 0, 8),
              ),
              const SizedBox(height: 10),
              Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: SizedBox(
                      height: 440,
                      width: double.infinity,
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          Image.asset(pick.imagePath, fit: BoxFit.cover),
                          const DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: <Color>[
                                  Color(0x14000000),
                                  Color(0xAA000000),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.workspace_premium_outlined,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            pick.matchLabel,
                            style: AppTextStyles.heading6.copyWith(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 28,
                    right: 28,
                    bottom: 28,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          pick.title,
                          style: AppTextStyles.heading1.copyWith(
                            fontSize: 36,
                            height: 1.08,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            const Icon(
                              Icons.music_note_rounded,
                              color: Color(0xFFFF8F82),
                              size: 14,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${pick.category} - ${pick.distanceLabel} - ${pick.priceLabel}',
                              style: AppTextStyles.body1.copyWith(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(color: const Color(0xFFF4ECEA)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 52,
                      height: 52,
                      decoration: const BoxDecoration(
                        color: Color(0x1FFF6B5A),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.auto_awesome_outlined,
                        color: AppColors.primary,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            pick.insightTitle,
                            style: AppTextStyles.heading7.copyWith(
                              fontSize: 13,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            pick.insightDescription,
                            style: AppTextStyles.body1.copyWith(
                              fontSize: 16,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.auto_awesome_rounded,
                      color: Color(0x1FFF6B5A),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => BlocProvider.value(
                          value: context.read<AiRecommendationBloc>(),
                          child: const AiLocationDetailPage(),
                        ),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: Color(0xFF8B463C), width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Text(
                    pick.ctaLabel,
                    style: AppTextStyles.heading5.copyWith(
                      color: AppColors.primary,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: <Widget>[
                  const Expanded(
                    child: _ActionChip(
                      icon: Icons.favorite_border_rounded,
                      label: 'Save',
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: _ActionChip(
                      icon: Icons.ios_share_rounded,
                      label: 'Share',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F0EE),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, color: const Color(0xFF7A2F28), size: 20),
          const SizedBox(width: 10),
          Text(
            label,
            style: AppTextStyles.body1.copyWith(
              color: AppColors.primary,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
