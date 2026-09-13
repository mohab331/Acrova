import 'package:acrova/data/models/response/profile/user_profile_response_model.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_state.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/enums/user_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthCubitState UserStatus Tests', () {
    test('initial state defaults to unauthenticated', () {
      const state = AuthCubitState.initial();
      expect(state.userStatus, UserStatus.unauthenticated);
      expect(state.isVisitor, isFalse);
      expect(state.isFullyAuthenticated, isFalse);
    });

    test('state is visitor when OTP is verified but userModel is not loaded', () {
      final state = const AuthCubitState.initial().copyWith(
        verifyOTPCubitStatus: CubitStatus.success,
      );
      expect(state.userStatus, UserStatus.visitor);
      expect(state.isVisitor, isTrue);
      expect(state.isFullyAuthenticated, isFalse);
    });

    test('state is visitor when getUser succeeds with null profile', () {
      final state = const AuthCubitState.initial().copyWith(
        getUserCubitStatus: CubitStatus.success,
        clearUserModel: true,
      );
      expect(state.userStatus, UserStatus.visitor);
      expect(state.isVisitor, isTrue);
      expect(state.isFullyAuthenticated, isFalse);
    });

    test('state is visitor when getUser succeeds with incomplete profile', () {
      final state = const AuthCubitState.initial().copyWith(
        getUserCubitStatus: CubitStatus.success,
        userModel: const UserProfileResponseModel(
          name: 'Incomplete User',
          email: '', // missing mandatory email
          mobileNumber: '+966500000000',
          nationalId: '1000000000',
        ),
      );
      expect(state.userStatus, UserStatus.visitor);
      expect(state.isVisitor, isTrue);
      expect(state.isFullyAuthenticated, isFalse);
    });

    test('state is authenticated when userModel has complete profile', () {
      final state = const AuthCubitState.initial().copyWith(
        getUserCubitStatus: CubitStatus.success,
        userModel: const UserProfileResponseModel(
          name: 'Mohab Osama',
          email: 'mohab@acrova.sa',
          mobileNumber: '+966500000000',
          nationalId: '1000000000',
        ),
      );
      expect(state.userStatus, UserStatus.authenticated);
      expect(state.isFullyAuthenticated, isTrue);
      expect(state.isVisitor, isFalse);
    });

    test('copyWith clearUserModel: true clears existing userModel', () {
      final authenticatedState = const AuthCubitState.initial().copyWith(
        userModel: const UserProfileResponseModel(
          name: 'Mohab Osama',
          email: 'mohab@acrova.sa',
          mobileNumber: '+966500000000',
          nationalId: '1000000000',
        ),
      );
      expect(authenticatedState.userModel, isNotNull);

      final clearedState = authenticatedState.copyWith(
        clearUserModel: true,
      );
      expect(clearedState.userModel, isNull);
    });
  });
}
