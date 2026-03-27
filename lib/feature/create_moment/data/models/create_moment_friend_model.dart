import '../../domain/entities/create_moment_friend.dart';

class CreateMomentFriendModel {
  final String id;
  final String name;
  final String subtitle;
  final String? avatarPath;

  const CreateMomentFriendModel({
    required this.id,
    required this.name,
    required this.subtitle,
    this.avatarPath,
  });

  CreateMomentFriend toEntity() {
    return CreateMomentFriend(
      id: id,
      name: name,
      subtitle: subtitle,
      avatarPath: avatarPath,
    );
  }
}
