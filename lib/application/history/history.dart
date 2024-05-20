import 'package:freezed_annotation/freezed_annotation.dart';

part 'history.freezed.dart';
part 'history.g.dart';

@freezed
class History with _$History {
  factory History({
    required List<HistoryCheckSheet> historyCheckSheet,
    required List<HistoryCSUOk> historyCSUOk,
    required List<HistoryCSUNg> historyCSUNg,
  }) = _History;

  factory History.initial() =>
      History(historyCheckSheet: [], historyCSUOk: [], historyCSUNg: []);

  factory History.fromJson(Map<String, dynamic> json) =>
      _$HistoryFromJson(json);
}

@freezed
class HistoryCheckSheet with _$HistoryCheckSheet {
  factory HistoryCheckSheet({
    @JsonKey(name: 'id_kr_chk') required int? idKrChk,
    @JsonKey(name: 'id_spk') required int? idSpk,
    required String? nopol,
    required String? driver1,
    required String? driver2,
    required String? jamload,
    required String? gate,
    required String? status,
    required String? tipe,
    required String? ket,
    required int? program,
    @JsonKey(name: 'c_date') required String? cDate,
    @JsonKey(name: 'c_user') required String? cUser,
    @JsonKey(name: 'u_date') required String? uDate,
    @JsonKey(name: 'u_user') required String? uUser,
    @JsonKey(name: 'tgl_berangkat') required String? tglBerangkat,
  }) = _HistoryCheckSheet;

  factory HistoryCheckSheet.fromJson(Map<String, dynamic> json) =>
      _$HistoryCheckSheetFromJson(json);
}

@freezed
class HistoryCSUOk with _$HistoryCSUOk {
  factory HistoryCSUOk({
    @JsonKey(name: 'id_cs') required int? idCs,
    @JsonKey(name: 'id_gate') required int? idGate,
    @JsonKey(name: 'id_user') required int? idUser,
    required String? frame,
    required bool? inout,
    required String? tgl,
    required String? ket,
    @JsonKey(name: 'c_date') required String? cDate,
    @JsonKey(name: 'c_user') required String? cUser,
    @JsonKey(name: 'u_date') required String? uDate,
    @JsonKey(name: 'u_user') required String? uUser,
    @JsonKey(name: 'no_defect') required int? noDefect,
    required String? supir1,
    required String? supir2,
    required String? posisi,
    @JsonKey(name: 'supir_sdr') required String? supirSdr,
    required String? remarks,
    @JsonKey(name: 'tgl_kirim_unit') required String? tglKirimUnit,
    @JsonKey(name: 'tgl_terima_unit') required String? tglTerimaUnit,
  }) = _HistoryCSUOk;

  factory HistoryCSUOk.fromJson(Map<String, dynamic> json) =>
      _$HistoryCSUOkFromJson(json);
}

@freezed
class HistoryCSUNg with _$HistoryCSUNg {
  factory HistoryCSUNg({
    @JsonKey(name: 'id_cs') required int? idCs,
    @JsonKey(name: 'id_item') required int? idItem,
    @JsonKey(name: 'id_jns_defect') required int? idJnsDefect,
    @JsonKey(name: 'id_p_defect') required int? idPDefect,
    @JsonKey(name: 'c_date') required String? cDate,
    @JsonKey(name: 'c_user') required String? cUser,
    @JsonKey(name: 'u_date') required String? uDate,
    @JsonKey(name: 'u_user') required String? uUser,
    required String? frame,
  }) = _HistoryCSUNg;

  factory HistoryCSUNg.fromJson(Map<String, dynamic> json) =>
      _$HistoryCSUNgFromJson(json);
}
