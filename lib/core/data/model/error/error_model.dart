class ErrorModel {
  final String error;
  final List<ErrorDetail> details;

  ErrorModel({required this.error, required this.details});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      error: json['error'] ?? '',
      details: json['details'] == null
          ? []
          : List<ErrorDetail>.from(
              json['details'].map((x) => ErrorDetail.fromJson(x)),
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {'error': error, 'details': details.map((x) => x.toJson()).toList()};
  }

  @override
  String toString() => 'Error: $error, Details: $details';
}

class ErrorDetail {
  final String type;
  final String msg;
  final String path;
  final String location;

  ErrorDetail({
    required this.type,
    required this.msg,
    required this.path,
    required this.location,
  });

  factory ErrorDetail.fromJson(Map<String, dynamic> json) {
    return ErrorDetail(
      type: json['type'] ?? '',
      msg: json['msg'] ?? '',
      path: json['path'] ?? '',
      location: json['location'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'msg': msg, 'path': path, 'location': location};
  }

  @override
  String toString() =>
      'Type: $type, Msg: $msg, Path: $path, Location: $location';
}
