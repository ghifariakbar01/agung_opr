// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_History _$$_HistoryFromJson(Map<String, dynamic> json) => _$_History(
      historyCheckSheet: (json['historyCheckSheet'] as List<dynamic>)
          .map((e) => HistoryCheckSheet.fromJson(e as Map<String, dynamic>))
          .toList(),
      historyCSUOk: (json['historyCSUOk'] as List<dynamic>)
          .map((e) => HistoryCSUOk.fromJson(e as Map<String, dynamic>))
          .toList(),
      historyCSUNg: (json['historyCSUNg'] as List<dynamic>)
          .map((e) => HistoryCSUNg.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_HistoryToJson(_$_History instance) =>
    <String, dynamic>{
      'historyCheckSheet': instance.historyCheckSheet,
      'historyCSUOk': instance.historyCSUOk,
      'historyCSUNg': instance.historyCSUNg,
    };

_$_HistoryCheckSheet _$$_HistoryCheckSheetFromJson(Map<String, dynamic> json) =>
    _$_HistoryCheckSheet(
      idKrChk: json['id_kr_chk'] as int?,
      idSpk: json['id_spk'] as int?,
      nopol: json['nopol'] as String?,
      driver1: json['driver1'] as String?,
      driver2: json['driver2'] as String?,
      jamload: json['jamload'] as String?,
      gate: json['gate'] as String?,
      status: json['status'] as String?,
      tipe: json['tipe'] as String?,
      ket: json['ket'] as String?,
      program: json['program'] as int?,
      cDate: json['c_date'] as String?,
      cUser: json['c_user'] as String?,
      uDate: json['u_date'] as String?,
      uUser: json['u_user'] as String?,
      tglBerangkat: json['tgl_berangkat'] as String?,
    );

Map<String, dynamic> _$$_HistoryCheckSheetToJson(
        _$_HistoryCheckSheet instance) =>
    <String, dynamic>{
      'id_kr_chk': instance.idKrChk,
      'id_spk': instance.idSpk,
      'nopol': instance.nopol,
      'driver1': instance.driver1,
      'driver2': instance.driver2,
      'jamload': instance.jamload,
      'gate': instance.gate,
      'status': instance.status,
      'tipe': instance.tipe,
      'ket': instance.ket,
      'program': instance.program,
      'c_date': instance.cDate,
      'c_user': instance.cUser,
      'u_date': instance.uDate,
      'u_user': instance.uUser,
      'tgl_berangkat': instance.tglBerangkat,
    };

_$_HistoryCSUOk _$$_HistoryCSUOkFromJson(Map<String, dynamic> json) =>
    _$_HistoryCSUOk(
      idCs: json['id_cs'] as int?,
      idGate: json['id_gate'] as int?,
      idUser: json['id_user'] as int?,
      frame: json['frame'] as String?,
      inout: json['inout'] as bool?,
      tgl: json['tgl'] as String?,
      ket: json['ket'] as String?,
      cDate: json['c_date'] as String?,
      cUser: json['c_user'] as String?,
      uDate: json['u_date'] as String?,
      uUser: json['u_user'] as String?,
      noDefect: json['no_defect'] as int?,
      supir1: json['supir1'] as String?,
      supir2: json['supir2'] as String?,
      posisi: json['posisi'] as String?,
      supirSdr: json['supir_sdr'] as String?,
      remarks: json['remarks'] as String?,
      tglKirimUnit: json['tgl_kirim_unit'] as String?,
      tglTerimaUnit: json['tgl_terima_unit'] as String?,
    );

Map<String, dynamic> _$$_HistoryCSUOkToJson(_$_HistoryCSUOk instance) =>
    <String, dynamic>{
      'id_cs': instance.idCs,
      'id_gate': instance.idGate,
      'id_user': instance.idUser,
      'frame': instance.frame,
      'inout': instance.inout,
      'tgl': instance.tgl,
      'ket': instance.ket,
      'c_date': instance.cDate,
      'c_user': instance.cUser,
      'u_date': instance.uDate,
      'u_user': instance.uUser,
      'no_defect': instance.noDefect,
      'supir1': instance.supir1,
      'supir2': instance.supir2,
      'posisi': instance.posisi,
      'supir_sdr': instance.supirSdr,
      'remarks': instance.remarks,
      'tgl_kirim_unit': instance.tglKirimUnit,
      'tgl_terima_unit': instance.tglTerimaUnit,
    };

_$_HistoryCSUNg _$$_HistoryCSUNgFromJson(Map<String, dynamic> json) =>
    _$_HistoryCSUNg(
      idCs: json['id_cs'] as int?,
      idItem: json['id_item'] as int?,
      idJnsDefect: json['id_jns_defect'] as int?,
      idPDefect: json['id_p_defect'] as int?,
      cDate: json['c_date'] as String?,
      cUser: json['c_user'] as String?,
      uDate: json['u_date'] as String?,
      uUser: json['u_user'] as String?,
      frame: json['frame'] as String?,
    );

Map<String, dynamic> _$$_HistoryCSUNgToJson(_$_HistoryCSUNg instance) =>
    <String, dynamic>{
      'id_cs': instance.idCs,
      'id_item': instance.idItem,
      'id_jns_defect': instance.idJnsDefect,
      'id_p_defect': instance.idPDefect,
      'c_date': instance.cDate,
      'c_user': instance.cUser,
      'u_date': instance.uDate,
      'u_user': instance.uUser,
      'frame': instance.frame,
    };
