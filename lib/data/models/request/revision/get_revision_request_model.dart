import '../base_request_model.dart';

class GetRevisionRequestModel extends BaseRequestModel {
  const GetRevisionRequestModel({
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
    return 'GetRevisionRequestModel(id: $id)';
  }
}
