import '../../domain/entities/profile_feed.dart';

class ProfileFeedModel {
  final String title;
  final ProfileUserModel user;
  final List<ProfileQuickActionModel> quickActions;
  final List<ProfileInsightModel> insights;
  final List<ProfileTabOptionModel> tabs;
  final List<ProfileFilterOptionModel> cityFilters;
  final List<ProfileSortOptionModel> sortOptions;
  final ProfileViewMode viewMode;
  final List<ProfilePlaceItemModel> places;

  const ProfileFeedModel({
    required this.title,
    required this.user,
    required this.quickActions,
    required this.insights,
    required this.tabs,
    required this.cityFilters,
    required this.sortOptions,
    required this.viewMode,
    required this.places,
  });

  ProfileFeed toEntity() {
    return ProfileFeed(
      title: title,
      user: user.toEntity(),
      quickActions: quickActions.map((item) => item.toEntity()).toList(),
      insights: insights.map((item) => item.toEntity()).toList(),
      tabs: tabs.map((item) => item.toEntity()).toList(),
      cityFilters: cityFilters.map((item) => item.toEntity()).toList(),
      sortOptions: sortOptions.map((item) => item.toEntity()).toList(),
      viewMode: viewMode,
      places: places.map((item) => item.toEntity()).toList(),
    );
  }
}

class ProfileUserModel {
  final String name;
  final String username;
  final String bio;
  final String joinedLabel;
  final String avatarPath;
  final List<ProfileSummaryStatModel> summaryStats;

  const ProfileUserModel({
    required this.name,
    required this.username,
    required this.bio,
    required this.joinedLabel,
    required this.avatarPath,
    required this.summaryStats,
  });

  ProfileUser toEntity() {
    return ProfileUser(
      name: name,
      username: username,
      bio: bio,
      joinedLabel: joinedLabel,
      avatarPath: avatarPath,
      summaryStats: summaryStats.map((item) => item.toEntity()).toList(),
    );
  }
}

class ProfileSummaryStatModel {
  final String value;
  final String label;

  const ProfileSummaryStatModel({required this.value, required this.label});

  ProfileSummaryStat toEntity() {
    return ProfileSummaryStat(value: value, label: label);
  }
}

class ProfileQuickActionModel {
  final String id;
  final String label;
  final String iconKey;

  const ProfileQuickActionModel({
    required this.id,
    required this.label,
    required this.iconKey,
  });

  ProfileQuickAction toEntity() {
    return ProfileQuickAction(id: id, label: label, iconKey: iconKey);
  }
}

class ProfileInsightModel {
  final String id;
  final String label;
  final String value;
  final String delta;
  final bool isHighlighted;

  const ProfileInsightModel({
    required this.id,
    required this.label,
    required this.value,
    required this.delta,
    required this.isHighlighted,
  });

  ProfileInsight toEntity() {
    return ProfileInsight(
      id: id,
      label: label,
      value: value,
      delta: delta,
      isHighlighted: isHighlighted,
    );
  }
}

class ProfileTabOptionModel {
  final String id;
  final String label;
  final bool isSelected;

  const ProfileTabOptionModel({
    required this.id,
    required this.label,
    required this.isSelected,
  });

  ProfileTabOption toEntity() {
    return ProfileTabOption(id: id, label: label, isSelected: isSelected);
  }
}

class ProfileFilterOptionModel {
  final String id;
  final String label;
  final int count;
  final bool isSelected;

  const ProfileFilterOptionModel({
    required this.id,
    required this.label,
    required this.count,
    required this.isSelected,
  });

  ProfileFilterOption toEntity() {
    return ProfileFilterOption(
      id: id,
      label: label,
      count: count,
      isSelected: isSelected,
    );
  }
}

class ProfileSortOptionModel {
  final String id;
  final String label;
  final bool isSelected;

  const ProfileSortOptionModel({
    required this.id,
    required this.label,
    required this.isSelected,
  });

  ProfileSortOption toEntity() {
    return ProfileSortOption(id: id, label: label, isSelected: isSelected);
  }
}

class ProfilePlaceItemModel {
  final String id;
  final String title;
  final String city;
  final double rating;
  final int views;
  final int likes;
  final String imagePath;
  final bool isSaved;

  const ProfilePlaceItemModel({
    required this.id,
    required this.title,
    required this.city,
    required this.rating,
    required this.views,
    required this.likes,
    required this.imagePath,
    required this.isSaved,
  });

  ProfilePlaceItem toEntity() {
    return ProfilePlaceItem(
      id: id,
      title: title,
      city: city,
      rating: rating,
      views: views,
      likes: likes,
      imagePath: imagePath,
      isSaved: isSaved,
    );
  }
}
