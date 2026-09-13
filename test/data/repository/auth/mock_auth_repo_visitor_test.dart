import 'package:acrova/data/models/request/auth/save_profile_request_model.dart';
import 'package:acrova/data/models/request/profile/update_profile_request_model.dart';
import 'package:acrova/data/repository/mock/mock_repositories.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MockAuthRepo Visitor Transition Tests', () {
    test('starts in visitor mode when initialized with isVisitorMode: true', () async {
      final repo = MockAuthRepo(isVisitorMode: true);

      final result = await repo.getUserProfile();
      result.when(
        success: (profile) => expect(profile, isNull),
        failure: (error) => fail('Should succeed with null profile'),
      );
    });

    test('saveProfile transitions visitor to authenticated user', () async {
      final repo = MockAuthRepo(isVisitorMode: true);

      // Verify initial visitor mode
      final beforeResult = await repo.getUserProfile();
      expect(beforeResult.dataOrNull, isNull);

      // Save profile
      final saveResult = await repo.saveProfile(
        const SaveProfileRequestModel(
          name: 'Ahmed Ali',
          email: 'ahmed@acrova.sa',
          nationalId: '1023456789',
          language: 'ar',
          mobileNumber: '+966512345678',
        ),
      );
      expect(saveResult.isSuccess, isTrue);

      // Now getUserProfile returns the completed profile
      final afterResult = await repo.getUserProfile();
      expect(afterResult.isSuccess, isTrue);
      final profile = afterResult.dataOrNull;
      expect(profile, isNotNull);
      expect(profile!.name, 'Ahmed Ali');
      expect(profile.email, 'ahmed@acrova.sa');
      expect(profile.nationalId, '1023456789');
      expect(profile.isProfileComplete, isTrue);
    });

    test('updateUserProfile also transitions visitor mode to authenticated', () async {
      final repo = MockAuthRepo(isVisitorMode: true);

      await repo.updateUserProfile(
        const UpdateProfileRequestModel(
          name: 'Updated Name',
          email: 'updated@acrova.sa',
          mobileNumber: '+966599999999',
        ),
      );

      final result = await repo.getUserProfile();
      expect(result.dataOrNull, isNotNull);
      expect(result.dataOrNull?.name, 'Updated Name');
    });

    test('clearUserData resets profile back to visitor mode', () async {
      final repo = MockAuthRepo();
      expect(
        repo.getUserProfile().then((r) => r.dataOrNull),
        completion(isNotNull),
      );

      await repo.clearUserData();

      final result = await repo.getUserProfile();
      expect(result.dataOrNull, isNull);
    });
  });
}
