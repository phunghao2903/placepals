class CreateMomentPhoto {
  final String id;
  final String? imagePath;
  final bool isPlaceholder;

  const CreateMomentPhoto({
    required this.id,
    this.imagePath,
    this.isPlaceholder = false,
  });
}
