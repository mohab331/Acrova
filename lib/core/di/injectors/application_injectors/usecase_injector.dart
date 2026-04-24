import 'package:acrova/core/di/injectors/base_injector.dart';
/// [UseCaseInjector] hold all application useCases dependencies
class UseCaseInjector implements BaseInjector {
  static final useCaseInjectors = [

  ];

  /// iterate and inject all data sources
  @override
  Future<void> injectModules() async {
    for (final dataSourceInjector in useCaseInjectors) {
      dataSourceInjector.call();
    }
  }
}
