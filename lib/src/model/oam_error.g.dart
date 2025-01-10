// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oam_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OAMError _$OAMErrorFromJson(Map<String, dynamic> json) => OAMError(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$OAMErrorToJson(OAMError instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };
