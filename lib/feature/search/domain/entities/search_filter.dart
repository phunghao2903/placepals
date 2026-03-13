class SearchFilter {
  final String id;
  final String label;
  final bool isSelected;

  const SearchFilter({
    required this.id,
    required this.label,
    required this.isSelected,
  });

  SearchFilter copyWith({
    String? id,
    String? label,
    bool? isSelected,
  }) {
    return SearchFilter(
      id: id ?? this.id,
      label: label ?? this.label,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
