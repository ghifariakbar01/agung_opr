// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'csu_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CSUResult _$$_CSUResultFromJson(Map<String, dynamic> json) => _$_CSUResult(
      id: json['id'] as int,
      defectAmount: json['defectAmount'] as int?,
      gate: json['gate'] as String?,
      frame: json['frame'] as String?,
      inOut: json['inOut'] as bool?,
      isDefect: json['isDefect'] as int?,
      updatedAt: json['updatedAt'] as String?,
      updatedBy: json['updatedBy'] as String?,
    );

Map<String, dynamic> _$$_CSUResultToJson(_$_CSUResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'defectAmount': instance.defectAmount,
      'gate': instance.gate,
      'frame': instance.frame,
      'inOut': instance.inOut,
      'isDefect': instance.isDefect,
      'updatedAt': instance.updatedAt,
      'updatedBy': instance.updatedBy,
    };
