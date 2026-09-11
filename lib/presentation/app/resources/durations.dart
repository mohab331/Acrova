part of 'resources.dart';

/// Animation / transition duration tokens.
/// All durations are const — use in AnimatedContainer, AnimatedSwitcher, Timer, etc.
abstract final class AppDurations {
  /// Micro-interaction — toggle, chip selection, icon swap (180ms)
  static const Duration fast = Duration(milliseconds: 180);

  /// Standard transition — container resize, nav-item colour, card press (200ms)
  static const Duration normal = Duration(milliseconds: 200);

  /// Skeleton shimmer full sweep cycle (1400ms)
  static const Duration shimmer = Duration(milliseconds: 1400);

  /// Pulsing dot / heartbeat animation (1000ms)
  static const Duration pulse = Duration(milliseconds: 1000);

  /// OTP countdown timer total (5 minutes)
  static const Duration otpCountdown = Duration(minutes: 5);
}
