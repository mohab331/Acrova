import '../base_request_model.dart';

class PaginationRequestModel implements BaseRequestModel {
  final FilterParams? filterParams;
  final Paging? paging;

  PaginationRequestModel({required this.filterParams, required this.paging});

  @override
  Map<String, dynamic> toJson() => {
    'filterParams': filterParams?.toJson(),
    'paging': paging?.toJson(),
  };
}

class FilterParams implements BaseRequestModel {
  final int? driverID;
  final int? filter;

  FilterParams({required this.driverID, required this.filter});

  @override
  Map<String, dynamic> toJson() => {'driverID': driverID, 'filter': filter};
}

class Paging implements BaseRequestModel {
  final int? pageNumber;
  final int? pageSize;

  Paging({required this.pageNumber, required this.pageSize});

  @override
  Map<String, dynamic> toJson() => {
    'pageNumber': pageNumber,
    'pageSize': pageSize,
  };
}
