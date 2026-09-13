import '../base_request_model.dart';

class SaveProfileRequestModel extends BaseRequestModel {
  const SaveProfileRequestModel({
    required this.name,
    required this.email,
    required this.nationalId,
    required this.language,
    this.mobileNumber,
    this.avatarPath,
  });

  final String name;
  final String email;
  final String nationalId;
  final String language;
  final String? mobileNumber;
  final String? avatarPath;

  @override
  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'national_id': nationalId,
    'language': language,
    if (mobileNumber != null && mobileNumber!.isNotEmpty)
      'mobile_number': mobileNumber,
    if (avatarPath != null && avatarPath!.isNotEmpty)
      'avatar_path': avatarPath,
  };

  @override
  List<Object?> get props => [
    name,
    email,
    nationalId,
    language,
    mobileNumber,
    avatarPath,
  ];

  @override
  String toString() {
    return 'SaveProfileRequestModel('
        'name: $name, '
        'email: $email, '
        'nationalId: $nationalId, '
        'language: $language, '
        'mobileNumber: $mobileNumber, '
        'avatarPath: $avatarPath'
        ')';
  }
}
