import 'package:equatable/equatable.dart';

class EngineerResponseModel extends Equatable {
  const EngineerResponseModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.avatarUrl,
    this.specialization,
  });

  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? avatarUrl;
  final String? specialization;

  factory EngineerResponseModel.fromJson(Map<String, dynamic> json) {
    return EngineerResponseModel(
      id: json['id']?.toString(),
      name: json['name']?.toString(),
      email: json['email']?.toString(),
      phone: json['phone']?.toString(),
      avatarUrl: json['avatar_url']?.toString(),
      specialization: json['specialization']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatar_url': avatarUrl,
      'specialization': specialization,
    };
  }

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    phone,
    avatarUrl,
    specialization,
  ];

  @override
  String toString() {
    return 'EngineerResponseModel('
        'id: $id, '
        'name: $name, '
        'email: $email, '
        'phone: $phone, '
        'avatarUrl: $avatarUrl, '
        'specialization: $specialization'
        ')';
  }
}
