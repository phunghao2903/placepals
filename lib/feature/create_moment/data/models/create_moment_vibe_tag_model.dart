import '../../domain/entities/create_moment_vibe_tag.dart';

class CreateMomentVibeTagModel {
  final String id;
  final String label;
  final String iconKey;
  final bool isDefaultSelected;

  const CreateMomentVibeTagModel({
    required this.id,
    required this.label,
    required this.iconKey,
    this.isDefaultSelected = false,
  });

  CreateMomentVibeTag toEntity() {
    return CreateMomentVibeTag(
      id: id,
      label: label,
      iconKey: iconKey,
      isDefaultSelected: isDefaultSelected,
    );
  }
}
