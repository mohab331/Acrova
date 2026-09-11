import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract final class EnvironmentConfig {
  static bool get enableMock =>
      dotenv.isInitialized && dotenv.env['USE_MOCK']?.toLowerCase() == 'true';
}

enum MockScenario { success, empty, error }

enum MockRepositoryKey {
  auth,
  billing,
  dashboard,
  deliverables,
  localization,
  notifications,
  portfolio,
  project,
  revisions,
  contactUs,
  appConfig,
}

class MockConfig {
  MockConfig._();

  static final Map<MockRepositoryKey, bool> _repoToggles = {
    for (final key in MockRepositoryKey.values)
      key: EnvironmentConfig.enableMock,
  };

  static final Map<MockRepositoryKey, MockScenario> _repoScenarios = {
    for (final key in MockRepositoryKey.values) key: MockScenario.success,
  };

  static bool useMock(MockRepositoryKey key) =>
      _repoToggles[key] ?? EnvironmentConfig.enableMock;

  static MockScenario scenario(MockRepositoryKey key) =>
      _repoScenarios[key] ?? MockScenario.success;

  static void setMockEnabled(MockRepositoryKey key, bool enabled) {
    _repoToggles[key] = enabled;
  }

  static void setScenario(MockRepositoryKey key, MockScenario scenario) {
    _repoScenarios[key] = scenario;
  }

  static void reset() {
    for (final key in MockRepositoryKey.values) {
      _repoToggles[key] = EnvironmentConfig.enableMock;
      _repoScenarios[key] = MockScenario.success;
    }
  }
}
