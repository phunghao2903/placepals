import '../../domain/entities/create_moment_privacy_option.dart';

class CreateMomentPrivacyOptionModel {
  final String id;
  final String label;

  const CreateMomentPrivacyOptionModel({required this.id, required this.label});

  CreateMomentPrivacyOption toEntity() {
    return CreateMomentPrivacyOption(id: id, label: label);
  }
}
