// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_History _$$_HistoryFromJson(Map<String, dynamic> json) => _$_History(
      idKrChk: json['id_kr_chk'] as int,
      idSpk: json['id_spk'] as int,
      nopol: json['nopol'] as String,
      driver1: json['driver1'] as String,
      driver2: json['driver2'] as String,
      tglBerangkat: json['tgl_berangkat'] as String,
      jamload: json['jamload'] as String,
      gate: json['gate'] as String,
      status: json['status'] as String,
      cDate: json['c_date'] as String,
      cUser: json['c_user'] as String,
      uDate: json['u_date'] as String,
      uUser: json['u_user'] as String,
      tipe: json['tipe'] as String,
      ket: json['ket'] as String,
      program: json['program'] as int,
    );

Map<String, dynamic> _$$_HistoryToJson(_$_History instance) =>
    <String, dynamic>{
      'id_kr_chk': instance.idKrChk,
      'id_spk': instance.idSpk,
      'nopol': instance.nopol,
      'driver1': instance.driver1,
      'driver2': instance.driver2,
      'tgl_berangkat': instance.tglBerangkat,
      'jamload': instance.jamload,
      'gate': instance.gate,
      'status': instance.status,
      'c_date': instance.cDate,
      'c_user': instance.cUser,
      'u_date': instance.uDate,
      'u_user': instance.uUser,
      'tipe': instance.tipe,
      'ket': instance.ket,
      'program': instance.program,
    };
