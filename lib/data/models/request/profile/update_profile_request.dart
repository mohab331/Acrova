import 'package:equatable/equatable.dart';

/// Request payload for updating the signed-in user's editable profile fields.
class UpdateProfileRequest extends Equatable {
  const UpdateProfileRequest({
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

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'mobile_number': mobileNumber,
        if (avatarPath != null) 'avatar_path': avatarPath,
      };

  @override
  List<Object?> get props => [name, email, mobileNumber, avatarPath];
}
