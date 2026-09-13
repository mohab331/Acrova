import 'package:equatable/equatable.dart';

class CommonResponseModel extends Equatable {
  final int? id;
  final String? title;

  const CommonResponseModel({required this.id, required this.title});

  factory CommonResponseModel.fromJson(Map<String, dynamic> json) {
    return CommonResponseModel(id: json['id'], title: json['title']);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
  };

  @override
  List<Object?> get props => [id, title];

  @override
  String toString() {
    return 'CommonResponseModel(id: $id, title: $title)';
  }
}
