// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'csu_ng_result_by_id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CSUNGResult _$$_CSUNGResultFromJson(Map<String, dynamic> json) =>
    _$_CSUNGResult(
      idCS: json['idCS'] as int,
      csuNGResult: (json['csuNGResult'] as List<dynamic>)
          .map((e) => CSUNGResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_CSUNGResultToJson(_$_CSUNGResult instance) =>
    <String, dynamic>{
      'idCS': instance.idCS,
      'csuNGResult': instance.csuNGResult,
    };
