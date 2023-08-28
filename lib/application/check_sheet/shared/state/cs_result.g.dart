// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cs_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CSResult _$$_CSResultFromJson(Map<String, dynamic> json) => _$_CSResult(
      idKrChk: json['id_kr_chk'] as int,
      idSPK: json['id_spk'] as int,
      nopol: json['nopol'] as String?,
      gate: json['gate'] as String?,
      driver1: json['driver1'] as String?,
      driver2: json['driver2'] as String?,
      jamload: json['jamload'] as String?,
      status: json['status'] as String?,
      tipe: json['tipe'] as String?,
      ket: json['ket'] as String?,
      updatedAt: json['u_date'] as String?,
      updatedBy: json['u_user'] as String?,
    );

Map<String, dynamic> _$$_CSResultToJson(_$_CSResult instance) =>
    <String, dynamic>{
      'id_kr_chk': instance.idKrChk,
      'id_spk': instance.idSPK,
      'nopol': instance.nopol,
      'gate': instance.gate,
      'driver1': instance.driver1,
      'driver2': instance.driver2,
      'jamload': instance.jamload,
      'status': instance.status,
      'tipe': instance.tipe,
      'ket': instance.ket,
      'u_date': instance.updatedAt,
      'u_user': instance.updatedBy,
    };
