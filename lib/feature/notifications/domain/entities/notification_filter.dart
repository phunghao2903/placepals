enum NotificationFilterType { all, unread, sosAlerts }

class NotificationFilter {
  final String id;
  final String label;
  final NotificationFilterType type;
  final bool isSelected;

  const NotificationFilter({
    required this.id,
    required this.label,
    required this.type,
    required this.isSelected,
  });

  NotificationFilter copyWith({
    String? id,
    String? label,
    NotificationFilterType? type,
    bool? isSelected,
  }) {
    return NotificationFilter(
      id: id ?? this.id,
      label: label ?? this.label,
      type: type ?? this.type,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
