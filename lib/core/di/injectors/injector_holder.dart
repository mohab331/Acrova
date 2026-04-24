import 'package:acrova/core/di/injectors/application_injectors/cubit_injector.dart';
import 'package:acrova/core/di/injectors/application_injectors/data_source_injector.dart';
import 'package:acrova/core/di/injectors/base_injector.dart';

import 'application_injectors/repo_injector.dart';
import 'application_injectors/session_injector.dart';
import 'application_injectors/usecase_injector.dart';

/// [InjectorHolder] hold all applicationInjectors e.g [DataSourcesInjector] ,[ReposInjector] ...
/// Must be in order,

class InjectorHolder {
  static final List<BaseInjector> _applicationInjectors = [
    DataSourcesInjector(),
    ReposInjector(),
    UseCaseInjector(),
    CubitsInjector(),
    SessionInjector(),
  ];

  /// iterate and inject all application modules
  static void injectAllApplicationModules() {
    for (var injector in _applicationInjectors) {
      injector.injectModules();
    }
  }
}
