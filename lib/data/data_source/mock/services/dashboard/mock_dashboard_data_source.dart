import 'package:acrova/data/data_source/base/base_dashboard_data_source.dart';

class MockDashboardDataSource implements BaseDashboardDataSource {
  @override
  Future<Map<String, dynamic>> getDashboardData() async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'user': {
        'name': 'Mohab',
      },
      'projects': [
        {
          'id': 'ARC-2024-00018',
          'name': 'Al-Yasmeen Estate',
          'status': 'AWAITING PRICING',
          'progress': 33,
        }
      ],
      'explore_designs': [
        {
          'id': '1',
          'title': 'The Glass Pavilion',
          'style': 'MODERNISM',
          'imageUrl': 'mock_image_1', // Will use placeholder or local assets
        },
        {
          'id': '2',
          'title': 'Luxury Villa',
          'style': 'CLASSIC',
          'imageUrl': 'mock_image_2',
        }
      ]
    };
  }
}
