import 'package:acrova/utils/enums/language_codes.dart';
import 'package:equatable/equatable.dart';

export 'package:acrova/utils/enums/language_codes.dart';

class UserProfileResponseModel extends Equatable {
  const UserProfileResponseModel({
    this.name,
    this.email,
    this.mobileNumber,
    this.nationalId,
    this.language,
    this.memberSince,
    this.projectsCount,
    this.completedCount,
    this.avatarUrl,
  });

  final String? name;
  final String? email;
  final String? mobileNumber;
  final String? nationalId;
  final LanguageCodes? language;
  final DateTime? memberSince;
  final int? projectsCount;
  final int? completedCount;
  final String? avatarUrl;

  String? get languageCode => language?.locale.languageCode;

  /// Whether all mandatory profile fields are filled.
  bool get isProfileComplete {
    return (name?.trim().isNotEmpty ?? false) &&
        (email?.trim().isNotEmpty ?? false) &&
        (mobileNumber?.trim().isNotEmpty ?? false) &&
        (nationalId?.trim().isNotEmpty ?? false);
  }

  UserProfileResponseModel copyWith({
    String? name,
    String? email,
    String? mobileNumber,
    String? nationalId,
    LanguageCodes? language,
    DateTime? memberSince,
    int? projectsCount,
    int? completedCount,
    String? avatarUrl,
  }) => UserProfileResponseModel(
    name: name ?? this.name,
    email: email ?? this.email,
    mobileNumber: mobileNumber ?? this.mobileNumber,
    nationalId: nationalId ?? this.nationalId,
    language: language ?? this.language,
    memberSince: memberSince ?? this.memberSince,
    projectsCount: projectsCount ?? this.projectsCount,
    completedCount: completedCount ?? this.completedCount,
    avatarUrl: avatarUrl ?? this.avatarUrl,
  );

  factory UserProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      UserProfileResponseModel(
        name: json['name']?.toString(),
        email: json['email']?.toString(),
        mobileNumber: json['mobile_number']?.toString(),
        nationalId: json['national_id']?.toString(),
        language: LanguageCodes.fromId(
          _parseInt(json['language_id'] ?? json['language']),
        ),
        memberSince: json['member_since'] != null
            ? DateTime.tryParse(json['member_since'].toString())
            : null,
        projectsCount: _parseInt(json['projects_count']),
        completedCount: _parseInt(json['completed_count']),
        avatarUrl: json['avatar_url']?.toString(),
      );

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'mobile_number': mobileNumber,
    'national_id': nationalId,
    'language_id': language?.serverValue,
    'language': language?.serverValue,
    'member_since': memberSince?.toIso8601String(),
    'projects_count': projectsCount,
    'completed_count': completedCount,
    'avatar_url': avatarUrl,
  };

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString());
  }

  @override
  List<Object?> get props => [
    name,
    email,
    mobileNumber,
    nationalId,
    language,
    memberSince,
    projectsCount,
    completedCount,
    avatarUrl,
  ];

  @override
  String toString() {
    return 'UserProfileResponseModel('
        'name: $name, '
        'email: $email, '
        'mobileNumber: $mobileNumber, '
        'nationalId: $nationalId, '
        'language: $language, '
        'memberSince: $memberSince, '
        'projectsCount: $projectsCount, '
        'completedCount: $completedCount, '
        'avatarUrl: $avatarUrl'
        ')';
  }
}

///project
///language
///interior design
