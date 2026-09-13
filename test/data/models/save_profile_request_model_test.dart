import 'package:acrova/data/models/request/auth/save_profile_request_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SaveProfileRequestModel Tests', () {
    test('toJson serializes mandatory and optional fields correctly', () {
      const model = SaveProfileRequestModel(
        name: 'Mohab Osama',
        email: 'mohab@acrova.sa',
        nationalId: '1000000000',
        language: 'ar',
        mobileNumber: '+966500000000',
        avatarPath: '/path/to/avatar.jpg',
      );

      final json = model.toJson();

      expect(json['name'], 'Mohab Osama');
      expect(json['email'], 'mohab@acrova.sa');
      expect(json['national_id'], '1000000000');
      expect(json['language'], 'ar');
      expect(json['mobile_number'], '+966500000000');
      expect(json['avatar_path'], '/path/to/avatar.jpg');
    });

    test('toJson omits null/empty optional fields', () {
      const model = SaveProfileRequestModel(
        name: 'Mohab Osama',
        email: 'mohab@acrova.sa',
        nationalId: '1000000000',
        language: 'en',
      );

      final json = model.toJson();

      expect(json['name'], 'Mohab Osama');
      expect(json['email'], 'mohab@acrova.sa');
      expect(json['national_id'], '1000000000');
      expect(json['language'], 'en');
      expect(json.containsKey('mobile_number'), isFalse);
      expect(json.containsKey('avatar_path'), isFalse);
    });

    test('equality and props contain all fields', () {
      const model1 = SaveProfileRequestModel(
        name: 'A',
        email: 'a@a.com',
        nationalId: '123',
        language: 'ar',
        mobileNumber: '9665',
        avatarPath: 'img',
      );
      const model2 = SaveProfileRequestModel(
        name: 'A',
        email: 'a@a.com',
        nationalId: '123',
        language: 'ar',
        mobileNumber: '9665',
        avatarPath: 'img',
      );
      expect(model1, equals(model2));
    });
  });
}
