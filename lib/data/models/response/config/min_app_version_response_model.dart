import 'app_config_response_model.dart';

export 'app_config_response_model.dart';

class MinAppVersionResponseModel extends AppConfigResponseModel {
  const MinAppVersionResponseModel({
    super.minAppVersion,
    super.termsAndConditionsUrl,
    super.privacyPolicyUrl,
    super.cookiePolicyUrl,
    super.aboutUsUrl,
  });

  factory MinAppVersionResponseModel.fromJson(Map<String, dynamic> json) {
    final model = AppConfigResponseModel.fromJson(json);
    return MinAppVersionResponseModel(
      minAppVersion: model.minAppVersion,
      termsAndConditionsUrl: model.termsAndConditionsUrl,
      privacyPolicyUrl: model.privacyPolicyUrl,
      cookiePolicyUrl: model.cookiePolicyUrl,
      aboutUsUrl: model.aboutUsUrl,
    );
  }
}
