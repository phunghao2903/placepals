import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../domain/entities/ai_recommendation_trip_vibe_option.dart';
import '../bloc/ai_recommendation_bloc.dart';
import '../widgets/ai_screen_header.dart';
import 'ai_trip_detail_page.dart';

class AiTripInformationPage extends StatefulWidget {
  const AiTripInformationPage({super.key});

  @override
  State<AiTripInformationPage> createState() => _AiTripInformationPageState();
}

class _AiTripInformationPageState extends State<AiTripInformationPage> {
  late final TextEditingController _destinationController;

  @override
  void initState() {
    super.initState();
    _destinationController = TextEditingController(
      text: context.read<AiRecommendationBloc>().state.tripDestination,
    );
  }

  @override
  void dispose() {
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AiRecommendationBloc>();

    return BlocConsumer<AiRecommendationBloc, AiRecommendationState>(
      listenWhen: (previous, current) =>
          previous.tripDestination != current.tripDestination,
      listener: (context, state) {
        if (_destinationController.text != state.tripDestination) {
          _destinationController.value = TextEditingValue(
            text: state.tripDestination,
            selection: TextSelection.collapsed(
              offset: state.tripDestination.length,
            ),
          );
        }
      },
      builder: (context, state) {
        final tripPlanner = state.feed?.tripPlanner;
        if (tripPlanner == null) {
          return const SizedBox.shrink();
        }

        return Scaffold(
          backgroundColor: const Color(0xFFFCFAFA),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AiScreenHeader(
                    title: tripPlanner.infoTitle,
                    onBack: () => Navigator.of(context).pop(),
                    trailing: const AiCircleIconButton(
                      icon: Icons.history_rounded,
                    ),
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.auto_awesome_rounded,
                        color: AppColors.primary,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        tripPlanner.infoEyebrow,
                        style: AppTextStyles.body2.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    tripPlanner.infoHeadline,
                    style: AppTextStyles.heading1.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    tripPlanner.infoDescription,
                    style: AppTextStyles.body1.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 28),
                  _InputCard(
                    label: tripPlanner.destinationLabel,
                    icon: Icons.location_on_outlined,
                    child: Container(
                      height: 52,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFCFAFA),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: _destinationController,
                              onChanged: (value) {
                                bloc.add(
                                  AiRecommendationTripDestinationChanged(
                                    destination: value,
                                  ),
                                );
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: tripPlanner.destinationPlaceholder,
                                hintStyle: AppTextStyles.heading3.copyWith(
                                  color: const Color(0xFFAEA5A4),
                                ),
                              ),
                              style: AppTextStyles.heading3,
                            ),
                          ),
                          const Icon(
                            Icons.search_rounded,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _InputCard(
                    label: 'Trip Dates',
                    icon: Icons.calendar_today_outlined,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: _DateTile(
                            label: tripPlanner.startDateLabel,
                            value: tripPlanner.startDateValue,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _DateTile(
                            label: tripPlanner.endDateLabel,
                            value: tripPlanner.endDateValue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(21),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            const Icon(
                              Icons.sentiment_satisfied_alt_rounded,
                              color: AppColors.primary,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              tripPlanner.vibeLabel,
                              style: AppTextStyles.body2.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0x1AFF6B5A),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                tripPlanner.vibeHelperLabel,
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: tripPlanner.vibeOptions.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1.15,
                          ),
                          itemBuilder: (context, index) {
                            final option = tripPlanner.vibeOptions[index];
                            final isSelected = state.selectedTripVibeIds
                                .contains(option.id);
                            return _VibeOptionTile(
                              option: option,
                              isSelected: isSelected,
                              onTap: () {
                                bloc.add(
                                  AiRecommendationTripVibeToggled(
                                    vibeId: option.id,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            const Icon(
                              Icons.attach_money_rounded,
                              color: AppColors.primary,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              tripPlanner.budgetLabel,
                              style: AppTextStyles.body2.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              switch (state.selectedTripBudgetIndex) {
                                0 => '\$',
                                1 => '\$\$',
                                2 => '\$\$\$',
                                _ => '\$\$\$\$',
                              },
                              style: AppTextStyles.heading7.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: List<Widget>.generate(
                            tripPlanner.budgetScale.length,
                            (index) {
                              return Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    bloc.add(
                                      AiRecommendationTripBudgetChanged(
                                        budgetIndex: index,
                                      ),
                                    );
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 160),
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: index <=
                                                  state.selectedTripBudgetIndex
                                              ? AppColors.primary
                                              : const Color(0xFFFCFAFA),
                                          borderRadius:
                                              BorderRadius.circular(999),
                                        ),
                                      ),
                                      const SizedBox(height: 14),
                                      Text(
                                        tripPlanner.budgetScale[index],
                                        textAlign: TextAlign.center,
                                        style: AppTextStyles.caption.copyWith(
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
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
                      icon: const Icon(Icons.auto_awesome_rounded),
                      label: Text(
                        tripPlanner.generateLabel,
                        style: AppTextStyles.heading5.copyWith(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Text(
                      tripPlanner.generateHelperText,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.caption,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _InputCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Widget child;

  const _InputCard({
    required this.label,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE5E7EB)),
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
            children: <Widget>[
              Icon(icon, color: AppColors.primary, size: 16),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTextStyles.body2.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _DateTile extends StatelessWidget {
  final String label;
  final String value;

  const _DateTile({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFCFAFA),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(label, style: AppTextStyles.caption),
          const Spacer(),
          Text(
            value,
            style: AppTextStyles.heading3.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _VibeOptionTile extends StatelessWidget {
  final AiRecommendationTripVibeOption option;
  final bool isSelected;
  final VoidCallback onTap;

  const _VibeOptionTile({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFCFAFA),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 10,
                right: 10,
                child: Icon(
                  isSelected
                      ? Icons.check_circle_rounded
                      : Icons.circle_outlined,
                  color: isSelected
                      ? AppColors.primary
                      : const Color(0xFFE3DAD9),
                  size: 16,
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      switch (option.id) {
                        'relaxed' => Icons.emoji_food_beverage_rounded,
                        'adventurous' => Icons.backpack_rounded,
                        'foodie' => Icons.ramen_dining_rounded,
                        _ => Icons.account_balance_rounded,
                      },
                      size: 24,
                      color: AppColors.textPrimary,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      option.label,
                      style: AppTextStyles.body2.copyWith(
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
    );
  }
}
