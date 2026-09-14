import 'package:acrova/utils/enums/language_codes.dart';

import '../base_request_model.dart';

export 'package:acrova/utils/enums/language_codes.dart';

class SaveProfileRequestModel extends BaseRequestModel {
  const SaveProfileRequestModel({
    required this.name,
    required this.email,
    required this.nationalId,
    this.language,
    this.mobileNumber,
    this.avatarPath,
  });

  final String name;
  final String email;
  final String nationalId;
  final LanguageCodes? language;
  final String? mobileNumber;
  final String? avatarPath;

  @override
  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'national_id': nationalId,
    if (language != null) ...{
      'language_id': language!.id,
      'language': language!.id,
    },
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
