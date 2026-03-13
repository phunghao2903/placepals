import '../../domain/entities/create_moment_feed.dart';
import 'create_moment_photo_model.dart';

class CreateMomentFeedModel {
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
  final List<CreateMomentPhotoModel> photos;

  const CreateMomentFeedModel({
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

  CreateMomentFeed toEntity() {
    return CreateMomentFeed(
      title: title,
      draftsLabel: draftsLabel,
      addPhotoLabel: addPhotoLabel,
      rateTitle: rateTitle,
      rateSubtitle: rateSubtitle,
      captionTitle: captionTitle,
      captionHint: captionHint,
      locationTitle: locationTitle,
      locationHint: locationHint,
      shareLabel: shareLabel,
      photos: photos.map((item) => item.toEntity()).toList(),
    );
  }
}
