import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract final class EnvironmentConfig {
  static bool get enableMock =>
      dotenv.env['USE_MOCK']?.toLowerCase() == 'true';
}
