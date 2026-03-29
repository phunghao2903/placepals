import '../../domain/entities/notification_item.dart';

class NotificationItemModel {
  final String id;
  final String title;
  final String message;
  final String relativeTime;
  final String? imagePath;
  final String section;
  final String type;
  final String destination;
  final bool isRead;

  const NotificationItemModel({
    required this.id,
    required this.title,
    required this.message,
    required this.relativeTime,
    required this.section,
    required this.type,
    required this.destination,
    required this.isRead,
    this.imagePath,
  });

  NotificationItem toEntity() {
    return NotificationItem(
      id: id,
      title: title,
      message: message,
      relativeTime: relativeTime,
      imagePath: imagePath,
      section: _mapSection(section),
      type: _mapType(type),
      destination: _mapDestination(destination),
      isRead: isRead,
    );
  }

  NotificationSection _mapSection(String value) {
    switch (value) {
      case 'yesterday':
        return NotificationSection.yesterday;
      case 'today':
      default:
        return NotificationSection.today;
    }
  }

  NotificationType _mapType(String value) {
    switch (value) {
      case 'sosAlert':
        return NotificationType.sosAlert;
      case 'recommendation':
        return NotificationType.recommendation;
      case 'locationVerified':
        return NotificationType.locationVerified;
      case 'tagged':
        return NotificationType.tagged;
      case 'palRequest':
      default:
        return NotificationType.palRequest;
    }
  }

  NotificationDestination _mapDestination(String value) {
    switch (value) {
      case 'sos':
        return NotificationDestination.sos;
      case 'map':
        return NotificationDestination.map;
      case 'profile':
      default:
        return NotificationDestination.profile;
    }
  }
}
