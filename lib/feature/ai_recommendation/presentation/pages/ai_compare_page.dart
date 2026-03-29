import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../domain/entities/ai_recommendation_compare_option.dart';
import '../../domain/entities/ai_recommendation_compare_row.dart';
import '../bloc/ai_recommendation_bloc.dart';
import '../widgets/ai_screen_header.dart';
import 'ai_top_pick_page.dart';

class AiComparePage extends StatefulWidget {
  const AiComparePage({super.key});

  @override
  State<AiComparePage> createState() => _AiComparePageState();
}

class _AiComparePageState extends State<AiComparePage> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.74);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AiRecommendationBloc>();
    final state = bloc.state;
    final feed = state.feed;
    if (feed == null) {
      return const SizedBox.shrink();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFFBFA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(0, 6, 0, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AiScreenHeader(
                title: 'Compare Picks',
                onBack: () => Navigator.of(context).pop(),
                trailing: const AiCircleIconButton(icon: Icons.tune_rounded),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                child: Text(
                  feed.compareEyebrow,
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.primary,
                    fontSize: 13,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                child: Text(
                  feed.compareTitle,
                  style: AppTextStyles.heading2.copyWith(
                    fontSize: 30,
                    height: 1.05,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
                child: Text(
                  feed.compareDescription,
                  style: AppTextStyles.body2.copyWith(
                    fontSize: 14,
                    color: const Color(0xFF928888),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                height: 610,
                child: PageView.builder(
                  controller: _pageController,
                  padEnds: false,
                  itemCount: feed.compareOptions.length,
                  itemBuilder: (context, index) {
                    final option = feed.compareOptions[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? 20 : 12,
                        right:
                            index == feed.compareOptions.length - 1 ? 20 : 0,
                      ),
                      child: _CompareOptionCard(
                        option: option,
                        onSelect: () {
                          bloc.add(
                            AiRecommendationCompareOptionSelected(
                              optionId: option.id,
                            ),
                          );
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => BlocProvider.value(
                                value: bloc,
                                child: const AiTopPickPage(),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 22),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'At a Glance',
                  style: AppTextStyles.heading5.copyWith(fontSize: 18),
                ),
              ),
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _CompareTable(rows: feed.compareRows),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 18),
        child: AiCircleIconButton(
          icon: Icons.map_outlined,
          size: 58,
          iconSize: 26,
          backgroundColor: const Color(0xFF2D2D2D),
          iconColor: Colors.white,
          boxShadow: const <BoxShadow>[],
          onTap: () {},
        ),
      ),
    );
  }
}

class _CompareOptionCard extends StatelessWidget {
  final AiRecommendationCompareOption option;
  final VoidCallback onSelect;

  const _CompareOptionCard({
    required this.option,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final highlightColor = option.isTopMatch
        ? AppColors.primary
        : const Color(0xFFAEA2A1);

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x12FF6B5A),
            blurRadius: 22,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: SizedBox(
                          height: 104,
                          width: double.infinity,
                          child: Image.asset(option.imagePath, fit: BoxFit.cover),
                        ),
                      ),
                      if (option.isTopMatch)
                        Positioned(
                          top: -2,
                          left: 88,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              'TOP MATCH',
                              style: AppTextStyles.heading8.copyWith(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    option.title,
                    style: AppTextStyles.heading5.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.star_rounded,
                        color: AppColors.warning,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        option.rating.toStringAsFixed(1),
                        style: AppTextStyles.body2.copyWith(
                          fontSize: 14,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        option.reviewsLabel,
                        style: AppTextStyles.body2.copyWith(fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'MATCH SCORE',
                    style: AppTextStyles.heading8.copyWith(
                      fontSize: 11,
                      color: const Color(0xFFA89D9B),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: <Widget>[
                      Text(
                        option.matchScoreLabel,
                        style: AppTextStyles.heading2.copyWith(
                          fontSize: 30,
                          color: highlightColor,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: LinearProgressIndicator(
                            minHeight: 6,
                            value: int.parse(
                                  option.matchScoreLabel.replaceAll('%', ''),
                                ) /
                                100,
                            backgroundColor: const Color(0xFFF0E8E6),
                            valueColor:
                                AlwaysStoppedAnimation<Color>(highlightColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: _MetricTile(
                          label: 'DISTANCE',
                          value: option.distanceLabel,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _MetricTile(
                          label: 'PRICE',
                          value: option.priceLabel,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _MetricTile(
                    label: 'VIBE',
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: option.vibes.map((vibe) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: option.isTopMatch
                                ? const Color(0xFFFFF0EC)
                                : const Color(0xFFF2F5FF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            vibe,
                            style: AppTextStyles.body2.copyWith(
                              fontSize: 11,
                              color: option.isTopMatch
                                  ? AppColors.primary
                                  : const Color(0xFF5E8BFF),
                            ),
                          ),
                        );
                      }).toList(growable: false),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF4F2),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFF7C4BE)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          option.reasonTitle,
                          style: AppTextStyles.heading8.copyWith(
                            fontSize: 11,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          option.reasonDescription,
                          style: AppTextStyles.body2.copyWith(
                            fontSize: 14,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: onSelect,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2D2D2D),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Text(
                'Select Option',
                style: AppTextStyles.heading6.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  final String label;
  final String? value;
  final Widget? child;

  const _MetricTile({
    required this.label,
    this.value,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F4F3),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: AppTextStyles.heading8.copyWith(
              fontSize: 11,
              color: const Color(0xFFA89D9B),
            ),
          ),
          const SizedBox(height: 8),
          if (child != null)
            child!
          else
            Text(
              value ?? '',
              style: AppTextStyles.heading6.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
        ],
      ),
    );
  }
}

class _CompareTable extends StatelessWidget {
  final List<AiRecommendationCompareRow> rows;

  const _CompareTable({
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF1E7E4)),
      ),
      child: Column(
        children: <Widget>[
          _TableRow(
            values: const <String>['Criteria', 'Bean', 'Grind', 'Leaf'],
            isHeader: true,
          ),
          ...rows.map(_buildRow),
        ],
      ),
    );
  }

  Widget _buildRow(AiRecommendationCompareRow row) {
    return _TableRow(
      values: <String>[
        row.criteria,
        row.beanValue,
        row.grindValue,
        row.leafValue,
      ],
      highlightIndex: switch (row.criteria) {
        'WiFi' => 2,
        'Noise' => 1,
        'Coffee' => 1,
        _ => null,
      },
    );
  }
}

class _TableRow extends StatelessWidget {
  final List<String> values;
  final bool isHeader;
  final int? highlightIndex;

  const _TableRow({
    required this.values,
    this.isHeader = false,
    this.highlightIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: values.asMap().entries.map((entry) {
          final index = entry.key;
          final value = entry.value;
          final isHighlighted = highlightIndex == index;
          return Expanded(
            child: Text(
              value,
              textAlign: index == 0 ? TextAlign.left : TextAlign.center,
              style: (isHeader ? AppTextStyles.heading7 : AppTextStyles.body2)
                  .copyWith(
                fontSize: isHeader ? 14 : 14,
                color: isHighlighted
                    ? (value == 'Fastest'
                        ? const Color(0xFF22C55E)
                        : AppColors.primary)
                    : (isHeader
                        ? const Color(0xFF8E8382)
                        : AppColors.textSecondary),
              ),
            ),
          );
        }).toList(growable: false),
      ),
    );
  }
}
