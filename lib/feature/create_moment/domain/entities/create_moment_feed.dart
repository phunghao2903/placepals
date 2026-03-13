import 'create_moment_photo.dart';

class CreateMomentFeed {
  final String title;
  final String draftsLabel;
  final String addPhotoLabel;
  final String rateTitle;
  final String rateSubtitle;
  final String captionTitle;
  final String captionHint;
  final String locationTitle;
  final String locationHint;
  final String shareLabel;
  final List<CreateMomentPhoto> photos;

  const CreateMomentFeed({
    required this.title,
    required this.draftsLabel,
    required this.addPhotoLabel,
    required this.rateTitle,
    required this.rateSubtitle,
    required this.captionTitle,
    required this.captionHint,
    required this.locationTitle,
    required this.locationHint,
    required this.shareLabel,
    required this.photos,
  });
}
