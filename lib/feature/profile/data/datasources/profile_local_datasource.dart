import 'package:placepals/feature/profile/domain/entities/profile_feed.dart';

import '../models/profile_feed_model.dart';

abstract class ProfileLocalDataSource {
  Future<ProfileFeedModel> getProfileFeed();
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  @override
  Future<ProfileFeedModel> getProfileFeed() async {
    return const ProfileFeedModel(
      title: 'My Profile',
      user: ProfileUserModel(
        name: 'Sarah Johnson',
        username: '@sarahjohnson',
        bio: 'Coffee lover | Travel enthusiast\nSharing hidden gems',
        joinedLabel: 'Joined January 2024',
        avatarPath: 'assets/images/profile.jpg',
        summaryStats: <ProfileSummaryStatModel>[
          ProfileSummaryStatModel(value: '24', label: 'Places'),
          ProfileSummaryStatModel(value: '1.2K', label: 'Likes'),
          ProfileSummaryStatModel(value: '342', label: 'Followers'),
          ProfileSummaryStatModel(value: '186', label: 'Following'),
        ],
      ),
      quickActions: <ProfileQuickActionModel>[
        ProfileQuickActionModel(
          id: 'friends',
          label: 'Find Friends',
          iconKey: 'friends',
        ),
        ProfileQuickActionModel(
          id: 'achievements',
          label: 'Achievements',
          iconKey: 'achievements',
        ),
        ProfileQuickActionModel(
          id: 'privacy',
          label: 'Privacy',
          iconKey: 'privacy',
        ),
      ],
      insights: <ProfileInsightModel>[
        ProfileInsightModel(
          id: 'views',
          label: 'Profile Views',
          value: '1,234',
          delta: '+12% this week',
          isHighlighted: false,
        ),
        ProfileInsightModel(
          id: 'likes',
          label: 'New Likes',
          value: '156',
          delta: '+8% this week',
          isHighlighted: true,
        ),
        ProfileInsightModel(
          id: 'followers',
          label: 'New Followers',
          value: '23',
          delta: '+5% this week',
          isHighlighted: false,
        ),
      ],
      tabs: <ProfileTabOptionModel>[
        ProfileTabOptionModel(
          id: 'places',
          label: 'My Places',
          isSelected: true,
        ),
        ProfileTabOptionModel(id: 'saved', label: 'Saved', isSelected: false),
        ProfileTabOptionModel(
          id: 'insights',
          label: 'Insights',
          isSelected: false,
        ),
      ],
      cityFilters: <ProfileFilterOptionModel>[
        ProfileFilterOptionModel(
          id: 'all',
          label: 'All Cities',
          count: 8,
          isSelected: true,
        ),
        ProfileFilterOptionModel(
          id: 'da_nang',
          label: 'Da Nang',
          count: 2,
          isSelected: false,
        ),
        ProfileFilterOptionModel(
          id: 'hue',
          label: 'Hue',
          count: 2,
          isSelected: false,
        ),
        ProfileFilterOptionModel(
          id: 'hoi_an',
          label: 'Hoi An',
          count: 4,
          isSelected: false,
        ),
      ],
      sortOptions: <ProfileSortOptionModel>[
        ProfileSortOptionModel(id: 'recent', label: 'Recent', isSelected: true),
        ProfileSortOptionModel(
          id: 'views',
          label: 'Most Views',
          isSelected: false,
        ),
        ProfileSortOptionModel(
          id: 'rating',
          label: 'Top Rated',
          isSelected: false,
        ),
      ],
      viewMode: ProfileViewMode.grid,
      places: <ProfilePlaceItemModel>[
        ProfilePlaceItemModel(
          id: 'bean_bloom',
          title: 'Bean & Bloom',
          city: 'Da Nang',
          rating: 4.8,
          views: 234,
          likes: 45,
          imagePath: 'assets/images/bean_bloom.png',
          isSaved: true,
        ),
        ProfilePlaceItemModel(
          id: 'garden_terrace',
          title: 'Garden Terrace',
          city: 'Da Nang',
          rating: 4.9,
          views: 456,
          likes: 89,
          imagePath: 'assets/images/cafe_tan.png',
          isSaved: true,
        ),
        ProfilePlaceItemModel(
          id: 'sunset_rooftop',
          title: 'Sunset Rooftop',
          city: 'Hue',
          rating: 4.7,
          views: 189,
          likes: 32,
          imagePath: 'assets/images/korea_food.jpeg',
          isSaved: false,
        ),
        ProfilePlaceItemModel(
          id: 'art_gallery',
          title: 'The Art Gallery Cafe',
          city: 'Hue',
          rating: 4.6,
          views: 312,
          likes: 67,
          imagePath: 'assets/images/cafe_tan.png',
          isSaved: false,
        ),
        ProfilePlaceItemModel(
          id: 'bean_bloom_hoi_an',
          title: 'Bean & Bloom',
          city: 'Hoi An',
          rating: 4.8,
          views: 234,
          likes: 45,
          imagePath: 'assets/images/bean_bloom.png',
          isSaved: false,
        ),
        ProfilePlaceItemModel(
          id: 'garden_terrace_hoi_an',
          title: 'Garden Terrace',
          city: 'Hoi An',
          rating: 4.9,
          views: 456,
          likes: 89,
          imagePath: 'assets/images/cafe_tan.png',
          isSaved: false,
        ),
        ProfilePlaceItemModel(
          id: 'sunset_rooftop_hoi_an',
          title: 'Sunset Rooftop',
          city: 'Hoi An',
          rating: 4.7,
          views: 189,
          likes: 32,
          imagePath: 'assets/images/korea_food.jpeg',
          isSaved: false,
        ),
        ProfilePlaceItemModel(
          id: 'art_gallery_hoi_an',
          title: 'The Art Gallery Cafe',
          city: 'Hoi An',
          rating: 4.6,
          views: 312,
          likes: 67,
          imagePath: 'assets/images/cafe_tan.png',
          isSaved: false,
        ),
      ],
    );
  }
}
