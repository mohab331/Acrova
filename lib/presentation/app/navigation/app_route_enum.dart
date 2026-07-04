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
  
  interiorDesignPhaseOnePage(
    name: 'interior_design_phase_one_page',
    path: '/interior-design-phase-one',
  ),
  
  // ── Project detail (full-screen, above shell) ─────────────────────────────────
  projectDetailPage(
    name: 'project_detail_page',
    path: '/project_detail',
  ),

  // ── Portfolio detail (full-screen, above shell) ───────────────────────────────
  portfolioDetailPage(
    name: 'portfolio_detail_page',
    path: '/portfolio-detail',
  ),

  // ── Edit profile (full-screen, above shell) ──────────────────────────────────
  editProfilePage(
    name: 'edit_profile_page',
    path: '/edit-profile',
  ),

  // ── Contact us (full-screen, above shell) ────────────────────────────────────
  contactUsPage(
    name: 'contact_us_page',
    path: '/contact-us',
  ),

  // ── Notifications (full-screen, above shell) ─────────────────────────────────
  notificationsPage(
    name: 'notifications_page',
    path: '/notifications',
  ),

  // ── Revisions (full-screen, above shell) ─────────────────────────────────────
  revisionHistoryPage(
    name: 'revision_history_page',
    path: '/revisions',
  ),
  revisionRequestPage(
    name: 'revision_request_page',
    path: '/revisions/request',
  ),
  revisionDetailPage(
    name: 'revision_detail_page',
    path: '/revisions/detail',
  ),
  
  // ── Walkthrough (full-screen, above shell) ──────────────────────────────────
  walkthroughPage(
    name: 'walkthrough_page',
    path: '/walkthrough',
  ),

  // ── Deliverables (full-screen, above shell) ─────────────────────────────────
  deliverablesPage(
    name: 'deliverables_page',
    path: '/deliverables',
  ),

  // ── Viewers (full-screen, above shell) ──────────────────────────────────────
  pdfViewerPage(
    name: 'pdf_viewer_page',
    path: '/pdfViewer',
  ),
  imageViewerPage(
    name: 'image_viewer_page',
    path: '/imageViewer',
  );

  const AppRouteEnum({required this.path, required this.name});

  final String path;
  final String name;
}
