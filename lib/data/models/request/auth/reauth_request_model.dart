import 'package:equatable/equatable.dart';

import '../base_request_model.dart';

class ReAuthRequestModel extends Equatable implements BaseRequestModel {
  const ReAuthRequestModel({required this.refreshToken});
  final String refreshToken;

  @override
  List<Object?> get props => [refreshToken];

  @override
  Map<String, dynamic> toJson() {
    return {'refreshToken': refreshToken};
  }
}
