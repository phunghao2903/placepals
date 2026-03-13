import '../../domain/entities/search_filter.dart';

class SearchFilterModel {
  final String id;
  final String label;
  final bool isSelected;

  const SearchFilterModel({
    required this.id,
    required this.label,
    required this.isSelected,
  });

  SearchFilter toEntity() {
    return SearchFilter(
      id: id,
      label: label,
      isSelected: isSelected,
    );
  }
}
