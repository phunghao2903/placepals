import 'create_moment_friend.dart';
import 'create_moment_place.dart';
import 'create_moment_photo.dart';
import 'create_moment_privacy_option.dart';
import 'create_moment_vibe_tag.dart';

class CreateMomentFeed {
  final String title;
  final String draftsLabel;
  final String addPhotoLabel;
  final String mediaPickerTitle;
  final String mediaPickerActionLabel;
  final String rateTitle;
  final String rateSubtitle;
  final String captionTitle;
  final String captionHint;
  final String vibeTagsTitle;
  final String vibeTagsSubtitle;
  final String tagFriendsTitle;
  final String tagFriendsHint;
  final String friendSearchHint;
  final String privacyTitle;
  final String privacyHint;
  final String locationTitle;
  final String locationHint;
  final String locationSearchHint;
  final String pickOnMapLabel;
  final String nearbyPlacesTitle;
  final String shareLabel;
  final List<CreateMomentPhoto> photos;
  final List<CreateMomentVibeTag> vibeTags;
  final List<CreateMomentFriend> friends;
  final List<CreateMomentPrivacyOption> privacyOptions;
  final List<CreateMomentPlace> nearbyPlaces;

  const CreateMomentFeed({
    required this.title,
    required this.draftsLabel,
    required this.addPhotoLabel,
    required this.mediaPickerTitle,
    required this.mediaPickerActionLabel,
    required this.rateTitle,
    required this.rateSubtitle,
    required this.captionTitle,
    required this.captionHint,
    required this.vibeTagsTitle,
    required this.vibeTagsSubtitle,
    required this.tagFriendsTitle,
    required this.tagFriendsHint,
    required this.friendSearchHint,
    required this.privacyTitle,
    required this.privacyHint,
    required this.locationTitle,
    required this.locationHint,
    required this.locationSearchHint,
    required this.pickOnMapLabel,
    required this.nearbyPlacesTitle,
    required this.shareLabel,
    required this.photos,
    required this.vibeTags,
    required this.friends,
    required this.privacyOptions,
    required this.nearbyPlaces,
  });
}
