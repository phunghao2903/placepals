import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../bloc/ai_recommendation_bloc.dart';
import '../widgets/ai_ask_suggestion_chip.dart';
import '../widgets/ai_screen_header.dart';
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
          backgroundColor: const Color(0xFFFFFBFA),
          body: SafeArea(
            child: Column(
              children: <Widget>[
                AiScreenHeader(
                  title: feed.askTitle,
                  onBack: () => Navigator.of(context).pop(),
                  trailing: const AiCircleIconButton(
                    icon: Icons.tune_rounded,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 254,
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          padding: const EdgeInsets.fromLTRB(20, 18, 18, 18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: const <BoxShadow>[
                              BoxShadow(
                                color: Color(0x12FF6B5A),
                                blurRadius: 20,
                                offset: Offset(0, 8),
                              ),
                            ],
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
                                      padding: const EdgeInsets.only(right: 12),
                                      child: Icon(
                                        Icons.edit_note_rounded,
                                        color: AppColors.primary,
                                        size: 26,
                                      ),
                                    ),
                                    prefixIconConstraints: const BoxConstraints(
                                      minWidth: 38,
                                      minHeight: 28,
                                    ),
                                    hintStyle: AppTextStyles.heading5.copyWith(
                                      fontSize: 18,
                                      height: 1.2,
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  style: AppTextStyles.heading5.copyWith(
                                    fontSize: 18,
                                    height: 1.2,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: const BoxDecoration(
                                    color: Color(0x1FFF6B5A),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.mic_none_rounded,
                                    color: AppColors.primary,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'Suggestions',
                            style: AppTextStyles.heading5.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Wrap(
                            spacing: 16,
                            runSpacing: 14,
                            children: feed.suggestions.map((item) {
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
                            }).toList(growable: false),
                          ),
                        ),
                        const SizedBox(height: 270),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: SizedBox(
                            width: double.infinity,
                            height: 56,
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
                                disabledBackgroundColor:
                                    const Color(0xFFE5D8D6),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28),
                                ),
                                elevation: 0,
                              ),
                              icon: const Icon(
                                Icons.auto_awesome_rounded,
                                size: 20,
                              ),
                              label: Text(
                                'Find Places',
                                style: AppTextStyles.heading5.copyWith(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
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
