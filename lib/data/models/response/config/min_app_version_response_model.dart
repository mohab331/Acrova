import 'package:equatable/equatable.dart';

class MinAppVersionResponseModel extends Equatable{
  const MinAppVersionResponseModel({required this.minAppVersion});

  final int? minAppVersion;

  factory MinAppVersionResponseModel.fromJson(Map<String, dynamic> json) {
    return MinAppVersionResponseModel(
      minAppVersion: int.tryParse(json['content'].toString()),
    );
  }

  @override
  List<Object?> get props => [minAppVersion];
}
