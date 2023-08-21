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
      idKendType: json['id_kend_type'] as int?,
      sppdc: json['no_invoice'] as String?,
      custid: json['custid'] as int?,
    );

Map<String, dynamic> _$$_FrameToJson(_$_Frame instance) => <String, dynamic>{
      'id_unit': instance.idUnit,
      'frame': instance.frame,
      'engine': instance.engine,
      'warna': instance.warna,
      'id_kend_type': instance.idKendType,
      'no_invoice': instance.sppdc,
      'custid': instance.custid,
    };
