import 'package:equatable/equatable.dart';

class DashboardResponseModel extends Equatable {
  const DashboardResponseModel({
    this.userName,
    this.notificationCount,
  });

  final String? userName;
  final int? notificationCount;

  factory DashboardResponseModel.fromJson(Map<String, dynamic> json) {
    return DashboardResponseModel(
      userName: json['userName']?.toString(),
      notificationCount: _parseInt(json['notificationCount']),
    );
  }

  Map<String, dynamic> toJson() => {
    'userName': userName,
    'notificationCount': notificationCount,
  };

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString());
  }

  @override
  List<Object?> get props => [userName, notificationCount];

  @override
  String toString() {
    return 'DashboardResponseModel('
        'userName: $userName, '
        'notificationCount: $notificationCount'
        ')';
  }
}
