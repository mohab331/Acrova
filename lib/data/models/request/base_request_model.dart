import 'package:equatable/equatable.dart';

abstract class BaseRequestModel extends Equatable {
  const BaseRequestModel();

  Map<String, dynamic> toJson();

  @override
  String toString() {
    return '$runtimeType(${toJson()})';
  }
}
