import 'package:acrova/presentation/features/ui/shell/widgets/bottom_nav_reselect_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BottomNavReselectNotifier tests', () {
    test('notifies listeners and increments count on reselect', () {
      final notifier = BottomNavReselectNotifier();
      var notifications = 0;
      notifier.addListener(() => notifications++);

      expect(notifier.reselectCount, 0);
      expect(notifier.reselectedTabIndex, isNull);

      notifier.notifyReselect(0);
      expect(notifications, 1);
      expect(notifier.reselectCount, 1);
      expect(notifier.reselectedTabIndex, 0);

      notifier.notifyReselect(2);
      expect(notifications, 2);
      expect(notifier.reselectCount, 2);
      expect(notifier.reselectedTabIndex, 2);
    });
  });

  group('TabScrollAndRefreshHandler logic tests', () {
    late ScrollController scrollController;
    late GlobalKey<RefreshIndicatorState> refreshKey;

    setUp(() {
      scrollController = ScrollController();
      refreshKey = GlobalKey<RefreshIndicatorState>();
    });

    tearDown(() {
      scrollController.dispose();
    });

    testWidgets('1st tap when scrolled down animates to top', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              controller: scrollController,
              child: const SizedBox(height: 2000),
            ),
          ),
        ),
      );

      // Scroll down
      scrollController.jumpTo(500.0);
      expect(scrollController.offset, 500.0);

      var refreshTriggered = false;
      final handler = TabScrollAndRefreshHandler(
        tabIndex: 0,
        scrollController: scrollController,
        refreshIndicatorKey: refreshKey,
        onRefresh: () async {
          refreshTriggered = true;
        },
      );

      // 1st tap
      handler.handleReselect();
      await tester.pumpAndSettle();

      expect(scrollController.offset, 0.0);
      expect(refreshTriggered, isFalse);
    });

    testWidgets('2nd tap within doubleTapWindow triggers refresh after scrolling up',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              controller: scrollController,
              child: const SizedBox(height: 2000),
            ),
          ),
        ),
      );

      // Scroll down
      scrollController.jumpTo(500.0);

      var refreshCount = 0;
      final handler = TabScrollAndRefreshHandler(
        tabIndex: 0,
        scrollController: scrollController,
        refreshIndicatorKey: refreshKey,
        doubleTapWindow: const Duration(seconds: 3),
        onRefresh: () async {
          refreshCount++;
        },
      );

      // 1st tap -> scroll to top
      handler.handleReselect();
      await tester.pumpAndSettle();
      expect(scrollController.offset, 0.0);
      expect(refreshCount, 0);

      // 2nd tap -> refresh
      handler.handleReselect();
      expect(refreshCount, 1);
    });

    testWidgets('Tapping twice at the top triggers refresh', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              controller: scrollController,
              child: const SizedBox(height: 1000),
            ),
          ),
        ),
      );

      expect(scrollController.offset, 0.0);

      var refreshCount = 0;
      final handler = TabScrollAndRefreshHandler(
        tabIndex: 0,
        scrollController: scrollController,
        refreshIndicatorKey: refreshKey,
        doubleTapWindow: const Duration(seconds: 3),
        onRefresh: () async {
          refreshCount++;
        },
      );

      // 1st tap at top -> records tap time, does not refresh
      handler.handleReselect();
      expect(refreshCount, 0);

      // 2nd tap at top within window -> triggers refresh
      handler.handleReselect();
      expect(refreshCount, 1);
    });

    testWidgets('Single tap at top followed by expiration does not refresh on 1st tap',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              controller: scrollController,
              child: const SizedBox(height: 1000),
            ),
          ),
        ),
      );

      var refreshCount = 0;
      final handler = TabScrollAndRefreshHandler(
        tabIndex: 0,
        scrollController: scrollController,
        refreshIndicatorKey: refreshKey,
        doubleTapWindow: const Duration(milliseconds: 50),
        onRefresh: () async {
          refreshCount++;
        },
      );

      // 1st tap
      handler.handleReselect();
      expect(refreshCount, 0);

      // Wait for window to expire
      await Future<void>.delayed(const Duration(milliseconds: 70));

      // This tap is treated as a new 1st tap, not a 2nd tap
      handler.handleReselect();
      expect(refreshCount, 0);
    });

    testWidgets('Duplicate tap while refreshing is ignored', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              controller: scrollController,
              child: const SizedBox(height: 1000),
            ),
          ),
        ),
      );

      var refreshCalls = 0;
      final handler = TabScrollAndRefreshHandler(
        tabIndex: 0,
        scrollController: scrollController,
        refreshIndicatorKey: refreshKey,
        doubleTapWindow: const Duration(seconds: 2),
        onRefresh: () async {
          refreshCalls++;
          await Future<void>.delayed(const Duration(milliseconds: 100));
        },
      );

      // Tap twice to trigger refresh
      handler.handleReselect();
      handler.handleReselect();
      expect(refreshCalls, 1);
      expect(handler.isRefreshing, isTrue);

      // 3rd tap while still refreshing should be ignored
      handler.handleReselect();
      expect(refreshCalls, 1);
    });
  });

  group('BottomNavScrollAndRefreshListener widget tests', () {
    testWidgets('Listens to BottomNavReselectScope and handles only matching tabIndex',
        (tester) async {
      final notifier = BottomNavReselectNotifier();
      final scrollController = ScrollController();
      final refreshKey = GlobalKey<RefreshIndicatorState>();
      var refreshed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: BottomNavReselectScope(
            notifier: notifier,
            child: Scaffold(
              body: BottomNavScrollAndRefreshListener(
                tabIndex: 0,
                scrollController: scrollController,
                refreshIndicatorKey: refreshKey,
                onRefresh: () async {
                  refreshed = true;
                },
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: const SizedBox(height: 2000),
                ),
              ),
            ),
          ),
        ),
      );

      // Reselect tab 1 (different tab) -> should NOT affect tab 0
      notifier.notifyReselect(1);
      await tester.pump();
      expect(refreshed, isFalse);

      // Reselect tab 0 twice -> should trigger refresh
      notifier.notifyReselect(0);
      await tester.pump();
      notifier.notifyReselect(0);
      await tester.pump();
      expect(refreshed, isTrue);

      scrollController.dispose();
    });
  });
}
