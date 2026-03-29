class CreateMomentFriend {
  final String id;
  final String name;
  final String subtitle;
  final String? avatarPath;

  const CreateMomentFriend({
    required this.id,
    required this.name,
    required this.subtitle,
    this.avatarPath,
  });
}
