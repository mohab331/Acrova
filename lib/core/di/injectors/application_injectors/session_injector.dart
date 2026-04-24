import 'package:acrova/core/di/injectors/base_injector.dart';


/// [SessionInjector] hold all application Services or session specific dependencies
class SessionInjector implements BaseInjector {
  static final sessionInjectors = [

  ];

  /// iterate and inject all repos
  @override
  Future<void> injectModules() async {
    for (final sessionInjector in sessionInjectors) {
      sessionInjector.call();
    }
  }
}
