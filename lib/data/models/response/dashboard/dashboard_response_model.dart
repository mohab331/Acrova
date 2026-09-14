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
      notificationCount: int.tryParse(json['notificationCount'].toString()),
    );
  }

  Map<String, dynamic> toJson() => {
    'userName': userName,
    'notificationCount': notificationCount,
  };

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
