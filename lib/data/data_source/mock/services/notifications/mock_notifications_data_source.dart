import 'package:acrova/data/data_source/base/base_notifications_data_source.dart';
import 'package:acrova/data/models/notification/app_notification_model.dart';

class MockNotificationsDataSource implements BaseNotificationsDataSource {
  final List<AppNotificationModel> _notifications = [
    AppNotificationModel(
      id: 'n1',
      title: 'Al-Olaya Tower Residence',
      body:
          'Final rendering deliverables for the facade and interior have been uploaded and are ready for your review.',
      createdAt: DateTime.now().subtract(const Duration(minutes: 2)),
      isRead: false,
      projectId: 'ARC-2024-00018',
    ),
    AppNotificationModel(
      id: 'n2',
      title: 'Jeddah Coastal Villa',
      body:
          'Milestone 2 payment has been successfully processed. The next design phase will commence shortly.',
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      isRead: false,
      projectId: 'ARC-2024-00021',
    ),
    AppNotificationModel(
      id: 'n3',
      title: 'Riyadh Diplomatic Quarter',
      body:
          'The project has officially moved from Schematic Design to Design Development. Timeline updated.',
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      isRead: true,
      projectId: 'ARC-2025-00003',
    ),
    AppNotificationModel(
      id: 'n4',
      title: 'Quote Ready — Nakheel Plaza',
      body:
          'Your personalised price quote is ready. Review the breakdown and proceed with payment.',
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      isRead: true,
      projectId: 'ARC-2025-00008',
    ),
    AppNotificationModel(
      id: 'n5',
      title: 'Quote Ready — Nakheel Plaza',
      body:
      'Your personalised price quote is ready. Review the breakdown and proceed with payment.',
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      isRead: true,
      projectId: 'ARC-2025-00008',
    ),
    AppNotificationModel(
      id: 'n6',
      title: 'Quote Ready — Nakheel Plaza',
      body:
      'Your personalised price quote is ready. Review the breakdown and proceed with payment.',
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      isRead: true,
      projectId: 'ARC-2025-00008',
    ),
    AppNotificationModel(
      id: 'n7',
      title: 'Quote Ready — Nakheel Plaza',
      body:
      'Your personalised price quote is ready. Review the breakdown and proceed with payment.',
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      isRead: true,
      projectId: 'ARC-2025-00008',
    ),
  ];

  @override
  Future<List<AppNotificationModel>> getNotifications() async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    return List.unmodifiable(_notifications);
  }

  @override
  Future<void> markAllAsRead() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    for (var i = 0; i < _notifications.length; i++) {
      _notifications[i] = _notifications[i].copyWith(isRead: true);
    }
  }
}
