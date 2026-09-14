import 'dart:async';

import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/presentation/app/navigation/args/navigation_args.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_cubit.dart';
import 'package:acrova/presentation/features/ui/auth/identity_verification/identity_verification_page.dart';
import 'package:acrova/presentation/features/ui/auth/phone_input/phone_input_page.dart';
import 'package:acrova/presentation/features/ui/auth/welcome/welcome_page.dart';
import 'package:acrova/presentation/features/ui/billing/make_payment/make_payment_view.dart';
import 'package:acrova/presentation/features/ui/billing/make_payment/payment_success_view.dart';
import 'package:acrova/presentation/features/ui/billing/payment_details/payment_details_view.dart';
import 'package:acrova/presentation/features/ui/billing/payment_history/payment_history_view.dart';
import 'package:acrova/presentation/features/ui/common/viewers/image_viewer_page.dart';
import 'package:acrova/presentation/features/ui/common/viewers/pdf_viewer_page.dart';
import 'package:acrova/presentation/features/ui/common/viewers/web_view_page.dart';
import 'package:acrova/presentation/features/ui/contact_us/contact_us_page.dart';
import 'package:acrova/presentation/features/ui/dashboard/dashboard_page.dart';
import 'package:acrova/presentation/features/ui/deliverables/deliverables_page.dart';
import 'package:acrova/presentation/features/ui/interior_design/interior_design_page.dart';
import 'package:acrova/presentation/features/ui/interior_design_detail/interior_design_detail_page.dart';
import 'package:acrova/presentation/features/ui/interior_design_list/interior_design_list_page.dart';
import 'package:acrova/presentation/features/ui/notifications/notifications_page.dart';
import 'package:acrova/presentation/features/ui/portfolio/portfolio_detail_page.dart';
import 'package:acrova/presentation/features/ui/portfolio/portfolio_page.dart';
import 'package:acrova/presentation/features/ui/profile/edit_profile/edit_profile_page.dart';
import 'package:acrova/presentation/features/ui/profile/profile_page.dart';
import 'package:acrova/presentation/features/ui/project_creation/project_creation_page.dart';
import 'package:acrova/presentation/features/ui/project_detail/project_detail_page.dart';
import 'package:acrova/presentation/features/ui/project_detail/walkthrough/walkthrough_screen.dart';
import 'package:acrova/presentation/features/ui/projects/projects_page.dart';
import 'package:acrova/presentation/features/ui/revisions/detail/revision_detail_page.dart';
import 'package:acrova/presentation/features/ui/revisions/history/revision_history_page.dart';
import 'package:acrova/presentation/features/ui/revisions/request/revision_request_page.dart';
import 'package:acrova/presentation/features/ui/shell/shell_scaffold.dart';
import 'package:acrova/presentation/features/ui/splash/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_route_enum.dart';
import 'nav_keys.dart';

// Shell branch navigator keys
final _shellHomeKey = GlobalKey<NavigatorState>(debugLabel: 'shell-home');
final _shellProjectsKey = GlobalKey<NavigatorState>(
  debugLabel: 'shell-projects',
);
final _shellPortfolioKey = GlobalKey<NavigatorState>(
  debugLabel: 'shell-portfolio',
);
final _shellProfileKey = GlobalKey<NavigatorState>(debugLabel: 'shell-profile');

class AppRouter {
  AppRouter._();

  static final _authRefresh = _GoRouterRefreshStream(
    serviceLocatorInstance<AuthCubit>().stream,
  );

  static final router = GoRouter(
    initialLocation: AppRouteEnum.splashPage.path,
    navigatorKey: rootNavigatorKey,
    errorBuilder: (context, state) => const SplashPage(),
    refreshListenable: Listenable.merge([_authRefresh]),
    routes: [
      // ── Auth & Onboarding ────────────────────────────────────────────────
      GoRoute(
        path: AppRouteEnum.splashPage.path,
        name: AppRouteEnum.splashPage.name,
        builder: (_, __) => const SplashPage(),
      ),
      GoRoute(
        path: AppRouteEnum.welcomePage.path,
        name: AppRouteEnum.welcomePage.name,
        builder: (_, __) => const WelcomePage(),
      ),
      GoRoute(
        path: AppRouteEnum.phonePage.path,
        name: AppRouteEnum.phonePage.name,
        builder: (_, state) => PhoneInputPage(
          args: state.extra as AuthFlowArgs?,
        ),
      ),
      GoRoute(
        path: AppRouteEnum.identityVerificationPage.path,
        name: AppRouteEnum.identityVerificationPage.name,
        builder: (_, state) {
          return IdentityVerificationPage(
            args: state.extra as AuthFlowArgs?,
          );
        },
      ),

      // ── Project Creation Wizard (full-screen, above shell) ───────────────
      GoRoute(
        path: AppRouteEnum.projectCreationPage.path,
        name: AppRouteEnum.projectCreationPage.name,
        builder: (_, __) => const ProjectCreationPage(),
      ),

      // ── Interior Design Phase 1 (full-screen, above shell) ────────────────
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: AppRouteEnum.interiorDesignPhaseOnePage.path,
        name: AppRouteEnum.interiorDesignPhaseOnePage.name,
        builder: (_, state) {
          final extra = state.extra as InteriorDesignArgs?;
          return InteriorDesignPage(args: extra);
        },
      ),

      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: AppRouteEnum.interiorDesignListPage.path,
        name: AppRouteEnum.interiorDesignListPage.name,
        builder: (_, __) => const InteriorDesignListPage(),
      ),

      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: AppRouteEnum.interiorDesignDetailPage.path,
        name: AppRouteEnum.interiorDesignDetailPage.name,
        builder: (_, state) {
          final extra = state.extra as InteriorDesignDetailArgs?;
          return InteriorDesignDetailPage(args: extra);
        },
      ),

      // ── Project Detail (full-screen, above shell) ─────────────────────────
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: AppRouteEnum.projectDetailPage.path,
        name: AppRouteEnum.projectDetailPage.name,
        builder: (_, state) {
          final extra = state.extra as ProjectDetailArgs?;
          return ProjectDetailPage(args: extra);
        },
      ),

      // ── Portfolio Detail (full-screen, above shell) ───────────────────────
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: AppRouteEnum.portfolioDetailPage.path,
        name: AppRouteEnum.portfolioDetailPage.name,
        builder: (_, state) {
          final extra = state.extra as PortfolioDetailArgs?;
          return PortfolioDetailPage(args: extra);
        },
      ),

      // ── Edit Profile (full-screen, above shell) ──────────────────────────
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: AppRouteEnum.editProfilePage.path,
        name: AppRouteEnum.editProfilePage.name,
        builder: (_, state) {
          final extra = state.extra as EditProfileArgs?;
          return EditProfilePage(args: extra);
        },
      ),

      // ── Contact Us (full-screen, above shell) ────────────────────────────
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: AppRouteEnum.contactUsPage.path,
        name: AppRouteEnum.contactUsPage.name,
        builder: (context, state) {
          final extra = state.extra as ContactUsArgs?;
          return ContactUsPage(args: extra);
        },
      ),

      // ── Notifications (full-screen, above shell) ─────────────────────────
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: AppRouteEnum.notificationsPage.path,
        name: AppRouteEnum.notificationsPage.name,
        builder: (_, __) => const NotificationsPage(),
      ),

      // ── Revisions (full-screen, above shell) ─────────────────────────────
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: AppRouteEnum.revisionHistoryPage.path,
        name: AppRouteEnum.revisionHistoryPage.name,
        builder: (_, __) => const RevisionHistoryPage(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: AppRouteEnum.revisionRequestPage.path,
        name: AppRouteEnum.revisionRequestPage.name,
        builder: (_, __) => const RevisionRequestPage(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: AppRouteEnum.revisionDetailPage.path,
        name: AppRouteEnum.revisionDetailPage.name,
        builder: (_, state) {
          final extra = state.extra as RevisionDetailArgs?;
          return RevisionDetailPage(args: extra);
        },
      ),

      // ── Walkthrough (full-screen, above shell) ─────────────────────────────
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: AppRouteEnum.walkthroughPage.path,
        name: AppRouteEnum.walkthroughPage.name,
        builder: (_, state) {
          final extra = state.extra as WalkthroughArgs?;
          return WalkthroughScreen(args: extra);
        },
      ),

      // ── Deliverables (full-screen, above shell) ─────────────────────────────
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: AppRouteEnum.deliverablesPage.path,
        name: AppRouteEnum.deliverablesPage.name,
        builder: (_, __) => const DeliverablesPage(),
      ),

      // ── Billing (full-screen, above shell) ──────────────────────────────────
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: AppRouteEnum.paymentHistoryPage.path,
        name: AppRouteEnum.paymentHistoryPage.name,
        builder: (_, __) => const PaymentHistoryView(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: AppRouteEnum.paymentDetailsPage.path,
        name: AppRouteEnum.paymentDetailsPage.name,
        builder: (_, state) {
          final extra = state.extra as PaymentDetailsArgs?;
          return PaymentDetailsView(args: extra);
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: AppRouteEnum.makePaymentPage.path,
        name: AppRouteEnum.makePaymentPage.name,
        builder: (_, state) {
          final extra = state.extra as MakePaymentArgs?;
          return MakePaymentView(args: extra);
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: AppRouteEnum.paymentSuccessPage.path,
        name: AppRouteEnum.paymentSuccessPage.name,
        builder: (_, state) {
          final extra = state.extra as PaymentSuccessArgs?;
          return PaymentSuccessView(args: extra);
        },
      ),

      // ── Viewers (full-screen, above shell) ─────────────────────────────
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: AppRouteEnum.pdfViewerPage.path,
        name: AppRouteEnum.pdfViewerPage.name,
        builder: (_, state) {
          final extra = state.extra as PdfViewerArgs?;
          return PdfViewerPage(args: extra);
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: AppRouteEnum.imageViewerPage.path,
        name: AppRouteEnum.imageViewerPage.name,
        builder: (_, state) {
          final extra = state.extra as ImageViewerArgs?;
          return ImageViewerPage(args: extra);
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: AppRouteEnum.webViewPage.path,
        name: AppRouteEnum.webViewPage.name,
        builder: (_, state) {
          final extra = state.extra as WebViewArgs?;
          return WebViewPage(args: extra);
        },
      ),

      // ── Main Shell (bottom nav) ──────────────────────────────────────────
      StatefulShellRoute.indexedStack(
        builder: (_, __, navigationShell) =>
            ShellScaffold(navigationShell: navigationShell),
        branches: [
          // HOME tab
          StatefulShellBranch(
            navigatorKey: _shellHomeKey,
            routes: [
              GoRoute(
                path: AppRouteEnum.homePage.path,
                name: AppRouteEnum.homePage.name,
                builder: (_, __) => const DashboardPage(),
              ),
            ],
          ),
          // PROJECTS tab
          StatefulShellBranch(
            navigatorKey: _shellProjectsKey,
            routes: [
              GoRoute(
                path: AppRouteEnum.projectsPage.path,
                name: AppRouteEnum.projectsPage.name,
                builder: (_, __) => const ProjectsPage(),
              ),
            ],
          ),
          // PORTFOLIO tab
          StatefulShellBranch(
            navigatorKey: _shellPortfolioKey,
            routes: [
              GoRoute(
                path: AppRouteEnum.portfolioPage.path,
                name: AppRouteEnum.portfolioPage.name,
                builder: (_, __) => const PortfolioPage(),
              ),
            ],
          ),
          // PROFILE tab
          StatefulShellBranch(
            navigatorKey: _shellProfileKey,
            routes: [
              GoRoute(
                path: AppRouteEnum.profilePage.path,
                name: AppRouteEnum.profilePage.name,
                builder: (_, __) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

class _GoRouterRefreshStream extends ChangeNotifier {
  _GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _routesStreamer = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _routesStreamer;

  @override
  void dispose() {
    _routesStreamer.cancel();
    super.dispose();
  }
}
