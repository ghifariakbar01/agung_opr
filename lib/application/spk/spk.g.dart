// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spk.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SPK _$$_SPKFromJson(Map<String, dynamic> json) => _$_SPK(
      idSpk: json['id_spk'] as int,
      spkNo: json['spk_no'] as String,
      isEdit: json['is_edit'] as bool?,
      updatedUser: json['u_user'] as String?,
      updatedDate: json['u_date'] as String?,
      supir1Nm: json['supir1_nm'] as String?,
      supir2Nm: json['supir2_nm'] as String?,
      namaTrayek: json['trayek_nama'] as String?,
      tglBerangkat: json['tgl_berangkat'] as String?,
      ket: json['ket'] as String?,
      nopol: json['nopol'] as String,
    );

Map<String, dynamic> _$$_SPKToJson(_$_SPK instance) => <String, dynamic>{
      'id_spk': instance.idSpk,
      'spk_no': instance.spkNo,
      'is_edit': instance.isEdit,
      'u_user': instance.updatedUser,
      'u_date': instance.updatedDate,
      'supir1_nm': instance.supir1Nm,
      'supir2_nm': instance.supir2Nm,
      'trayek_nama': instance.namaTrayek,
      'tgl_berangkat': instance.tglBerangkat,
      'ket': instance.ket,
      'nopol': instance.nopol,
    };
