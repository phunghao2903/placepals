import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../bloc/ai_recommendation_bloc.dart';
import '../widgets/ai_ask_suggestion_chip.dart';
import 'ai_progress_page.dart';

class AiAskPage extends StatefulWidget {
  const AiAskPage({super.key});

  @override
  State<AiAskPage> createState() => _AiAskPageState();
}

class _AiAskPageState extends State<AiAskPage> {
  late final TextEditingController _promptController;

  @override
  void initState() {
    super.initState();
    final state = context.read<AiRecommendationBloc>().state;
    _promptController = TextEditingController(text: state.prompt);
  }

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AiRecommendationBloc, AiRecommendationState>(
      listenWhen: (previous, current) => previous.prompt != current.prompt,
      listener: (context, state) {
        if (_promptController.text != state.prompt) {
          _promptController.value = TextEditingValue(
            text: state.prompt,
            selection: TextSelection.collapsed(offset: state.prompt.length),
          );
        }
      },
      builder: (context, state) {
        final feed = state.feed;
        if (feed == null) {
          return const SizedBox.shrink();
        }

        final isButtonEnabled = state.prompt.trim().isNotEmpty;

        return Scaffold(
          backgroundColor: const Color(0xFFFFF4F3),
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 14, 24, 14),
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 24,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          feed.askTitle,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.heading4.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
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
                        child: const Icon(
                          Icons.tune_rounded,
                          size: 24,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 255,
                          padding: const EdgeInsets.fromLTRB(24, 24, 24, 18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: TextField(
                                  controller: _promptController,
                                  maxLines: null,
                                  expands: true,
                                  onChanged: (value) {
                                    context.read<AiRecommendationBloc>().add(
                                      AiRecommendationPromptChanged(
                                        prompt: value,
                                      ),
                                    );
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: feed.askPrompt,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 12,
                                        top: 4,
                                      ),
                                      child: Icon(
                                        Icons.edit_note_rounded,
                                        color: AppColors.primary,
                                        size: 28,
                                      ),
                                    ),
                                    prefixIconConstraints: const BoxConstraints(
                                      minWidth: 38,
                                      minHeight: 28,
                                    ),
                                    hintStyle: AppTextStyles.heading4.copyWith(
                                      fontSize: 24,
                                      height: 1.25,
                                      color: const Color(0xFF8F8685),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  style: AppTextStyles.heading4.copyWith(
                                    fontSize: 24,
                                    height: 1.25,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFCE8E5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.mic_none_rounded,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 34),
                        Text(
                          'Suggestions',
                          style: AppTextStyles.heading3.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Wrap(
                          spacing: 12,
                          runSpacing: 16,
                          children: feed.suggestions
                              .map((item) {
                                final isSelected = state.selectedSuggestionIds
                                    .contains(item.id);
                                return AiAskSuggestionChip(
                                  label: item.label,
                                  isSelected: isSelected,
                                  onTap: () {
                                    context.read<AiRecommendationBloc>().add(
                                      AiRecommendationSuggestionToggled(
                                        suggestionId: item.id,
                                      ),
                                    );
                                  },
                                );
                              })
                              .toList(growable: false),
                        ),
                        const SizedBox(height: 290),
                        SizedBox(
                          width: double.infinity,
                          height: 58,
                          child: ElevatedButton.icon(
                            onPressed: isButtonEnabled
                                ? () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute<void>(
                                        builder: (_) => BlocProvider.value(
                                          value: context
                                              .read<AiRecommendationBloc>(),
                                          child: const AiProgressPage(),
                                        ),
                                      ),
                                    );
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              disabledBackgroundColor: const Color(0xFFE5D8D6),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(29),
                              ),
                            ),
                            icon: const Icon(
                              Icons.auto_awesome_rounded,
                              size: 24,
                            ),
                            label: Text(
                              'Find Places',
                              style: AppTextStyles.heading4.copyWith(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
