import '../models/create_moment_feed_model.dart';
import '../models/create_moment_friend_model.dart';
import '../models/create_moment_place_model.dart';
import '../models/create_moment_photo_model.dart';
import '../models/create_moment_privacy_option_model.dart';
import '../models/create_moment_vibe_tag_model.dart';

abstract class CreateMomentLocalDataSource {
  Future<CreateMomentFeedModel> getCreateMomentFeed();
}

class CreateMomentLocalDataSourceImpl implements CreateMomentLocalDataSource {
  @override
  Future<CreateMomentFeedModel> getCreateMomentFeed() async {
    return const CreateMomentFeedModel(
      title: 'Create Moment',
      draftsLabel: 'Drafts',
      addPhotoLabel: 'Add Photo',
      mediaPickerTitle: 'Recents',
      mediaPickerActionLabel: 'Add Photos',
      rateTitle: 'Rate Experience',
      rateSubtitle: 'How was the vibe?',
      captionTitle: 'Caption',
      captionHint: 'Write a caption about this moment',
      vibeTagsTitle: 'Vibe Tags',
      vibeTagsSubtitle: 'Select all that apply',
      tagFriendsTitle: 'Tag Friends',
      tagFriendsHint: 'With who did you go?',
      friendSearchHint: 'Search friends...',
      privacyTitle: 'Visibility',
      privacyHint: 'Who can see this log?',
      locationTitle: 'Add Location',
      locationHint: 'Where did this happen?',
      locationSearchHint: 'Search for places, cities...',
      pickOnMapLabel: 'Pick on Map',
      nearbyPlacesTitle: 'Nearby Places',
      shareLabel: 'Share Moment',
      photos: <CreateMomentPhotoModel>[
        CreateMomentPhotoModel(
          id: 'photo-1',
          imagePath: 'assets/images/bean_bloom.png',
          isPlaceholder: false,
          label: '',
        ),
        CreateMomentPhotoModel(
          id: 'photo-2',
          imagePath: 'assets/images/cafe_tan.png',
          isPlaceholder: false,
          label: '',
        ),
        CreateMomentPhotoModel(
          id: 'photo-3',
          imagePath: 'assets/images/korea_food.jpeg',
          isPlaceholder: false,
          label: '',
        ),
        CreateMomentPhotoModel(
          id: 'photo-4',
          imagePath: 'assets/images/map.png',
          isPlaceholder: false,
          label: '',
        ),
        CreateMomentPhotoModel(
          id: 'photo-5',
          imagePath: 'assets/images/bean_bloom.png',
          isPlaceholder: false,
          label: '',
        ),
        CreateMomentPhotoModel(
          id: 'photo-6',
          imagePath: 'assets/images/cafe_tan.png',
          isPlaceholder: false,
          label: '',
        ),
        CreateMomentPhotoModel(
          id: 'photo-7',
          imagePath: 'assets/images/korea_food.jpeg',
          isPlaceholder: false,
          label: '',
        ),
        CreateMomentPhotoModel(
          id: 'photo-8',
          imagePath: 'assets/images/bean_bloom.png',
          isPlaceholder: false,
          label: '',
        ),
        CreateMomentPhotoModel(
          id: 'photo-9',
          imagePath: 'assets/images/cafe_tan.png',
          isPlaceholder: false,
          label: '',
        ),
        CreateMomentPhotoModel(
          id: 'camera',
          isPlaceholder: true,
          label: 'Camera',
        ),
      ],
      vibeTags: <CreateMomentVibeTagModel>[
        CreateMomentVibeTagModel(
          id: 'cozy',
          label: 'Cozy',
          iconKey: 'whatshot',
          isDefaultSelected: true,
        ),
        CreateMomentVibeTagModel(
          id: 'great-music',
          label: 'Great Music',
          iconKey: 'music_note',
        ),
        CreateMomentVibeTagModel(
          id: 'expensive',
          label: 'Expensive',
          iconKey: 'favorite',
        ),
        CreateMomentVibeTagModel(
          id: 'hidden-gem',
          label: 'Hidden Gem',
          iconKey: 'diamond',
        ),
        CreateMomentVibeTagModel(id: 'wifi', label: 'Wifi', iconKey: 'wifi'),
        CreateMomentVibeTagModel(
          id: 'dog-friendly',
          label: 'Dog Friendly',
          iconKey: 'pets',
        ),
        CreateMomentVibeTagModel(
          id: 'outdoor-seating',
          label: 'Outdoor Seating',
          iconKey: 'deck',
        ),
        CreateMomentVibeTagModel(
          id: 'cocktails',
          label: 'Cocktails',
          iconKey: 'local_bar',
        ),
        CreateMomentVibeTagModel(
          id: 'add-tag',
          label: 'Add tag',
          iconKey: 'add_circle',
        ),
      ],
      friends: <CreateMomentFriendModel>[
        CreateMomentFriendModel(
          id: 'friend-1',
          name: 'Mia Tran',
          subtitle: 'Coffee hopping buddy',
          avatarPath: 'assets/images/profile.jpg',
        ),
        CreateMomentFriendModel(
          id: 'friend-2',
          name: 'Kai Nguyen',
          subtitle: 'Always finds hidden spots',
        ),
        CreateMomentFriendModel(
          id: 'friend-3',
          name: 'Linh Do',
          subtitle: 'Weekend brunch crew',
        ),
        CreateMomentFriendModel(
          id: 'friend-4',
          name: 'Noah Pham',
          subtitle: 'Live music regular',
        ),
        CreateMomentFriendModel(
          id: 'friend-5',
          name: 'An Bui',
          subtitle: 'Takes the best food pics',
        ),
      ],
      privacyOptions: <CreateMomentPrivacyOptionModel>[
        CreateMomentPrivacyOptionModel(id: 'public', label: 'Public'),
        CreateMomentPrivacyOptionModel(id: 'friends', label: 'Friends'),
        CreateMomentPrivacyOptionModel(id: 'private', label: 'Private'),
      ],
      nearbyPlaces: <CreateMomentPlaceModel>[
        CreateMomentPlaceModel(
          id: 'coffee-house',
          title: 'The Coffee House',
          subtitle: '123 Main St, Downtown',
          distance: '0.2 mi',
          iconKey: 'local_cafe',
        ),
        CreateMomentPlaceModel(
          id: 'central-park',
          title: 'Central Park',
          subtitle: 'Midtown West',
          distance: '0.5 mi',
          iconKey: 'park',
        ),
        CreateMomentPlaceModel(
          id: 'bella-italia',
          title: 'Bella Italia',
          subtitle: '45 Napoli Ave',
          distance: '0.8 mi',
          iconKey: 'restaurant',
        ),
        CreateMomentPlaceModel(
          id: 'city-library',
          title: 'City Library',
          subtitle: 'Public Square',
          distance: '1.2 mi',
          iconKey: 'local_library',
        ),
        CreateMomentPlaceModel(
          id: 'fitlife-gym',
          title: 'FitLife Gym',
          subtitle: 'Market Street',
          distance: '1.5 mi',
          iconKey: 'fitness_center',
        ),
      ],
    );
  }
}
