// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'csu_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CSUResult _$$_CSUResultFromJson(Map<String, dynamic> json) => _$_CSUResult(
      id: json['id'] as int,
      frame: json['frame'] as String?,
      gate: json['gate'] as String?,
      inOut: json['inOut'] as bool?,
      isDefect: json['isDefect'] as int?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$$_CSUResultToJson(_$_CSUResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'frame': instance.frame,
      'gate': instance.gate,
      'inOut': instance.inOut,
      'isDefect': instance.isDefect,
      'updatedAt': instance.updatedAt,
    };
