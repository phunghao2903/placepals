import '../models/ai_recommendation_feed_model.dart';
import '../models/ai_recommendation_comment_feed_model.dart';
import '../models/ai_recommendation_compare_option_model.dart';
import '../models/ai_recommendation_compare_row_model.dart';
import '../models/ai_recommendation_friend_review_model.dart';
import '../models/ai_recommendation_highlight_model.dart';
import '../models/ai_recommendation_location_detail_model.dart';
import '../models/ai_recommendation_map_pick_model.dart';
import '../models/ai_recommendation_place_guide_model.dart';
import '../models/ai_recommendation_progress_step_model.dart';
import '../models/ai_recommendation_result_item_model.dart';
import '../models/ai_recommendation_result_tag_model.dart';
import '../models/ai_recommendation_review_breakdown_model.dart';
import '../models/ai_recommendation_review_insights_model.dart';
import '../models/ai_recommendation_review_item_model.dart';
import '../models/ai_recommendation_suggestion_model.dart';
import '../models/ai_recommendation_top_pick_model.dart';
import '../models/ai_recommendation_trip_itinerary_item_model.dart';
import '../models/ai_recommendation_trip_pick_model.dart';
import '../models/ai_recommendation_trip_place_detail_model.dart';
import '../models/ai_recommendation_trip_planner_model.dart';
import '../models/ai_recommendation_trip_traveler_model.dart';
import '../models/ai_recommendation_trip_trend_spot_model.dart';
import '../models/ai_recommendation_trip_vibe_option_model.dart';

abstract class AiRecommendationLocalDataSource {
  Future<AiRecommendationFeedModel> getAiRecommendationFeed();
}

class AiRecommendationLocalDataSourceImpl
    implements AiRecommendationLocalDataSource {
  @override
  Future<AiRecommendationFeedModel> getAiRecommendationFeed() async {
    return const AiRecommendationFeedModel(
      headline: 'Discover an exciting journey with Placespal',
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
      askPrompt: "I'm looking for a cafe with a warm and private atmosphere.",
      suggestions: <AiRecommendationSuggestionModel>[
        AiRecommendationSuggestionModel(
          id: 'quiet',
          label: 'Quiet',
          isSelected: false,
        ),
        AiRecommendationSuggestionModel(
          id: 'romantic',
          label: 'Romantic',
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
          imagePath: 'assets/images/map.png',
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
      mapTitle: 'AI Recommendations',
      mapRefineLabel: 'Refine Search',
      mapSheetTitle: 'Top 3 Picks for You',
      mapCenterMatchLabel: '98% Match',
      mapPicks: <AiRecommendationMapPickModel>[
        AiRecommendationMapPickModel(
          id: 'golden-bean',
          title: 'The Golden Bean',
          subtitle: 'Artisan coffee & fresh pastries',
          imagePath: 'assets/images/cafe_tan.png',
          markerLabel: 'A',
          badgeLabel: 'Best Match',
          highlightLabel: '0.2 mi',
          distanceLabel: '0.2 mi',
          rating: 4.9,
        ),
        AiRecommendationMapPickModel(
          id: 'urban-grind',
          title: 'Urban Grind',
          subtitle: 'Quiet vibe, good for work • 0.5 mi',
          imagePath: 'assets/images/bean_bloom.png',
          markerLabel: 'B',
          badgeLabel: 'Alt',
          distanceLabel: '0.5 mi',
          rating: 4.5,
        ),
        AiRecommendationMapPickModel(
          id: 'leaf-latte',
          title: 'Leaf & Latte',
          subtitle: 'Outdoor seating available • 0.8 mi',
          imagePath: 'assets/images/map.png',
          markerLabel: 'C',
          badgeLabel: 'Alt',
          distanceLabel: '0.8 mi',
          rating: 4.4,
        ),
      ],
      compareEyebrow: 'AI Analysis',
      compareTitle: 'Helping you decide.',
      compareDescription:
          "I've lined up your top 3 matches. The Golden Bean wins on atmosphere, but Urban Grind is closer to your current location.",
      compareOptions: <AiRecommendationCompareOptionModel>[
        AiRecommendationCompareOptionModel(
          id: 'bean',
          title: 'The Golden Bean',
          imagePath: 'assets/images/cafe_tan.png',
          rating: 4.9,
          reviewsLabel: '(128 reviews)',
          matchScoreLabel: '98%',
          distanceLabel: '0.2 mi',
          priceLabel: '\$\$',
          vibes: <String>['Cozy', 'Quiet'],
          reasonTitle: 'Why this one?',
          reasonDescription: 'Best artisanal coffee and pastry\nselection.',
          isTopMatch: true,
        ),
        AiRecommendationCompareOptionModel(
          id: 'grind',
          title: 'Urban Grind',
          imagePath: 'assets/images/bean_bloom.png',
          rating: 4.5,
          reviewsLabel: '(84 reviews)',
          matchScoreLabel: '88%',
          distanceLabel: '0.1 mi',
          priceLabel: '\$',
          vibes: <String>['Busy', 'Modern'],
          reasonTitle: 'Why this one?',
          reasonDescription: 'Fastest wifi and plenty of power\noutlets.',
        ),
        AiRecommendationCompareOptionModel(
          id: 'leaf',
          title: 'Leaf & Latte',
          imagePath: 'assets/images/map.png',
          rating: 4.4,
          reviewsLabel: '(56 reviews)',
          matchScoreLabel: '82%',
          distanceLabel: '0.8 mi',
          priceLabel: '\$\$\$',
          vibes: <String>['Nature', 'Airy'],
          reasonTitle: 'Why this one?',
          reasonDescription: 'Great outdoor seating and fresh\nair.',
        ),
      ],
      compareRows: <AiRecommendationCompareRowModel>[
        AiRecommendationCompareRowModel(
          criteria: 'WiFi',
          beanValue: 'Good',
          grindValue: 'Fastest',
          leafValue: 'Okay',
        ),
        AiRecommendationCompareRowModel(
          criteria: 'Noise',
          beanValue: 'Quiet',
          grindValue: 'Moderate',
          leafValue: 'Low',
        ),
        AiRecommendationCompareRowModel(
          criteria: 'Seating',
          beanValue: 'Armchairs',
          grindValue: 'Stools',
          leafValue: 'Patio',
        ),
        AiRecommendationCompareRowModel(
          criteria: 'Coffee',
          beanValue: 'Artisan',
          grindValue: 'Espresso',
          leafValue: 'Organic',
        ),
      ],
      topPick: AiRecommendationTopPickModel(
        title: 'The Velvet Lounge',
        category: 'Jazz Club',
        distanceLabel: '0.4 mi',
        priceLabel: '\$\$\$',
        matchLabel: '98% Match',
        insightTitle: 'AI INSIGHT',
        insightDescription:
            'Suggested because you like Jazz\nMusic and Acoustic vibes.',
        imagePath: 'assets/images/cafe_tan.png',
        ctaLabel: 'View Details',
      ),
      locationDetail: AiRecommendationLocationDetailModel(
        title: 'Blue Bottle Coffee -\nAoyama',
        category: 'Cafe',
        priceLabel: '\$\$',
        rating: 4.8,
        reviewsLabel: '1.2k reviews',
        addressTitle: '3-13-14 Minamiaoyama',
        addressSubtitle: 'Minato City, Tokyo 107-0062',
        statusLabel: 'Open Now',
        closingLabel: 'Closes 7 PM',
        hoursLabel: 'Full hours',
        notesTitle: 'Your Notes',
        notePlaceholder:
            'What did you think of this place? Add a personal note for your trip...',
        guidesTitle: 'Related Guides',
        guidesActionLabel: 'View all',
        directionsLabel: 'Continue Journey',
        imagePath: 'assets/images/cafe_tan.png',
        guides: <AiRecommendationPlaceGuideModel>[
          AiRecommendationPlaceGuideModel(
            title: 'Tokyo Coffee Scene',
            subtitle: '12 locations',
            imagePath: 'assets/images/bean_bloom.png',
            label: 'Guide',
          ),
          AiRecommendationPlaceGuideModel(
            title: 'Hidden Gems in\nAoyama',
            subtitle: '8 locations',
            imagePath: 'assets/images/map.png',
            label: 'Guide',
          ),
          AiRecommendationPlaceGuideModel(
            title: 'Best Latte Art 2024',
            subtitle: '15 locations',
            imagePath: 'assets/images/korea_food.jpeg',
            label: 'Guide',
          ),
        ],
      ),
      commentFeed: AiRecommendationCommentFeedModel(
        title: 'Bean & Brew Haven',
        category: 'Coffee Shop',
        priceLabel: '\$\$',
        distanceLabel: '0.4 mi away',
        imagePath: 'assets/images/cafe_tan.png',
        primaryActionLabel: 'Navigate',
        secondaryActionLabel: 'Save',
        friendsSectionTitle: 'Friends love this spot',
        friendsSectionSubtitle: 'Based on 12 friend reviews',
        ratingLabel: '4.8',
        friendReviews: <AiRecommendationFriendReviewModel>[
          AiRecommendationFriendReviewModel(
            authorHandle: '@sarah',
            timeLabel: '2d ago',
            content:
                'Best latte art in town! Make sure to try the oat milk version ☕️',
            initials: 'S',
            avatarImagePath: 'assets/images/profile.jpg',
          ),
          AiRecommendationFriendReviewModel(
            authorHandle: '@mike_j',
            timeLabel: '1w ago',
            content: 'Great atmosphere for working. WiFi is\nsuper fast.',
            initials: 'M',
          ),
        ],
        reviewsActionLabel: 'View all 12 reviews',
        locationTitle: 'Location & Hours',
        addressLabel: '123 Espresso Lane, Seattle, WA',
        statusLabel: 'Open',
        closingLabel: '• Closes 8 PM',
      ),
      reviewInsights: AiRecommendationReviewInsightsModel(
        title: 'Review Insights',
        summaryTitle: 'AI Sentiment Summary',
        sentimentValue: '85%',
        sentimentLabel: 'Positive',
        basedOnLabel: 'Based on 12 verified reviews',
        breakdowns: <AiRecommendationReviewBreakdownModel>[
          AiRecommendationReviewBreakdownModel(
            label: 'Love',
            valueLabel: '85%',
            progress: 0.85,
          ),
          AiRecommendationReviewBreakdownModel(
            label: 'Normal',
            valueLabel: '10%',
            progress: 0.10,
          ),
          AiRecommendationReviewBreakdownModel(
            label: 'Dislike',
            valueLabel: '5%',
            progress: 0.05,
          ),
        ],
        themesTitle: 'Key Themes',
        themes: <String>[
          'Great Service',
          'Quiet',
          'Crowded',
          'Overpriced',
        ],
        transparencyTitle: 'AI Transparency Mode',
        transparencySubtitle: 'Show reasoning for flagged content',
        recentReviewsTitle: 'Recent Reviews',
        sortLabel: 'Sort by Newest',
        reviews: <AiRecommendationReviewItemModel>[
          AiRecommendationReviewItemModel(
            id: 'jane',
            author: 'Jane D.',
            meta: '2 days ago • Verified Stay',
            content:
                'Absolutely loved the quiet morning walks here.\nThe service was impeccable, especially the\nconcierge who helped us book our tour.',
            rating: 5,
            tags: <String>['Helpful'],
            isHidden: false,
            initials: 'J',
          ),
          AiRecommendationReviewItemModel(
            id: 'hidden',
            rating: 0,
            tags: <String>[],
            isHidden: true,
            hiddenTitle: 'Hidden by AI',
            hiddenSubtitle: 'Contains toxic language',
            flaggedTitle: 'Why was this flagged?',
            flaggedDescription:
                'The AI detected aggressive language and\npersonal attacks that violate our community\nguidelines.',
            actionLabel: 'Reveal',
            initials: 'AI',
          ),
          AiRecommendationReviewItemModel(
            id: 'mark',
            author: 'Mark S.',
            meta: '1 week ago',
            content:
                'Service was slow but the food was okay. I\nexpected a bit more for the price point, honestly.\nIt gets very crowded around noon.',
            rating: 3,
            tags: <String>['Wait time: 45m', 'Crowded'],
            isHidden: false,
            initials: 'M',
          ),
        ],
      ),
      tripPlanner: AiRecommendationTripPlannerModel(
        homeGreeting: 'Good morning,',
        homeName: 'Alex',
        searchHint: 'Where do you want to go?',
        plannerBadge: 'AI Planner',
        plannerTitle: 'Plan your next trip',
        plannerDescription: 'Personalized itinerary in seconds.',
        plannerActionLabel: 'Start',
        picksTitle: 'Top Picks for You',
        picksEyebrow: 'AI Curated',
        picksActionLabel: 'See all',
        picks: <AiRecommendationTripPickModel>[
          AiRecommendationTripPickModel(
            id: 'kyoto',
            title: 'Kyoto, Japan',
            subtitle: 'Culture & History',
            matchLabel: '98% Match',
            reason: 'Matches your love for Hidden Gems and quiet mornings.',
            imagePath: 'assets/images/map.png',
          ),
          AiRecommendationTripPickModel(
            id: 'zermatt',
            title: 'Zermatt, Swiss Alps',
            subtitle: 'Nature & Adventure',
            matchLabel: '94% Match',
            reason: 'Ideal for slow travel, fresh air, and scenic train rides.',
            imagePath: 'assets/images/bean_bloom.png',
          ),
          AiRecommendationTripPickModel(
            id: 'cinque-terre',
            title: 'Cinque Terre, Italy',
            subtitle: 'Colorful Coastal Towns',
            matchLabel: '91% Match',
            reason: 'Fits your taste for photogenic streets and local food.',
            imagePath: 'assets/images/cafe_tan.png',
          ),
        ],
        browseVibes: <String>[
          'Specialty Coffee',
          'Art Museums',
          'Hidden Gems',
          'Vegan Friendly',
        ],
        trendingTitle: 'Trending Near You',
        trendingSpots: <AiRecommendationTripTrendSpotModel>[
          AiRecommendationTripTrendSpotModel(
            id: 'blue-bottle',
            title: 'Blue Bottle\nCoffee',
            subtitle: 'Aoyama District - 0.8 km',
            statusLabel: 'OPEN',
            isPositiveStatus: true,
            socialProofLabel: 'Sarah & David visited',
            imagePath: 'assets/images/cafe_tan.png',
          ),
          AiRecommendationTripTrendSpotModel(
            id: 'nezu-museum',
            title: 'Nezu Museum',
            subtitle: 'Minami-Aoyama - 1.2 km',
            statusLabel: 'BUSY',
            isPositiveStatus: false,
            highlightLabel: 'Iris garden in bloom',
            imagePath: 'assets/images/bean_bloom.png',
          ),
        ],
        travelersTitle: 'Travelers like you',
        travelersActionLabel: 'View all',
        travelers: <AiRecommendationTripTravelerModel>[
          AiRecommendationTripTravelerModel(
            id: 'sarah',
            name: 'Sarah',
            matchLabel: '95% Match',
            imagePath: 'assets/images/profile.jpg',
            isOnline: true,
          ),
          AiRecommendationTripTravelerModel(
            id: 'david',
            name: 'David',
            matchLabel: '88% Match',
            imagePath: 'assets/images/bean_bloom.png',
          ),
          AiRecommendationTripTravelerModel(
            id: 'discover',
            name: 'Discover',
            matchLabel: '',
            isDiscoverCard: true,
          ),
        ],
        infoTitle: 'Plan New Trip',
        infoEyebrow: 'AI Powered',
        infoHeadline: 'Where to next?',
        infoDescription:
            'Let our AI craft the perfect itinerary based on\nyour unique travel DNA.',
        destinationLabel: 'Destination',
        destinationPlaceholder: 'e.g. Kyoto, Japan',
        startDateLabel: 'Start Date',
        startDateValue: 'Oct 14',
        endDateLabel: 'End Date',
        endDateValue: 'Select',
        vibeLabel: 'Travel Vibe',
        vibeHelperLabel: 'Select up to 3',
        vibeOptions: <AiRecommendationTripVibeOptionModel>[
          AiRecommendationTripVibeOptionModel(
            id: 'relaxed',
            emoji: 'Tea',
            label: 'Relaxed',
          ),
          AiRecommendationTripVibeOptionModel(
            id: 'adventurous',
            emoji: 'Pack',
            label: 'Adventurous',
          ),
          AiRecommendationTripVibeOptionModel(
            id: 'foodie',
            emoji: 'Food',
            label: 'Foodie',
          ),
          AiRecommendationTripVibeOptionModel(
            id: 'cultural',
            emoji: 'Art',
            label: 'Cultural',
          ),
        ],
        budgetLabel: 'Budget Level',
        budgetValue: '\$\$\$',
        budgetScale: <String>['Budget', 'Standard', 'Premium', 'Luxury'],
        generateLabel: 'Generate Itinerary',
        generateHelperText:
            'AI will generate 3 options based on your preferences.',
        detailTitle: 'Your Saturday in Tokyo',
        detailSubtitle: 'Based on your mood: Relaxed & Curious',
        dayChips: <String>['Sat 14', 'Sun 15', 'Mon 16', 'Tue 17', 'Wed 18'],
        itinerary: <AiRecommendationTripItineraryItemModel>[
          AiRecommendationTripItineraryItemModel(
            id: 'blue-bottle',
            timeLabel: '10:00 AM',
            title: 'Blue Bottle Coffee',
            locationLabel: 'Aoyama District',
            imagePath: 'assets/images/cafe_tan.png',
            whyTitle: 'Why this fits you:',
            whyDescription:
                'Matches your preference for minimalist interiors and quiet reading spots.',
            tipTitle: 'What to eat:',
            tipDescription: 'Try the Signature Matcha Latte with oat milk.',
          ),
          AiRecommendationTripItineraryItemModel(
            id: 'nezu',
            timeLabel: '11:30 AM',
            title: 'Nezu Museum',
            locationLabel: 'Minami-Aoyama',
            imagePath: 'assets/images/bean_bloom.png',
            whyTitle: 'Why this fits you:',
            whyDescription:
                'Perfectly aligns with your interest in traditional Japanese architecture and zen gardens.',
            tipTitle: 'Do not miss:',
            tipDescription: 'The Iris garden is currently in partial bloom.',
          ),
          AiRecommendationTripItineraryItemModel(
            id: 'sushi',
            timeLabel: '1:15 PM',
            title: 'Sushi no Midori',
            locationLabel: 'Shibuya Mark City',
            imagePath: 'assets/images/korea_food.jpeg',
            whyTitle: 'Why this fits you:',
            whyDescription:
                'You wanted to try authentic conveyor belt sushi without the tourist traps.',
            tipTitle: 'What to eat:',
            tipDescription: 'The Omakase Nigiri set is the best value.',
          ),
        ],
        detailActionLabel: 'Start This Day',
        placeDetail: AiRecommendationTripPlaceDetailModel(
          headerImagePath: 'assets/images/cafe_tan.png',
          title: 'Kissa Blue Bottle',
          subtitle: 'Aoyama, Tokyo - 0.2 mi away',
          rating: 4.8,
          tags: <String>['Specialty Coffee', 'Quiet', 'WiFi'],
          vibeTitle: 'AI Vibe Analysis',
          vibeBadgeLabel: 'Beta',
          vibeSummary: 'Mostly Relaxed & Productive',
          vibeScoreLabel: '90%',
          positiveTitle: 'WHAT PEOPLE LOVE',
          positiveDescription:
              'Perfect for deep work. The matcha latte with oat milk is frequently mentioned as a must-try. Minimalist interior creates a Zen-like atmosphere.',
          cautionTitle: 'THINGS TO NOTE',
          cautionDescription:
              'Can get crowded on weekends around 2 PM. Limited power outlets near the window seats.',
          filteredLabel: 'Toxic comments filtered',
          updatedLabel: 'Updated 2h ago',
          aboutTitle: 'About',
          aboutDescription:
              'A serene escape in the bustling Aoyama district. Known for its single-origin beans and precision brewing methods. The space features traditional Japanese aesthetics merged with modern minimalism.',
          aboutActionLabel: 'Read more',
          photosTitle: 'Photos',
          photosActionLabel: 'View all',
          photoPaths: <String>[
            'assets/images/korea_food.jpeg',
            'assets/images/bean_bloom.png',
            'assets/images/cafe_tan.png',
          ],
          mapButtonLabel: 'Map',
          addButtonLabel: 'Add to Itinerary',
        ),
      ),
    );
  }
}
