class CreateMomentVibeTag {
  final String id;
  final String label;
  final String iconKey;
  final bool isDefaultSelected;

  const CreateMomentVibeTag({
    required this.id,
    required this.label,
    required this.iconKey,
    this.isDefaultSelected = false,
  });
}
