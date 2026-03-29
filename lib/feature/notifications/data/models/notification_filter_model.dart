import '../../domain/entities/notification_filter.dart';

class NotificationFilterModel {
  final String id;
  final String label;
  final NotificationFilterType type;
  final bool isSelected;

  const NotificationFilterModel({
    required this.id,
    required this.label,
    required this.type,
    required this.isSelected,
  });

  NotificationFilter toEntity() {
    return NotificationFilter(
      id: id,
      label: label,
      type: type,
      isSelected: isSelected,
    );
  }
}
