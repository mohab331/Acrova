enum AppRouteEnum {
  splashPage(name: 'splash_page', path: '/splash_page'),
  welcomePage(name: 'welcome_page', path: '/welcome_page'),
  authPage(name: 'auth_page', path: '/auth_page'),
  homePage(name: 'home_page', path: '/home_page');

  const AppRouteEnum({required this.path, required this.name});

  final String path;
  final String name;
}
