import 'package:equatable/equatable.dart';

class EngineerModel extends Equatable {
  const EngineerModel({
    required this.name,
    required this.role,
    this.avatarUrl,
  });

  final String name;
  final String role;
  final String? avatarUrl;

  factory EngineerModel.fromJson(Map<String, dynamic> json) => EngineerModel(
        name: json['name'] as String,
        role: json['role'] as String,
        avatarUrl: json['avatar_url'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'role': role,
        'avatar_url': avatarUrl,
      };

  @override
  List<Object?> get props => [name, role, avatarUrl];
}
