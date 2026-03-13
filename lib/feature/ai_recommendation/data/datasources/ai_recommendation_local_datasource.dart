import '../models/ai_recommendation_feed_model.dart';
import '../models/ai_recommendation_highlight_model.dart';
import '../models/ai_recommendation_progress_step_model.dart';
import '../models/ai_recommendation_result_item_model.dart';
import '../models/ai_recommendation_result_tag_model.dart';
import '../models/ai_recommendation_suggestion_model.dart';

abstract class AiRecommendationLocalDataSource {
  Future<AiRecommendationFeedModel> getAiRecommendationFeed();
}

class AiRecommendationLocalDataSourceImpl
    implements AiRecommendationLocalDataSource {
  @override
  Future<AiRecommendationFeedModel> getAiRecommendationFeed() async {
    return const AiRecommendationFeedModel(
      headline: 'Discover an exciting\njourney with Placespal',
      highlights: <AiRecommendationHighlightModel>[
        AiRecommendationHighlightModel(
          id: 'ai-location',
          title: 'AI Location\nRecommendations',
          description:
              'Personalized spots discovered just\nfor you based on your unique travel\nstyle.',
          iconKey: 'sparkles',
        ),
        AiRecommendationHighlightModel(
          id: 'trip-plan',
          title: 'Create a trip plan',
          description:
              'Find places that match your current\nmood, from chill cafes to high-\nenergy hubs.',
          iconKey: 'smile',
        ),
      ],
      askTitle: 'Ask AI',
      askPrompt: "I'm looking for a cafe with a warm\nand private atmosphere.",
      suggestions: <AiRecommendationSuggestionModel>[
        AiRecommendationSuggestionModel(
          id: 'quiet',
          label: 'Quiet',
          isSelected: true,
        ),
        AiRecommendationSuggestionModel(
          id: 'romantic',
          label: 'Romantic',
          isSelected: true,
        ),
        AiRecommendationSuggestionModel(
          id: 'budget',
          label: 'Budget-friendly',
          isSelected: false,
        ),
        AiRecommendationSuggestionModel(
          id: 'outdoor',
          label: 'Outdoor seating',
          isSelected: false,
        ),
        AiRecommendationSuggestionModel(
          id: 'late',
          label: 'Open late',
          isSelected: false,
        ),
        AiRecommendationSuggestionModel(
          id: 'laptop',
          label: 'Laptop friendly',
          isSelected: false,
        ),
      ],
      progressTitle: 'Magic in progress...',
      progressSubtitle: 'Finding the perfect match for you',
      progressSteps: <AiRecommendationProgressStepModel>[
        AiRecommendationProgressStepModel(
          id: 'analyze',
          label: 'Analyzing your preferences',
        ),
        AiRecommendationProgressStepModel(
          id: 'nearby',
          label: 'Checking quiet spots nearby',
        ),
        AiRecommendationProgressStepModel(
          id: 'reviews',
          label: 'Matching coffee quality reviews',
        ),
        AiRecommendationProgressStepModel(
          id: 'hours',
          label: 'Verifying laptop-friendly hours',
        ),
      ],
      resultsTitle: 'All Recommendations',
      resultsSummaryQuery: 'quiet places with good coffee',
      resultsSummarySuffix: "I've found 12 matches sorted by relevance.",
      results: <AiRecommendationResultItemModel>[
        AiRecommendationResultItemModel(
          id: 'golden-bean',
          title: 'The Golden Bean',
          subtitle: 'Artisan coffee & fresh pastries',
          imagePath: 'assets/images/cafe_tan.png',
          matchLabel: '98% MATCH',
          rating: 4.9,
          metaLine: '0.2 mi · \$\$',
          tags: <AiRecommendationResultTagModel>[
            AiRecommendationResultTagModel(
              id: 'outlets',
              label: 'Outlets',
              iconKey: 'power',
            ),
            AiRecommendationResultTagModel(
              id: 'wifi',
              label: 'Fast Wi-Fi',
              iconKey: 'wifi',
            ),
          ],
        ),
        AiRecommendationResultItemModel(
          id: 'urban-grind',
          title: 'Urban Grind',
          subtitle: 'Quiet vibe, good for work',
          imagePath: 'assets/images/bean_bloom.png',
          matchLabel: '95% MATCH',
          rating: 4.7,
          metaLine: '0.5 mi · \$',
          tags: <AiRecommendationResultTagModel>[
            AiRecommendationResultTagModel(
              id: 'quiet',
              label: 'Quiet',
              iconKey: 'mute',
            ),
            AiRecommendationResultTagModel(
              id: 'comfortable',
              label: 'Comfortable',
              iconKey: 'chair',
            ),
          ],
        ),
        AiRecommendationResultItemModel(
          id: 'leaf-latte',
          title: 'Leaf & Latte',
          subtitle: 'Outdoor seating available',
          imagePath: 'assets/images/bean_bloom.png',
          matchLabel: '90% MATCH',
          rating: 4.5,
          metaLine: '0.8 mi · \$\$',
          tags: <AiRecommendationResultTagModel>[
            AiRecommendationResultTagModel(
              id: 'patio',
              label: 'Patio',
              iconKey: 'tree',
            ),
            AiRecommendationResultTagModel(
              id: 'sunny',
              label: 'Sunny',
              iconKey: 'sun',
            ),
          ],
        ),
        AiRecommendationResultItemModel(
          id: 'espresso-lab',
          title: 'Espresso Lab',
          subtitle: 'Specialty coffee roasters',
          imagePath: 'assets/images/korea_food.jpeg',
          matchLabel: '85% MATCH',
          rating: 4.4,
          metaLine: '1.2 mi · \$\$\$',
          tags: <AiRecommendationResultTagModel>[
            AiRecommendationResultTagModel(
              id: 'roastery',
              label: 'Roastery',
              iconKey: 'coffee',
            ),
          ],
        ),
      ],
    );
  }
}
