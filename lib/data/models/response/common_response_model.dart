import 'package:equatable/equatable.dart';

class CommonResponseModel extends Equatable {
  final int? id;
  final String? title;

  const CommonResponseModel({required this.id, required this.title});

  factory CommonResponseModel.fromJson(Map<String, dynamic> json) {
    return CommonResponseModel(id: json['id'], title: json['title']);
  }

  @override
  List<Object?> get props => [id, title];
}
