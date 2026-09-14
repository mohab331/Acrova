enum UserStatus {
  /// User has not completed OTP verification (no tokens)
  unauthenticated,

  /// User has OTP tokens and a complete profile
  authenticated;

  bool get isAuthenticated => this == UserStatus.authenticated;
  bool get isUnauthenticated => this == UserStatus.unauthenticated;
}
