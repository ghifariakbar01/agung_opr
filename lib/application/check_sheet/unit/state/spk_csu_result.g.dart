// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spk_csu_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FrameNameCSUResult _$$_FrameNameCSUResultFromJson(
        Map<String, dynamic> json) =>
    _$_FrameNameCSUResult(
      frameName: json['frameName'] as String,
      csuResult: (json['csuResult'] as List<dynamic>)
          .map((e) => CSUResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_FrameNameCSUResultToJson(
        _$_FrameNameCSUResult instance) =>
    <String, dynamic>{
      'frameName': instance.frameName,
      'csuResult': listToJson(instance.csuResult),
    };
