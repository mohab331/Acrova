import 'package:equatable/equatable.dart';

class AppConfigResponseModel extends Equatable {
  const AppConfigResponseModel({
    this.minAppVersion,
    this.termsAndConditionsUrl,
    this.privacyPolicyUrl,
    this.cookiePolicyUrl,
    this.aboutUsUrl,
  });

  final int? minAppVersion;
  final String? termsAndConditionsUrl;
  final String? privacyPolicyUrl;
  final String? cookiePolicyUrl;
  final String? aboutUsUrl;

  factory AppConfigResponseModel.fromJson(Map<String, dynamic> json) {
    return AppConfigResponseModel(
      minAppVersion: int.tryParse(json['minAppVersion']?.toString() ?? ''),
      termsAndConditionsUrl: json['termsAndConditionsUrl']?.toString(),
      privacyPolicyUrl: json['privacyPolicyUrl']?.toString(),
      cookiePolicyUrl: json['cookiePolicyUrl']?.toString(),
      aboutUsUrl: json['aboutUsUrl']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'minAppVersion': minAppVersion,
    'termsAndConditionsUrl': termsAndConditionsUrl,
    'privacyPolicyUrl': privacyPolicyUrl,
    'cookiePolicyUrl': cookiePolicyUrl,
    'aboutUsUrl': aboutUsUrl,
  };

  @override
  List<Object?> get props => [
    minAppVersion,
    termsAndConditionsUrl,
    privacyPolicyUrl,
    cookiePolicyUrl,
    aboutUsUrl,
  ];

  @override
  String toString() {
    return 'AppConfigResponseModel('
        'minAppVersion: $minAppVersion, '
        'termsAndConditionsUrl: $termsAndConditionsUrl, '
        'privacyPolicyUrl: $privacyPolicyUrl, '
        'cookiePolicyUrl: $cookiePolicyUrl, '
        'aboutUsUrl: $aboutUsUrl)';
  }
}
