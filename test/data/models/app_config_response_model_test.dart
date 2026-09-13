import 'package:acrova/data/models/response/config/min_app_version_response_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppConfigResponseModel Tests', () {
    test('parses standard camelCase JSON correctly', () {
      final json = {
        'minAppVersion': 12,
        'termsAndConditionsUrl': 'https://example.com/terms.pdf',
        'privacyPolicyUrl': 'https://example.com/privacy.html',
        'cookiePolicyUrl': 'https://example.com/cookie',
        'aboutUsUrl': 'https://example.com/about',
      };

      final model = AppConfigResponseModel.fromJson(json);

      expect(model.minAppVersion, 12);
      expect(model.termsAndConditionsUrl, 'https://example.com/terms.pdf');
      expect(model.privacyPolicyUrl, 'https://example.com/privacy.html');
      expect(model.cookiePolicyUrl, 'https://example.com/cookie');
      expect(model.aboutUsUrl, 'https://example.com/about');
      expect(model.termsAndConditionsUrl?.isNotEmpty, isTrue);
      expect(model.privacyPolicyUrl?.isNotEmpty, isTrue);
    });

    test('parses snake_case and nested content JSON correctly', () {
      final json = {
        'content': {
          'min_app_version': 20,
          'terms_and_conditions_url': 'https://acrova.com/terms',
          'privacy_policy_url': 'https://acrova.com/privacy.pdf',
          'cookie_policy_url': 'https://acrova.com/cookies',
          'about_us_url': 'https://acrova.com/about',
        },
      };

      final model = AppConfigResponseModel.fromJson(json);

      expect(model.minAppVersion, 20);
      expect(model.termsAndConditionsUrl, 'https://acrova.com/terms');
      expect(model.privacyPolicyUrl, 'https://acrova.com/privacy.pdf');
      expect(model.cookiePolicyUrl, 'https://acrova.com/cookies');
      expect(model.aboutUsUrl, 'https://acrova.com/about');
      expect(model.termsAndConditionsUrl?.isNotEmpty, isTrue);
      expect(model.privacyPolicyUrl?.isNotEmpty, isTrue);
    });

    test('handles empty and null values gracefully', () {
      final json = <String, dynamic>{};
      final model = AppConfigResponseModel.fromJson(json);

      expect(model.minAppVersion, isNull);
      expect(model.termsAndConditionsUrl, isNull);
      expect(model.privacyPolicyUrl, isNull);
      expect(model.termsAndConditionsUrl?.isNotEmpty, isTrue);
      expect(model.privacyPolicyUrl?.isNotEmpty, isTrue);
    });

    test('toJson produces expected structure', () {
      const model = AppConfigResponseModel(
        minAppVersion: 1,
        termsAndConditionsUrl: 'https://test.com/terms',
        privacyPolicyUrl: 'https://test.com/privacy',
      );

      final json = model.toJson();
      expect(json['content'], 1);
      expect(json['termsAndConditionsUrl'], 'https://test.com/terms');
      expect(json['privacyPolicyUrl'], 'https://test.com/privacy');
    });
  });
}
