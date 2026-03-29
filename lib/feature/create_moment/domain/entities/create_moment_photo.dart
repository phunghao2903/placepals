class CreateMomentPhoto {
  final String id;
  final String? imagePath;
  final bool isPlaceholder;
  final String label;

  const CreateMomentPhoto({
    required this.id,
    this.imagePath,
    this.isPlaceholder = false,
    this.label = '',
  });
}
