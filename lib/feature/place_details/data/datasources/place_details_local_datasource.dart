import '../models/place_details_feed_model.dart';

abstract class PlaceDetailsLocalDataSource {
  Future<PlaceDetailsFeedModel> getPlaceDetailsFeed(String placeId);
}

class PlaceDetailsLocalDataSourceImpl implements PlaceDetailsLocalDataSource {
  @override
  Future<PlaceDetailsFeedModel> getPlaceDetailsFeed(String placeId) async {
    return switch (placeId) {
      'cafe-tan' => _buildFeed(
          placeId: placeId,
          title: 'Cafe Tan',
          category: 'Coffee & Brunch',
          imagePath: 'assets/images/cafe_tan.png',
          distanceLabel: '0.9 mi away',
          rating: 4.7,
          addressLabel: '45 Hoang Van Thu, Da Nang',
          aboutDescription:
              'Cafe Tan balances calm coffee rituals with an all-day brunch menu. Warm neutrals, soft daylight, and comfortable seating make it an easy stop for slow mornings and casual catch-ups.',
        ),
      'korea-food' => _buildFeed(
          placeId: placeId,
          title: 'Korea Food',
          category: 'Korean Cuisine',
          imagePath: 'assets/images/korea_food.jpeg',
          distanceLabel: '1.2 mi away',
          rating: 4.6,
          addressLabel: '102 Tran Phu, Da Nang',
          aboutDescription:
              'Korea Food is a cozy city stop for sizzling comfort dishes and quick meetups. The kitchen focuses on familiar Korean favorites, with a lively vibe that still feels welcoming for small groups.',
        ),
      _ => _buildFeed(
          placeId: 'bean-bloom-1',
          title: 'Bean & Bloom',
          category: 'Specialty Coffee',
          imagePath: 'assets/images/bean_bloom.png',
          distanceLabel: '0.4 mi away',
          rating: 4.8,
          addressLabel: '123 Espresso Lane, Da Nang',
          aboutDescription:
              'Bean & Bloom is a sanctuary for coffee purists. Located in the heart of Da Nang, we curate seasonally sourced beans from Vietnam\'s Central Highlands, roasted in-house to bring out vibrant, floral notes. Experience our signature "Bloom" pour-over, a sensory journey of honeyed sweetness and citrus undertones.',
        ),
    };
  }

  PlaceDetailsFeedModel _buildFeed({
    required String placeId,
    required String title,
    required String category,
    required String imagePath,
    required String distanceLabel,
    required double rating,
    required String addressLabel,
    required String aboutDescription,
  }) {
    return PlaceDetailsFeedModel(
      detail: PlaceDetailDataModel(
        placeId: placeId,
        headerTitle: 'Location Details',
        heroImagePath: imagePath,
        statusLabel: 'Open Now',
        rating: rating,
        title: title,
        locationLabel: 'Da Nang, Vietnam',
        aboutTitle: 'About $category',
        aboutDescription: aboutDescription,
        tags: const <PlaceDetailTagModel>[
          PlaceDetailTagModel(label: 'Single Origin', iconKey: 'coffee'),
          PlaceDetailTagModel(label: 'Artisan Pastries', iconKey: 'bakery'),
          PlaceDetailTagModel(label: 'Fast Wi-Fi', iconKey: 'wifi'),
        ],
        mapSnippet: PlaceMapSnippetDataModel(
          imagePath: 'assets/images/map.png',
          buttonLabel: 'Get Directions',
          openingHoursTitle: 'Opening Hours',
          openingHours: const <PlaceOpeningHourModel>[
            PlaceOpeningHourModel(
              dayLabel: 'Monday - Friday',
              hoursLabel: '07:30 - 21:00',
            ),
            PlaceOpeningHourModel(
              dayLabel: 'Saturday',
              hoursLabel: '08:00 - 22:00',
            ),
            PlaceOpeningHourModel(
              dayLabel: 'Sunday',
              hoursLabel: '08:00 - 20:00',
              isHighlighted: true,
            ),
          ],
        ),
        reviewsTitle: 'What Visitors Say',
        reviewsActionLabel: 'Write a Review',
        previewReviews: const <PlaceReviewPreviewModel>[
          PlaceReviewPreviewModel(
            author: 'Elena Rodriguez',
            avatarImagePath: 'assets/images/profile.jpg',
            initials: 'E',
            rating: 5,
            content:
                '"The best oat milk latte I\'ve had in South East Asia. The atmosphere is so peaceful, perfect for catching up on some journaling."',
          ),
          PlaceReviewPreviewModel(
            author: 'James Chen',
            initials: 'J',
            rating: 4,
            content:
                '"Amazing specialty coffee selection. A bit crowded on weekends, but definitely worth the wait for their signature pour-overs."',
          ),
        ],
      ),
      comment: PlaceCommentDataModel(
        title: title,
        category: category,
        priceLabel: '\$\$',
        distanceLabel: distanceLabel,
        imagePath: imagePath,
        primaryActionLabel: 'Navigate',
        secondaryActionLabel: 'Save',
        friendsSectionTitle: 'Friends love this spot',
        friendsSectionSubtitle: 'Based on 12 friend reviews',
        ratingLabel: rating.toStringAsFixed(1),
        friendReviews: const <PlaceFriendReviewModel>[
          PlaceFriendReviewModel(
            authorHandle: '@sarah',
            timeLabel: '2d ago',
            content:
                'Best latte art in town! Make sure to try the oat milk version.',
            initials: 'S',
            avatarImagePath: 'assets/images/profile.jpg',
          ),
          PlaceFriendReviewModel(
            authorHandle: '@mike_j',
            timeLabel: '1w ago',
            content: 'Great atmosphere for working. WiFi is super fast.',
            initials: 'M',
          ),
        ],
        reviewsActionLabel: 'View all 12 reviews',
        locationTitle: 'Location & Hours',
        addressLabel: addressLabel,
        statusLabel: 'Open',
        closingLabel: 'Closes 8 PM',
      ),
      reviewInsights: const PlaceReviewInsightsDataModel(
        title: 'Review Insights',
        summaryTitle: 'AI Sentiment Summary',
        sentimentValue: '85%',
        sentimentLabel: 'Positive',
        basedOnLabel: 'Based on 12 verified reviews',
        breakdowns: <PlaceReviewBreakdownModel>[
          PlaceReviewBreakdownModel(
            label: 'Love',
            valueLabel: '85%',
            progress: 0.85,
          ),
          PlaceReviewBreakdownModel(
            label: 'Normal',
            valueLabel: '10%',
            progress: 0.10,
          ),
          PlaceReviewBreakdownModel(
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
        reviews: <PlaceReviewItemModel>[
          PlaceReviewItemModel(
            id: 'jane',
            author: 'Jane D.',
            meta: '2 days ago - Verified Stay',
            content:
                'Absolutely loved the quiet morning walks here. The service was impeccable, especially the concierge who helped us book our tour.',
            rating: 5,
            tags: <String>['Helpful'],
            isHidden: false,
            initials: 'J',
          ),
          PlaceReviewItemModel(
            id: 'hidden',
            rating: 0,
            tags: <String>[],
            isHidden: true,
            initials: 'AI',
            hiddenTitle: 'Hidden by AI',
            hiddenSubtitle: 'Contains toxic language',
            flaggedTitle: 'Why was this flagged?',
            flaggedDescription:
                'The AI detected aggressive language and personal attacks that violate our community guidelines.',
            actionLabel: 'Reveal',
          ),
          PlaceReviewItemModel(
            id: 'mark',
            author: 'Mark S.',
            meta: '1 week ago',
            content:
                'Service was slow but the food was okay. I expected a bit more for the price point, honestly. It gets very crowded around noon.',
            rating: 3,
            tags: <String>['Wait time: 45m', 'Crowded'],
            isHidden: false,
            initials: 'M',
          ),
        ],
      ),
      map: const PlaceMapDataModel(
        title: 'Nearby Places',
        refineLabel: 'Refine Map',
        mapImagePath: 'assets/images/map.png',
        centerBadgeLabel: 'Best nearby pick',
        sheetTitle: 'Places around you',
        navigationActionLabel: 'Navigate',
        picks: <PlaceMapPickModel>[
          PlaceMapPickModel(
            id: 'bean-bloom-1',
            title: 'Bean & Bloom',
            subtitle: 'Specialty Coffee - 0.4 mi',
            imagePath: 'assets/images/bean_bloom.png',
            markerLabel: 'A',
            badgeLabel: 'Best Match',
            highlightLabel: '0.4 mi',
            rating: 4.8,
            isFeatured: true,
          ),
          PlaceMapPickModel(
            id: 'cafe-tan',
            title: 'Cafe Tan',
            subtitle: 'Coffee & Brunch - 0.9 mi',
            imagePath: 'assets/images/cafe_tan.png',
            markerLabel: 'B',
            badgeLabel: 'Alt',
            rating: 4.7,
          ),
          PlaceMapPickModel(
            id: 'korea-food',
            title: 'Korea Food',
            subtitle: 'Korean Cuisine - 1.2 mi',
            imagePath: 'assets/images/korea_food.jpeg',
            markerLabel: 'C',
            badgeLabel: 'Alt',
            rating: 4.6,
          ),
        ],
      ),
    );
  }
}
