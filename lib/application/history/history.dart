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

  static List<HistoryCheckSheet> historyCheckSheetDummy = [
    HistoryCheckSheet(
      idKrChk: 1,
      idSpk: 101,
      nopol: 'B1234CD',
      driver1: 'John Doe',
      driver2: 'Jane Smith',
      jamload: '08:00',
      gate: 'A1',
      status: 'OK',
      tipe: 'loading',
      ket: 'No issues',
      program: 1,
      cDate: '2024-06-01 08:00:00',
      cUser: 'admin',
      uDate: '2024-06-01 08:30:00',
      uUser: 'admin',
      tglBerangkat: '2024-06-01',
    ),
    HistoryCheckSheet(
      idKrChk: 2,
      idSpk: 102,
      nopol: 'B5678EF',
      driver1: 'Alice Brown',
      driver2: 'Bob White',
      jamload: '09:00',
      gate: 'B2',
      status: 'OK',
      tipe: 'loading',
      ket: 'Minor delay',
      program: 2,
      cDate: '2024-06-02 09:00:00',
      cUser: 'admin',
      uDate: '2024-06-02 09:30:00',
      uUser: 'admin',
      tglBerangkat: '2024-06-02',
    ),
    HistoryCheckSheet(
      idKrChk: 3,
      idSpk: 103,
      nopol: 'B9101GH',
      driver1: 'Charlie Green',
      driver2: 'Daisy Blue',
      jamload: '10:00',
      gate: 'C3',
      status: 'Pending',
      tipe: 'loading',
      ket: 'Awaiting approval',
      program: 3,
      cDate: '2024-06-03 10:00:00',
      cUser: 'admin',
      uDate: '2024-06-03 10:30:00',
      uUser: 'admin',
      tglBerangkat: '2024-06-03',
    ),
    HistoryCheckSheet(
      idKrChk: 4,
      idSpk: 104,
      nopol: 'B1122IJ',
      driver1: 'Evan Black',
      driver2: 'Fiona White',
      jamload: '11:00',
      gate: 'D4',
      status: 'OK',
      tipe: 'loading',
      ket: 'No issues',
      program: 4,
      cDate: '2024-06-04 11:00:00',
      cUser: 'admin',
      uDate: '2024-06-04 11:30:00',
      uUser: 'admin',
      tglBerangkat: '2024-06-04',
    ),
    HistoryCheckSheet(
      idKrChk: 5,
      idSpk: 105,
      nopol: 'B3344KL',
      driver1: 'George Gray',
      driver2: 'Hannah Red',
      jamload: '12:00',
      gate: 'E5',
      status: 'OK',
      tipe: 'loading',
      ket: 'Minor issues',
      program: 5,
      cDate: '2024-06-05 12:00:00',
      cUser: 'admin',
      uDate: '2024-06-05 12:30:00',
      uUser: 'admin',
      tglBerangkat: '2024-06-05',
    ),
    HistoryCheckSheet(
      idKrChk: 6,
      idSpk: 106,
      nopol: 'B5566MN',
      driver1: 'Ivy Orange',
      driver2: 'Jack Yellow',
      jamload: '13:00',
      gate: 'F6',
      status: 'OK',
      tipe: 'loading',
      ket: 'Delayed',
      program: 6,
      cDate: '2024-06-06 13:00:00',
      cUser: 'admin',
      uDate: '2024-06-06 13:30:00',
      uUser: 'admin',
      tglBerangkat: '2024-06-06',
    ),
    HistoryCheckSheet(
      idKrChk: 7,
      idSpk: 107,
      nopol: 'B7788OP',
      driver1: 'Karen Purple',
      driver2: 'Liam Brown',
      jamload: '14:00',
      gate: 'G7',
      status: 'Pending',
      tipe: 'loading',
      ket: 'Need review',
      program: 7,
      cDate: '2024-06-07 14:00:00',
      cUser: 'admin',
      uDate: '2024-06-07 14:30:00',
      uUser: 'admin',
      tglBerangkat: '2024-06-07',
    ),
    HistoryCheckSheet(
      idKrChk: 8,
      idSpk: 108,
      nopol: 'B9900QR',
      driver1: 'Michael Green',
      driver2: 'Nina Blue',
      jamload: '15:00',
      gate: 'H8',
      status: 'OK',
      tipe: 'loading',
      ket: 'No issues',
      program: 8,
      cDate: '2024-06-08 15:00:00',
      cUser: 'admin',
      uDate: '2024-06-08 15:30:00',
      uUser: 'admin',
      tglBerangkat: '2024-06-08',
    ),
    HistoryCheckSheet(
      idKrChk: 9,
      idSpk: 109,
      nopol: 'B1123ST',
      driver1: 'Oliver White',
      driver2: 'Penny Black',
      jamload: '16:00',
      gate: 'I9',
      status: 'OK',
      tipe: 'loading',
      ket: 'Under maintenance',
      program: 9,
      cDate: '2024-06-09 16:00:00',
      cUser: 'admin',
      uDate: '2024-06-09 16:30:00',
      uUser: 'admin',
      tglBerangkat: '2024-06-09',
    ),
    HistoryCheckSheet(
      idKrChk: 10,
      idSpk: 110,
      nopol: 'B3345UV',
      driver1: 'Quincy Red',
      driver2: 'Rachel Yellow',
      jamload: '17:00',
      gate: 'J10',
      status: 'OK',
      tipe: 'loading',
      ket: 'No issues',
      program: 10,
      cDate: '2024-06-10 17:00:00',
      cUser: 'admin',
      uDate: '2024-06-10 17:30:00',
      uUser: 'admin',
      tglBerangkat: '2024-06-10',
    ),
  ];
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
