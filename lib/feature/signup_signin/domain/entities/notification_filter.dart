class NotificationFilter {
  final String id;
  final String label;
  final bool isSelected;

  const NotificationFilter({
    required this.id,
    required this.label,
    required this.isSelected,
  });

  NotificationFilter copyWith({String? id, String? label, bool? isSelected}) {
    return NotificationFilter(
      id: id ?? this.id,
      label: label ?? this.label,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
