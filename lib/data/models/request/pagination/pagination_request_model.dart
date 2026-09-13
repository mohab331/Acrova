import '../base_request_model.dart';

class PaginationRequestModel extends BaseRequestModel {
  final FilterParams? filterParams;
  final Paging? paging;

  const PaginationRequestModel({
    required this.filterParams,
    required this.paging,
  });

  @override
  Map<String, dynamic> toJson() => {
    'filterParams': filterParams?.toJson(),
    'paging': paging?.toJson(),
  };

  @override
  List<Object?> get props => [filterParams, paging];

  @override
  String toString() {
    return 'PaginationRequestModel('
        'filterParams: $filterParams, '
        'paging: $paging'
        ')';
  }
}

class FilterParams extends BaseRequestModel {
  final int? driverID;
  final int? filter;

  const FilterParams({required this.driverID, required this.filter});

  @override
  Map<String, dynamic> toJson() => {'driverID': driverID, 'filter': filter};

  @override
  List<Object?> get props => [driverID, filter];

  @override
  String toString() {
    return 'FilterParams(driverID: $driverID, filter: $filter)';
  }
}

class Paging extends BaseRequestModel {
  final int? pageNumber;
  final int? pageSize;

  const Paging({required this.pageNumber, required this.pageSize});

  @override
  Map<String, dynamic> toJson() => {
    'pageNumber': pageNumber,
    'pageSize': pageSize,
  };

  @override
  List<Object?> get props => [pageNumber, pageSize];

  @override
  String toString() {
    return 'Paging(pageNumber: $pageNumber, pageSize: $pageSize)';
  }
}
