import 'package:freezed_annotation/freezed_annotation.dart';

part 'history.freezed.dart';
part 'history.g.dart';

@freezed
class History with _$History {
  factory History({
    @JsonKey(name: 'id_kr_chk') required int idKrChk,
    @JsonKey(name: 'id_spk') required int idSpk,
    required String nopol,
    @JsonKey(name: 'driver1') required String driver1,
    @JsonKey(name: 'driver2') required String driver2,
    @JsonKey(name: 'tgl_berangkat') required String tglBerangkat,
    @JsonKey(name: 'jamload') required String jamload,
    required String gate,
    required String status,
    @JsonKey(name: 'c_date') required String cDate,
    @JsonKey(name: 'c_user') required String cUser,
    @JsonKey(name: 'u_date') required String uDate,
    @JsonKey(name: 'u_user') required String uUser,
    required String tipe,
    required String ket,
    required int program,
  }) = _History;

  factory History.fromJson(Map<String, dynamic> json) =>
      _$HistoryFromJson(json);
}
