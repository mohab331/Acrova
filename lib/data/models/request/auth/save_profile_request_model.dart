import '../base_request_model.dart';

class SaveProfileRequestModel extends BaseRequestModel {
  const SaveProfileRequestModel({
    required this.name,
    required this.email,
    required this.nationalId,
    required this.language,
  });

  final String name;
  final String email;
  final String nationalId;
  final String language;

  @override
  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'national_id': nationalId,
    'language': language,
  };

  @override
  List<Object?> get props => [name, email, nationalId, language];

  @override
  String toString() {
    return 'SaveProfileRequestModel('
        'name: $name, '
        'email: $email, '
        'nationalId: $nationalId, '
        'language: $language'
        ')';
  }
}
