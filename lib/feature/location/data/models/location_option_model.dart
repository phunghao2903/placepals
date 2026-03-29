import '../../domain/entities/location_option.dart';

class LocationOptionModel extends LocationOption {
  const LocationOptionModel({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.imagePath,
    required super.isPopular,
    required super.isCurrentLocation,
  });
}
