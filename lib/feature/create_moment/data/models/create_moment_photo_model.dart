import '../../domain/entities/create_moment_photo.dart';

class CreateMomentPhotoModel {
  final String id;
  final String? imagePath;
  final bool isPlaceholder;
  final String label;

  const CreateMomentPhotoModel({
    required this.id,
    this.imagePath,
    required this.isPlaceholder,
    this.label = '',
  });

  CreateMomentPhoto toEntity() {
    return CreateMomentPhoto(
      id: id,
      imagePath: imagePath,
      isPlaceholder: isPlaceholder,
      label: label,
    );
  }
}
