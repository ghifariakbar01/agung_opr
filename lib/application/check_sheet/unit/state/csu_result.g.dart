// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'csu_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CSUResult _$$_CSUResultFromJson(Map<String, dynamic> json) => _$_CSUResult(
      inout: json['inout'] as bool?,
      id: json['id_cs'] as int,
      idGate: json['id_gate'] as int,
      defectAmount: json['defectAmount'] as int?,
      isDefect: json['no_defect'] as int?,
      gate: json['gate'] as String?,
      frame: json['frame'] as String?,
      supir1: json['supir1'] as String?,
      supir2: json['supir2'] as String?,
      posisi: json['posisi'] as String?,
      supirSDR: json['supir_sdr'] as String?,
      tglKirim: json['tgl_kirim_unit'] as String?,
      tglTerima: json['tgl_terima_unit'] as String?,
      updatedAt: json['u_date'] as String?,
      updatedBy: json['u_user'] as String?,
    );

Map<String, dynamic> _$$_CSUResultToJson(_$_CSUResult instance) =>
    <String, dynamic>{
      'inout': instance.inout,
      'id_cs': instance.id,
      'id_gate': instance.idGate,
      'defectAmount': instance.defectAmount,
      'no_defect': instance.isDefect,
      'gate': instance.gate,
      'frame': instance.frame,
      'supir1': instance.supir1,
      'supir2': instance.supir2,
      'posisi': instance.posisi,
      'supir_sdr': instance.supirSDR,
      'tgl_kirim_unit': instance.tglKirim,
      'tgl_terima_unit': instance.tglTerima,
      'u_date': instance.updatedAt,
      'u_user': instance.updatedBy,
    };
