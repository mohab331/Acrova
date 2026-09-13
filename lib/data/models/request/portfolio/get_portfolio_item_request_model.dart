import '../base_request_model.dart';

class GetPortfolioItemRequestModel extends BaseRequestModel {
  const GetPortfolioItemRequestModel({
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
    return 'GetPortfolioItemRequestModel(id: $id)';
  }
}
