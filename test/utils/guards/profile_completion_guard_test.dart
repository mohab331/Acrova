import 'package:acrova/data/models/response/profile/user_profile_response_model.dart';
import 'package:acrova/domain/repository/auth/base_auth_repo.dart';
import 'package:acrova/domain/repository/notifications/base_fcm_token_repo.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_cubit.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_state.dart';
import 'package:acrova/utils/guards/profile_completion_guard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class _MockAuthRepoForGuard implements BaseAuthRepo {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _MockFcmTokenRepoForGuard implements BaseFCMTokenRepo {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('ProfileCompletionGuard Tests', () {
    testWidgets('isComplete returns true for authenticated user', (tester) async {
      final authCubit = AuthCubit(
        baseAuthRepo: _MockAuthRepoForGuard(),
        baseFCMTokenRepo: _MockFcmTokenRepoForGuard(),
      );

      // Emit authenticated state
      authCubit.emit(
        const AuthCubitState.initial().copyWith(
          userModel: const UserProfileResponseModel(
            name: 'Mohab',
            email: 'mohab@acrova.sa',
            mobileNumber: '+966500000000',
            nationalId: '1000000000',
          ),
        ),
      );

      late bool result;
      await tester.pumpWidget(
        BlocProvider<AuthCubit>.value(
          value: authCubit,
          child: Builder(
            builder: (context) {
              result = ProfileCompletionGuard.isComplete(context);
              return const SizedBox();
            },
          ),
        ),
      );

      expect(result, isTrue);
      await authCubit.close();
    });

    testWidgets('isComplete returns false for visitor user', (tester) async {
      final authCubit = AuthCubit(
        baseAuthRepo: _MockAuthRepoForGuard(),
        baseFCMTokenRepo: _MockFcmTokenRepoForGuard(),
      );

      late bool result;
      await tester.pumpWidget(
        BlocProvider<AuthCubit>.value(
          value: authCubit,
          child: Builder(
            builder: (context) {
              result = ProfileCompletionGuard.isComplete(context);
              return const SizedBox();
            },
          ),
        ),
      );

      expect(result, isFalse);
      await authCubit.close();
    });
  });
}
