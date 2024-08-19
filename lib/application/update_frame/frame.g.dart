// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frame.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Frame _$$_FrameFromJson(Map<String, dynamic> json) => _$_Frame(
      idUnit: json['id_unit'] as int,
      frame: json['frame'] as String?,
      engine: json['engine'] as String?,
      warna: json['warna'] as String?,
      sppdc: json['spb'] as String?,
      lastSpk: json['last_spk'] as String?,
      tglDibuat: json['c_date'] as String?,
      uDate: json['u_date'] as String?,
      uUser: json['u_user'] as String?,
      idKendType: json['id_kend_type'] as int?,
    );

Map<String, dynamic> _$$_FrameToJson(_$_Frame instance) => <String, dynamic>{
      'id_unit': instance.idUnit,
      'frame': instance.frame,
      'engine': instance.engine,
      'warna': instance.warna,
      'spb': instance.sppdc,
      'last_spk': instance.lastSpk,
      'c_date': instance.tglDibuat,
      'u_date': instance.uDate,
      'u_user': instance.uUser,
      'id_kend_type': instance.idKendType,
    };
