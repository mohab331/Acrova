import 'package:equatable/equatable.dart';

/// Immutable read model for the signed-in customer's profile.
class UserProfileModel extends Equatable {
  const UserProfileModel({
    required this.name,
    required this.email,
    required this.mobileNumber,
    required this.nationalId,
    required this.language,
    required this.memberSince,
    required this.projectsCount,
    required this.completedCount,
    this.avatarUrl,
  });

  final String name;
  final String email;
  final String mobileNumber;
  final String nationalId;
  final String language; // 'en' | 'ar'
  final DateTime memberSince;
  final int projectsCount;
  final int completedCount;
  final String? avatarUrl;

  UserProfileModel copyWith({
    String? name,
    String? email,
    String? mobileNumber,
    String? nationalId,
    String? language,
    DateTime? memberSince,
    int? projectsCount,
    int? completedCount,
    String? avatarUrl,
  }) =>
      UserProfileModel(
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

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        name: json['name'] as String? ?? '',
        email: json['email'] as String? ?? '',
        mobileNumber: json['mobile_number'] as String? ?? '',
        nationalId: json['national_id'] as String? ?? '',
        language: json['language'] as String? ?? 'en',
        memberSince: DateTime.tryParse(json['member_since'] as String? ?? '') ??
            DateTime.now(),
        projectsCount: json['projects_count'] as int? ?? 0,
        completedCount: json['completed_count'] as int? ?? 0,
        avatarUrl: json['avatar_url'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'mobile_number': mobileNumber,
        'national_id': nationalId,
        'language': language,
        'member_since': memberSince.toIso8601String(),
        'projects_count': projectsCount,
        'completed_count': completedCount,
        'avatar_url': avatarUrl,
      };

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
}
