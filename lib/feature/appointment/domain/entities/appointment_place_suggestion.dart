enum AppointmentPlaceStatus {
  open,
  closingSoon,
  unknown,
}

class AppointmentPlaceSuggestion {
  final String id;
  final String name;
  final String cuisine;
  final String priceLabel;
  final String distanceLabel;
  final double rating;
  final int reviewsCount;
  final String imageAssetPath;
  final AppointmentPlaceStatus status;
  final String statusLabel;
  final String socialProofLabel;
  final double voteProgress;
  final bool isSelected;
  final bool isTopChoice;
  final bool isHighlighted;

  const AppointmentPlaceSuggestion({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.priceLabel,
    required this.distanceLabel,
    required this.rating,
    required this.reviewsCount,
    required this.imageAssetPath,
    required this.status,
    required this.statusLabel,
    required this.socialProofLabel,
    required this.voteProgress,
    required this.isSelected,
    required this.isTopChoice,
    required this.isHighlighted,
  });

  AppointmentPlaceSuggestion copyWith({
    String? id,
    String? name,
    String? cuisine,
    String? priceLabel,
    String? distanceLabel,
    double? rating,
    int? reviewsCount,
    String? imageAssetPath,
    AppointmentPlaceStatus? status,
    String? statusLabel,
    String? socialProofLabel,
    double? voteProgress,
    bool? isSelected,
    bool? isTopChoice,
    bool? isHighlighted,
  }) {
    return AppointmentPlaceSuggestion(
      id: id ?? this.id,
      name: name ?? this.name,
      cuisine: cuisine ?? this.cuisine,
      priceLabel: priceLabel ?? this.priceLabel,
      distanceLabel: distanceLabel ?? this.distanceLabel,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      imageAssetPath: imageAssetPath ?? this.imageAssetPath,
      status: status ?? this.status,
      statusLabel: statusLabel ?? this.statusLabel,
      socialProofLabel: socialProofLabel ?? this.socialProofLabel,
      voteProgress: voteProgress ?? this.voteProgress,
      isSelected: isSelected ?? this.isSelected,
      isTopChoice: isTopChoice ?? this.isTopChoice,
      isHighlighted: isHighlighted ?? this.isHighlighted,
    );
  }
}
