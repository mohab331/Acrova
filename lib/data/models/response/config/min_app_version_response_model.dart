import 'package:equatable/equatable.dart';

export 'app_config_response_model.dart';

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

  bool get hasTermsAndConditions =>
      termsAndConditionsUrl != null && termsAndConditionsUrl!.isNotEmpty;
  bool get hasPrivacyPolicy =>
      privacyPolicyUrl != null && privacyPolicyUrl!.isNotEmpty;

  factory AppConfigResponseModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data =
        json['content'] is Map<String, dynamic>
            ? json['content'] as Map<String, dynamic>
            : json;

    final rawMinVersion = json['minAppVersion'] ??
        json['min_app_version'] ??
        data['minAppVersion'] ??
        data['min_app_version'];

    return AppConfigResponseModel(
      minAppVersion: int.tryParse(rawMinVersion?.toString() ?? ''),
      termsAndConditionsUrl: (data['termsAndConditionsUrl'] ??
              data['terms_and_conditions_url'] ??
              json['termsAndConditionsUrl'] ??
              json['terms_and_conditions_url'])
          ?.toString(),
      privacyPolicyUrl: (data['privacyPolicyUrl'] ??
              data['privacy_policy_url'] ??
              json['privacyPolicyUrl'] ??
              json['privacy_policy_url'])
          ?.toString(),
      cookiePolicyUrl: (data['cookiePolicyUrl'] ??
              data['cookie_policy_url'] ??
              json['cookiePolicyUrl'] ??
              json['cookie_policy_url'])
          ?.toString(),
      aboutUsUrl: (data['aboutUsUrl'] ??
              data['about_us_url'] ??
              json['aboutUsUrl'] ??
              json['about_us_url'])
          ?.toString(),
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
