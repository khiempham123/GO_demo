import 'package:json_annotation/json_annotation.dart';
import 'package:weather_demo/core/models/serializable.dart';

part 'api_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ApiResponse extends Serializable {
  @JsonKey(fromJson: intFromJson)
  final int? code;
  @JsonKey(name: "msg")
  final String? message;
  final bool? ok;
  final ApiError? error;

  String? get errorMessage => error?.msg ?? message;
  bool? get hasError => ok == false || code != 0;

  ApiResponse({this.code, this.message, this.ok, this.error});

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}

@JsonSerializable()
class ApiError extends Serializable {
  final String? reason;
  final String? msg;
  ApiError(this.reason, this.msg);

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ApiErrorToJson(this);
}

@JsonSerializable(
  genericArgumentFactories: true,
  createFactory: false,
  createToJson: false,
)
class DataResponse<T> extends ApiResponse {
  final T data;
  DataResponse(int? code, String? message, this.data)
    : super(code: code, message: message);

  factory DataResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) mapper,
  ) {
    final data = json['data'];

    T toData = mapper(data);
    return DataResponse(json['code'], json['msg'], toData);
  }

  static DataResponse<T> success<T>(T data) => DataResponse(0, "", data);
}
