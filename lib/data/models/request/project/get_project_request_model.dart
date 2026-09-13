import '../base_request_model.dart';

class GetProjectRequestModel extends BaseRequestModel {
  const GetProjectRequestModel({
    required this.id,
  });

  final String id;

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
  };

  @override
  List<Object?> get props => [id];

  @override
  String toString() {
    return 'GetProjectRequestModel(id: $id)';
  }
}
