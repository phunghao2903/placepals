enum ProfileViewMode { grid, list }

class ProfileFeed {
  final String title;
  final ProfileUser user;
  final List<ProfileQuickAction> quickActions;
  final List<ProfileInsight> insights;
  final List<ProfileTabOption> tabs;
  final List<ProfileFilterOption> cityFilters;
  final List<ProfileSortOption> sortOptions;
  final ProfileViewMode viewMode;
  final List<ProfilePlaceItem> places;

  const ProfileFeed({
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

  ProfileFeed copyWith({
    String? title,
    ProfileUser? user,
    List<ProfileQuickAction>? quickActions,
    List<ProfileInsight>? insights,
    List<ProfileTabOption>? tabs,
    List<ProfileFilterOption>? cityFilters,
    List<ProfileSortOption>? sortOptions,
    ProfileViewMode? viewMode,
    List<ProfilePlaceItem>? places,
  }) {
    return ProfileFeed(
      title: title ?? this.title,
      user: user ?? this.user,
      quickActions: quickActions ?? this.quickActions,
      insights: insights ?? this.insights,
      tabs: tabs ?? this.tabs,
      cityFilters: cityFilters ?? this.cityFilters,
      sortOptions: sortOptions ?? this.sortOptions,
      viewMode: viewMode ?? this.viewMode,
      places: places ?? this.places,
    );
  }
}

class ProfileUser {
  final String name;
  final String username;
  final String bio;
  final String joinedLabel;
  final String avatarPath;
  final String? coverImagePath;
  final List<ProfileSummaryStat> summaryStats;

  const ProfileUser({
    required this.name,
    required this.username,
    required this.bio,
    required this.joinedLabel,
    required this.avatarPath,
    required this.coverImagePath,
    required this.summaryStats,
  });

  ProfileUser copyWith({
    String? name,
    String? username,
    String? bio,
    String? joinedLabel,
    String? avatarPath,
    String? coverImagePath,
    List<ProfileSummaryStat>? summaryStats,
  }) {
    return ProfileUser(
      name: name ?? this.name,
      username: username ?? this.username,
      bio: bio ?? this.bio,
      joinedLabel: joinedLabel ?? this.joinedLabel,
      avatarPath: avatarPath ?? this.avatarPath,
      coverImagePath: coverImagePath ?? this.coverImagePath,
      summaryStats: summaryStats ?? this.summaryStats,
    );
  }
}

class ProfileSummaryStat {
  final String value;
  final String label;

  const ProfileSummaryStat({required this.value, required this.label});
}

class ProfileQuickAction {
  final String id;
  final String label;
  final String iconKey;

  const ProfileQuickAction({
    required this.id,
    required this.label,
    required this.iconKey,
  });
}

class ProfileInsight {
  final String id;
  final String label;
  final String value;
  final String delta;
  final bool isHighlighted;

  const ProfileInsight({
    required this.id,
    required this.label,
    required this.value,
    required this.delta,
    required this.isHighlighted,
  });
}

class ProfileTabOption {
  final String id;
  final String label;
  final bool isSelected;

  const ProfileTabOption({
    required this.id,
    required this.label,
    required this.isSelected,
  });

  ProfileTabOption copyWith({String? id, String? label, bool? isSelected}) {
    return ProfileTabOption(
      id: id ?? this.id,
      label: label ?? this.label,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

class ProfileFilterOption {
  final String id;
  final String label;
  final int count;
  final bool isSelected;

  const ProfileFilterOption({
    required this.id,
    required this.label,
    required this.count,
    required this.isSelected,
  });

  ProfileFilterOption copyWith({
    String? id,
    String? label,
    int? count,
    bool? isSelected,
  }) {
    return ProfileFilterOption(
      id: id ?? this.id,
      label: label ?? this.label,
      count: count ?? this.count,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

class ProfileSortOption {
  final String id;
  final String label;
  final bool isSelected;

  const ProfileSortOption({
    required this.id,
    required this.label,
    required this.isSelected,
  });

  ProfileSortOption copyWith({String? id, String? label, bool? isSelected}) {
    return ProfileSortOption(
      id: id ?? this.id,
      label: label ?? this.label,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

class ProfilePlaceItem {
  final String id;
  final String title;
  final String city;
  final double rating;
  final int views;
  final int likes;
  final String imagePath;
  final bool isSaved;

  const ProfilePlaceItem({
    required this.id,
    required this.title,
    required this.city,
    required this.rating,
    required this.views,
    required this.likes,
    required this.imagePath,
    required this.isSaved,
  });

  ProfilePlaceItem copyWith({
    String? id,
    String? title,
    String? city,
    double? rating,
    int? views,
    int? likes,
    String? imagePath,
    bool? isSaved,
  }) {
    return ProfilePlaceItem(
      id: id ?? this.id,
      title: title ?? this.title,
      city: city ?? this.city,
      rating: rating ?? this.rating,
      views: views ?? this.views,
      likes: likes ?? this.likes,
      imagePath: imagePath ?? this.imagePath,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}
