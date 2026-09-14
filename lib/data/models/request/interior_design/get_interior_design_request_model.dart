import '../base_request_model.dart';

class GetInteriorDesignRequestModel extends BaseRequestModel {
  const GetInteriorDesignRequestModel({
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
  String toString() => 'GetInteriorDesignRequestModel(id: $id)';
}
