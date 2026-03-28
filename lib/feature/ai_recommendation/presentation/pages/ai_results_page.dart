import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../bloc/ai_recommendation_bloc.dart';
import '../widgets/ai_result_card.dart';

class AiResultsPage extends StatelessWidget {
  const AiResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<AiRecommendationBloc>().state;
    final feed = state.feed;
    if (feed == null) {
      return const SizedBox.shrink();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  _IconCircleButton(
                    icon: Icons.arrow_back_ios_new_rounded,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  Expanded(
                    child: Text(
                      feed.resultsTitle,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.heading4.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const _IconCircleButton(icon: Icons.tune_rounded),
                ],
              ),
              const SizedBox(height: 26),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 58,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            color: Color(0x10000000),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.tune_rounded,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Sort by:',
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.body2.copyWith(
                                      color: const Color(0xFFA09392),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    'Match %',
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.heading7.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.expand_more_rounded,
                            color: Color(0xFFA09392),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    height: 58,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Color(0x10000000),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          Icons.tune_rounded,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Refine',
                          style: AppTextStyles.heading7.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 26),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7F5),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFF7C4BE)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 54,
                      height: 54,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.auto_awesome_rounded,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: <InlineSpan>[
                            TextSpan(
                              text: 'Based on your request for "',
                              style: AppTextStyles.body1.copyWith(
                                fontSize: 17,
                                height: 1.25,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            TextSpan(
                              text: feed.resultsSummaryQuery,
                              style: AppTextStyles.body1.copyWith(
                                fontSize: 17,
                                height: 1.25,
                                color: AppColors.primary,
                              ),
                            ),
                            TextSpan(
                              text: '", ${feed.resultsSummarySuffix}',
                              style: AppTextStyles.body1.copyWith(
                                fontSize: 17,
                                height: 1.25,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ...List<Widget>.generate(feed.results.length, (index) {
                final item = feed.results[index];
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: index == feed.results.length - 1 ? 0 : 20,
                  ),
                  child: AiResultCard(item: item),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconCircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _IconCircleButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: AppColors.textPrimary),
      ),
    );
  }
}
