import 'package:acrova/data/data_source/local/services/image_picker/base_image_picker_service.dart';
import 'package:acrova/data/repository/mock/mock_repositories.dart';
import 'package:acrova/presentation/features/ui/auth/profile_setup/cubit/profile_completion_cubit.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';

class FakeImagePickerService implements BaseImagePickerService {
  @override
  Future<XFile?> pickFromGallery() async => XFile('/fake/gallery.jpg');

  @override
  Future<XFile?> pickFromCamera() async => XFile('/fake/camera.jpg');

  @override
  Future<List<XFile>> pickMultipleFromGallery() async => [];

  @override
  Future<String> convertXFileToBase64(XFile? image) async => 'base64_string';
}

void main() {
  group('ProfileCompletionCubit Tests', () {
    late MockAuthRepo authRepo;
    late FakeImagePickerService imagePicker;
    late ProfileCompletionCubit cubit;

    setUp(() {
      authRepo = MockAuthRepo(isVisitorMode: true);
      imagePicker = FakeImagePickerService();
      cubit = ProfileCompletionCubit(
        authRepo: authRepo,
        imagePicker: imagePicker,
        initialPhone: '+966512345678',
        initialLanguage: 'ar',
      );
    });

    tearDown(() => cubit.close());

    test('initial state initializes with provided phone and language', () {
      expect(cubit.state.mobileNumber, '+966512345678');
      expect(cubit.state.language, 'ar');
      expect(cubit.state.cubitStatus, CubitStatus.initial);
      expect(cubit.state.validate(), isFalse);
    });

    test('updates field values correctly', () {
      cubit.updateName('Sultan Ali');
      cubit.updateEmail('sultan@acrova.sa');
      cubit.updateMobile('+966512345678');
      cubit.updateNationalId('1012345678');
      cubit.updateLanguage('en');

      expect(cubit.state.name, 'Sultan Ali');
      expect(cubit.state.email, 'sultan@acrova.sa');
      expect(cubit.state.mobileNumber, '+966512345678');
      expect(cubit.state.nationalId, '1012345678');
      expect(cubit.state.language, 'en');
      expect(cubit.state.validate(), isTrue);
    });

    test('validation fails for invalid Saudi national ID', () {
      cubit.updateName('Sultan Ali');
      cubit.updateEmail('sultan@acrova.sa');
      cubit.updateMobile('+966512345678');
      cubit.updateNationalId('3012345678'); // Does not start with 1 or 2

      expect(cubit.state.validate(), isFalse);
    });

    test('validation fails for invalid email', () {
      cubit.updateName('Sultan Ali');
      cubit.updateEmail('invalid-email');
      cubit.updateMobile('+966512345678');
      cubit.updateNationalId('1012345678');

      expect(cubit.state.validate(), isFalse);
    });

    test('pickAvatarFromGallery and removeAvatar update avatarPath', () async {
      await cubit.pickAvatarFromGallery();
      expect(cubit.state.avatarPath, '/fake/gallery.jpg');

      cubit.removeAvatar();
      expect(cubit.state.avatarPath, isNull);
    });

    test('submit succeeds and updates repository', () async {
      cubit.updateName('Mohab');
      cubit.updateEmail('mohab@test.com');
      cubit.updateMobile('+966512345678');
      cubit.updateNationalId('1000000000');

      await cubit.submit();

      expect(cubit.state.cubitStatus, CubitStatus.success);
      final profileResult = await authRepo.getUserProfile();
      expect(profileResult.dataOrNull, isNotNull);
      expect(profileResult.dataOrNull?.name, 'Mohab');
    });
  });
}
