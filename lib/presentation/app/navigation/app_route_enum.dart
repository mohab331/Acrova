enum AppRouteEnum {
  splashPage(name: 'splash_page', path: '/splash_page'),
  welcomePage(name: 'welcome_page', path: '/welcome_page'),
  phonePage(name: 'phone_page', path: '/phone_page'),
  identityVerificationPage(
    name: 'identity_verification_page',
    path: '/identity_verification_page',
  ),
  profileSetupPage(name: 'profile_setup_page', path: '/profile_setup_page'),
  authPage(name: 'auth_page', path: '/auth_page'),

  // ── Shell (bottom nav) ───────────────────────────────────────────────────────
  homePage(name: 'home_page', path: '/home'),
  projectsPage(name: 'projects_page', path: '/projects'),
  portfolioPage(name: 'portfolio_page', path: '/portfolio'),
  messagesPage(name: 'messages_page', path: '/messages'),
  profilePage(name: 'profile_page', path: '/profile'),

  // ── Project creation wizard (full-screen, no shell) ──────────────────────────
  projectCreationPage(
    name: 'project_creation_page',
    path: '/project-creation',
  ),

  // ── Portfolio detail (full-screen, above shell) ───────────────────────────────
  portfolioDetailPage(
    name: 'portfolio_detail_page',
    path: '/portfolio-detail',
  );

  const AppRouteEnum({required this.path, required this.name});

  final String path;
  final String name;
}
