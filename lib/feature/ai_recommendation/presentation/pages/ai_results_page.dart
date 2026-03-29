import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../bloc/ai_recommendation_bloc.dart';
import '../widgets/ai_result_card.dart';
import '../widgets/ai_screen_header.dart';
import 'ai_map_page.dart';

class AiResultsPage extends StatelessWidget {
  const AiResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final feed = context.read<AiRecommendationBloc>().state.feed;
    if (feed == null) {
      return const SizedBox.shrink();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFFBFA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(12, 6, 12, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AiScreenHeader(
                title: feed.resultsTitle,
                onBack: () => Navigator.of(context).pop(),
                trailing: const AiCircleIconButton(icon: Icons.tune_rounded),
              ),
              const SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            color: Color(0x12FF6B5A),
                            blurRadius: 14,
                            offset: Offset(0, 6),
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
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Color(0x12FF6B5A),
                          blurRadius: 14,
                          offset: Offset(0, 6),
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
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBFA),
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
                                fontSize: 16,
                                height: 1.25,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            TextSpan(
                              text: feed.resultsSummaryQuery,
                              style: AppTextStyles.body1.copyWith(
                                fontSize: 16,
                                height: 1.25,
                                color: AppColors.primary,
                              ),
                            ),
                            TextSpan(
                              text: '", ${feed.resultsSummarySuffix}',
                              style: AppTextStyles.body1.copyWith(
                                fontSize: 16,
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
                  child: AiResultCard(
                    item: item,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => BlocProvider.value(
                            value: context.read<AiRecommendationBloc>(),
                            child: const AiMapPage(),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: AiCircleIconButton(
          icon: Icons.map_outlined,
          size: 60,
          iconSize: 28,
          backgroundColor: const Color(0xFF2D2D2D),
          iconColor: Colors.white,
          boxShadow: const <BoxShadow>[],
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => BlocProvider.value(
                  value: context.read<AiRecommendationBloc>(),
                  child: const AiMapPage(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
