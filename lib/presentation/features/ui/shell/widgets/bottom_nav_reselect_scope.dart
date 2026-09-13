import 'package:flutter/material.dart';

/// Notifier that broadcasts bottom navigation tab reselection events.
class BottomNavReselectNotifier extends ChangeNotifier {
  int? _reselectedTabIndex;
  int _reselectCount = 0;

  int? get reselectedTabIndex => _reselectedTabIndex;
  int get reselectCount => _reselectCount;

  void notifyReselect(int tabIndex) {
    _reselectedTabIndex = tabIndex;
    _reselectCount++;
    notifyListeners();
  }
}

/// InheritedWidget providing [BottomNavReselectNotifier] to branch widgets.
class BottomNavReselectScope extends InheritedWidget {
  const BottomNavReselectScope({
    required this.notifier,
    required super.child,
    super.key,
  });

  final BottomNavReselectNotifier notifier;

  static BottomNavReselectNotifier? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<BottomNavReselectScope>()
        ?.notifier;
  }

  static BottomNavReselectNotifier of(BuildContext context) {
    final notifier = maybeOf(context);
    assert(notifier != null, 'No BottomNavReselectScope found in context');
    return notifier!;
  }

  @override
  bool updateShouldNotify(BottomNavReselectScope oldWidget) =>
      notifier != oldWidget.notifier;
}

/// State machine managing the 1st tap (scroll to top) and 2nd tap (refresh) behavior.
class TabScrollAndRefreshHandler {
  TabScrollAndRefreshHandler({
    required this.tabIndex,
    required this.scrollController,
    required this.refreshIndicatorKey,
    this.doubleTapWindow = const Duration(milliseconds: 2500),
    this.scrollThreshold = 20.0,
    this.scrollDuration = const Duration(milliseconds: 350),
    this.scrollCurve = Curves.easeOutCubic,
    this.onRefresh,
  });

  final int tabIndex;
  final ScrollController scrollController;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
  final Duration doubleTapWindow;
  final double scrollThreshold;
  final Duration scrollDuration;
  final Curve scrollCurve;
  final Future<void> Function()? onRefresh;

  DateTime? _lastScrollToTopTime;
  DateTime? _lastAtTopTapTime;
  bool _isRefreshing = false;

  bool get isRefreshing => _isRefreshing;

  void handleReselect() {
    if (_isRefreshing) return;

    final offset = scrollController.hasClients ? scrollController.offset : 0.0;
    final isScrolledDown = offset > scrollThreshold;
    final now = DateTime.now();

    // Check if user tapped a second time after initiating scroll-to-top
    if (_lastScrollToTopTime != null &&
        now.difference(_lastScrollToTopTime!) <= doubleTapWindow) {
      _lastScrollToTopTime = null;
      _lastAtTopTapTime = null;
      if (scrollController.hasClients && scrollController.offset > 0) {
        scrollController.jumpTo(0.0);
      }
      _triggerRefresh();
      return;
    }

    if (isScrolledDown) {
      // 1st press while scrolled down: smoothly scroll to top
      if (scrollController.hasClients) {
        scrollController.animateTo(
          0.0,
          duration: scrollDuration,
          curve: scrollCurve,
        );
      }
      _lastScrollToTopTime = now;
      _lastAtTopTapTime = null;
    } else {
      // Currently at or near top
      final wasTappedAtTopRecently = _lastAtTopTapTime != null &&
          now.difference(_lastAtTopTapTime!) <= doubleTapWindow;

      if (wasTappedAtTopRecently) {
        // 2nd press while at top: trigger refresh
        _lastAtTopTapTime = null;
        _lastScrollToTopTime = null;
        _triggerRefresh();
      } else {
        // 1st press while at top: ensure at offset 0 and record tap time
        if (scrollController.hasClients && offset > 0) {
          scrollController.animateTo(
            0.0,
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
          );
        }
        _lastAtTopTapTime = now;
        _lastScrollToTopTime = null;
      }
    }
  }

  void _triggerRefresh() {
    if (_isRefreshing) return;
    _isRefreshing = true;

    final state = refreshIndicatorKey.currentState;
    if (state != null) {
      state.show().whenComplete(() {
        _isRefreshing = false;
      });
    } else if (onRefresh != null) {
      onRefresh!().whenComplete(() {
        _isRefreshing = false;
      });
    } else {
      _isRefreshing = false;
    }
  }

  void dispose() {
    _lastScrollToTopTime = null;
    _lastAtTopTapTime = null;
  }
}

/// Widget that wraps a tab's scroll view to handle bottom navigation reselection.
class BottomNavScrollAndRefreshListener extends StatefulWidget {
  const BottomNavScrollAndRefreshListener({
    required this.tabIndex,
    required this.scrollController,
    required this.refreshIndicatorKey,
    required this.child,
    this.onRefresh,
    this.doubleTapWindow = const Duration(milliseconds: 2500),
    this.scrollThreshold = 20.0,
    this.scrollDuration = const Duration(milliseconds: 350),
    this.scrollCurve = Curves.easeOutCubic,
    super.key,
  });

  final int tabIndex;
  final ScrollController scrollController;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
  final Future<void> Function()? onRefresh;
  final Duration doubleTapWindow;
  final double scrollThreshold;
  final Duration scrollDuration;
  final Curve scrollCurve;
  final Widget child;

  @override
  State<BottomNavScrollAndRefreshListener> createState() =>
      _BottomNavScrollAndRefreshListenerState();
}

class _BottomNavScrollAndRefreshListenerState
    extends State<BottomNavScrollAndRefreshListener> {
  late TabScrollAndRefreshHandler _handler;
  BottomNavReselectNotifier? _reselectNotifier;
  int _lastHandledCount = 0;

  @override
  void initState() {
    super.initState();
    _initHandler();
  }

  void _initHandler() {
    _handler = TabScrollAndRefreshHandler(
      tabIndex: widget.tabIndex,
      scrollController: widget.scrollController,
      refreshIndicatorKey: widget.refreshIndicatorKey,
      onRefresh: widget.onRefresh,
      doubleTapWindow: widget.doubleTapWindow,
      scrollThreshold: widget.scrollThreshold,
      scrollDuration: widget.scrollDuration,
      scrollCurve: widget.scrollCurve,
    );
  }

  @override
  void didUpdateWidget(covariant BottomNavScrollAndRefreshListener oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.scrollController != widget.scrollController ||
        oldWidget.refreshIndicatorKey != widget.refreshIndicatorKey ||
        oldWidget.tabIndex != widget.tabIndex ||
        oldWidget.onRefresh != widget.onRefresh) {
      _handler.dispose();
      _initHandler();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final notifier = BottomNavReselectScope.maybeOf(context);
    if (_reselectNotifier != notifier) {
      _reselectNotifier?.removeListener(_onReselectChanged);
      _reselectNotifier = notifier;
      _reselectNotifier?.addListener(_onReselectChanged);
      if (notifier != null) {
        _lastHandledCount = notifier.reselectCount;
      }
    }
  }

  void _onReselectChanged() {
    final notifier = _reselectNotifier;
    if (notifier == null) return;
    if (notifier.reselectCount > _lastHandledCount &&
        notifier.reselectedTabIndex == widget.tabIndex) {
      _lastHandledCount = notifier.reselectCount;
      _handler.handleReselect();
    }
  }

  @override
  void dispose() {
    _reselectNotifier?.removeListener(_onReselectChanged);
    _handler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
