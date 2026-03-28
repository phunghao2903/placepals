import '../../domain/entities/create_moment_feed.dart';
import 'create_moment_photo_model.dart';
import 'create_moment_friend_model.dart';
import 'create_moment_place_model.dart';
import 'create_moment_privacy_option_model.dart';
import 'create_moment_vibe_tag_model.dart';

class CreateMomentFeedModel {
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
  final List<CreateMomentPhotoModel> photos;
  final List<CreateMomentVibeTagModel> vibeTags;
  final List<CreateMomentFriendModel> friends;
  final List<CreateMomentPrivacyOptionModel> privacyOptions;
  final List<CreateMomentPlaceModel> nearbyPlaces;

  const CreateMomentFeedModel({
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

  CreateMomentFeed toEntity() {
    return CreateMomentFeed(
      title: title,
      draftsLabel: draftsLabel,
      addPhotoLabel: addPhotoLabel,
      mediaPickerTitle: mediaPickerTitle,
      mediaPickerActionLabel: mediaPickerActionLabel,
      rateTitle: rateTitle,
      rateSubtitle: rateSubtitle,
      captionTitle: captionTitle,
      captionHint: captionHint,
      vibeTagsTitle: vibeTagsTitle,
      vibeTagsSubtitle: vibeTagsSubtitle,
      tagFriendsTitle: tagFriendsTitle,
      tagFriendsHint: tagFriendsHint,
      friendSearchHint: friendSearchHint,
      privacyTitle: privacyTitle,
      privacyHint: privacyHint,
      locationTitle: locationTitle,
      locationHint: locationHint,
      locationSearchHint: locationSearchHint,
      pickOnMapLabel: pickOnMapLabel,
      nearbyPlacesTitle: nearbyPlacesTitle,
      shareLabel: shareLabel,
      photos: photos.map((item) => item.toEntity()).toList(),
      vibeTags: vibeTags.map((item) => item.toEntity()).toList(),
      friends: friends.map((item) => item.toEntity()).toList(),
      privacyOptions: privacyOptions.map((item) => item.toEntity()).toList(),
      nearbyPlaces: nearbyPlaces.map((item) => item.toEntity()).toList(),
    );
  }
}
