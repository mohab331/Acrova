import 'package:acrova/data/models/response/profile/user_profile_response_model.dart';
import 'package:acrova/utils/enums/user_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserStatus Enum Tests', () {
    test('enum values and helper getters work correctly', () {
      expect(UserStatus.unauthenticated.isUnauthenticated, isTrue);
      expect(UserStatus.unauthenticated.isVisitor, isFalse);
      expect(UserStatus.unauthenticated.isAuthenticated, isFalse);

      expect(UserStatus.visitor.isVisitor, isTrue);
      expect(UserStatus.visitor.isUnauthenticated, isFalse);
      expect(UserStatus.visitor.isAuthenticated, isFalse);

      expect(UserStatus.authenticated.isAuthenticated, isTrue);
      expect(UserStatus.authenticated.isVisitor, isFalse);
      expect(UserStatus.authenticated.isUnauthenticated, isFalse);
    });
  });

  group('UserProfileResponseModel.isProfileComplete Tests', () {
    test('returns true when all 4 mandatory fields are filled', () {
      const model = UserProfileResponseModel(
        name: 'Mohab Osama',
        email: 'mohab@acrova.sa',
        mobileNumber: '+966500000000',
        nationalId: '1000000000',
      );
      expect(model.isProfileComplete, isTrue);
    });

    test('returns true even if optional fields (avatarUrl, language) are omitted', () {
      const model = UserProfileResponseModel(
        name: 'Mohab Osama',
        email: 'mohab@acrova.sa',
        mobileNumber: '+966500000000',
        nationalId: '1000000000',
      );
      expect(model.avatarUrl, isNull);
      expect(model.language, isNull);
      expect(model.projectsCount, isNull);
      expect(model.isProfileComplete, isTrue);
    });

    test('returns false if name is null, empty or whitespace', () {
      const nullName = UserProfileResponseModel(
        email: 'mohab@acrova.sa',
        mobileNumber: '+966500000000',
        nationalId: '1000000000',
      );
      expect(nullName.name, isNull);
      expect(nullName.isProfileComplete, isFalse);

      const emptyName = UserProfileResponseModel(
        name: '   ',
        email: 'mohab@acrova.sa',
        mobileNumber: '+966500000000',
        nationalId: '1000000000',
      );
      expect(emptyName.isProfileComplete, isFalse);
    });

    test('returns false if email is null, empty or whitespace', () {
      const nullEmail = UserProfileResponseModel(
        name: 'Mohab',
        mobileNumber: '+966500000000',
        nationalId: '1000000000',
      );
      expect(nullEmail.email, isNull);
      expect(nullEmail.isProfileComplete, isFalse);

      const emptyEmail = UserProfileResponseModel(
        name: 'Mohab',
        email: ' ',
        mobileNumber: '+966500000000',
        nationalId: '1000000000',
      );
      expect(emptyEmail.isProfileComplete, isFalse);
    });

    test('returns false if mobileNumber is null or empty', () {
      const nullMobile = UserProfileResponseModel(
        name: 'Mohab',
        email: 'mohab@acrova.sa',
        nationalId: '1000000000',
      );
      expect(nullMobile.mobileNumber, isNull);
      expect(nullMobile.isProfileComplete, isFalse);
    });

    test('returns false if nationalId is null or empty', () {
      const nullId = UserProfileResponseModel(
        name: 'Mohab',
        email: 'mohab@acrova.sa',
        mobileNumber: '+966500000000',
      );
      expect(nullId.nationalId, isNull);
      expect(nullId.isProfileComplete, isFalse);
    });
  });
}
