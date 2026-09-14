enum UserStatus {
  /// User has not completed OTP verification (no tokens)
  unauthenticated,

  /// User is browsing without signing in.
  visitor,

  /// User has OTP tokens and a complete profile
  authenticated;

  bool get isAuthenticated => this == UserStatus.authenticated;
  bool get isUnauthenticated => this == UserStatus.unauthenticated;
  bool get isVisitor => this == UserStatus.visitor;
}
