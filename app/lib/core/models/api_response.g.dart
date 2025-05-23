// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) => ApiResponse(
  code: intFromJson(json['code']),
  message: json['msg'] as String?,
  ok: json['ok'] as bool?,
  error:
      json['error'] == null
          ? null
          : ApiError.fromJson(json['error'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ApiResponseToJson(ApiResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.message,
      'ok': instance.ok,
      'error': instance.error,
    };

ApiError _$ApiErrorFromJson(Map<String, dynamic> json) =>
    ApiError(json['reason'] as String?, json['msg'] as String?);

Map<String, dynamic> _$ApiErrorToJson(ApiError instance) => <String, dynamic>{
  'reason': instance.reason,
  'msg': instance.msg,
};
