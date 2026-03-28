import '../../domain/entities/create_moment_place.dart';

class CreateMomentPlaceModel {
  final String id;
  final String title;
  final String subtitle;
  final String distance;
  final String iconKey;

  const CreateMomentPlaceModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.distance,
    required this.iconKey,
  });

  CreateMomentPlace toEntity() {
    return CreateMomentPlace(
      id: id,
      title: title,
      subtitle: subtitle,
      distance: distance,
      iconKey: iconKey,
    );
  }
}
