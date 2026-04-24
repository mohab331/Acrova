import 'package:acrova/domain/repository/notifications/base_fcm_token_repo.dart';
import 'package:bloc/bloc.dart';
import '../../../../domain/repository/auth/base_auth_repo.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit({
    required BaseAuthRepo baseAuthRepo,
    required BaseFCMTokenRepo baseFCMTokenRepo,
  }) : _baseAuthRepo = baseAuthRepo,
       _fcmTokenRepo = baseFCMTokenRepo,
       super(const AuthCubitState.initial());

  final BaseAuthRepo _baseAuthRepo;
  final BaseFCMTokenRepo _fcmTokenRepo;

  Future<String> _getFCMToken() async {
    final result = await _fcmTokenRepo.getFCMToken();
    return result.when(
      success: (data) {
        return data ?? '';
      },
      failure: (error) {
        return '';
      },
    );
  }

  void _resetState() => emit(const AuthCubitState.initial());

  Future<void> clearAuthData() => _baseAuthRepo.clearUserData();
}
