import '../../domain/entities/map_guide.dart';

class MapGuideModel {
  final String id;
  final String title;
  final String subtitle;
  final String imagePath;
  final String badgeLabel;

  const MapGuideModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    this.badgeLabel = 'Guide',
  });

  MapGuide toEntity() {
    return MapGuide(
      id: id,
      title: title,
      subtitle: subtitle,
      imagePath: imagePath,
      badgeLabel: badgeLabel,
    );
  }
}
