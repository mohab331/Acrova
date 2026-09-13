import '../base_request_model.dart';

/// Request payload for updating the signed-in user's editable profile fields.
class UpdateProfileRequestModel extends BaseRequestModel {
  const UpdateProfileRequestModel({
    required this.name,
    required this.email,
    required this.mobileNumber,
    this.avatarPath,
  });

  final String name;
  final String email;
  final String mobileNumber;

  /// Local file path of a newly-picked avatar (null = keep existing).
  final String? avatarPath;

  @override
  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'mobile_number': mobileNumber,
    if (avatarPath != null && avatarPath!.isNotEmpty) 'avatar_path': avatarPath,
  };

  @override
  List<Object?> get props => [name, email, mobileNumber, avatarPath];

  @override
  String toString() {
    return 'UpdateProfileRequestModel('
        'name: $name, '
        'email: $email, '
        'mobileNumber: $mobileNumber, '
        'avatarPath: $avatarPath'
        ')';
  }
}
