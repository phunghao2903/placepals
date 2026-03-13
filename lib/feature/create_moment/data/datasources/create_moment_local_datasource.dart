import '../models/create_moment_feed_model.dart';
import '../models/create_moment_photo_model.dart';

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
      rateTitle: 'Rate Experience',
      rateSubtitle: 'How was the vibe?',
      captionTitle: 'Caption',
      captionHint: 'Wirte a caption about this moment',
      locationTitle: 'Add Location',
      locationHint: 'Where did this happen?',
      shareLabel: 'Share Moment',
      photos: <CreateMomentPhotoModel>[
        CreateMomentPhotoModel(
          id: 'photo-1',
          imagePath: 'assets/images/bean_bloom.png',
          isPlaceholder: false,
        ),
        CreateMomentPhotoModel(
          id: 'photo-2',
          isPlaceholder: true,
        ),
      ],
    );
  }
}
