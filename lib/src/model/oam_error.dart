import 'package:json_annotation/json_annotation.dart';
part "oam_error.g.dart";


/// AdMaxError class
/// Get error code and message from AdMax
@JsonSerializable()
class OAMError {
  final int code;
  final String message;

  OAMError({required this.code, required this.message});

  factory OAMError.fromJson(Map<String, dynamic> map) =>
      _$OAMErrorFromJson(map);

  Map<String, dynamic> toJson() => _$OAMErrorToJson(this);
}
