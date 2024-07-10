import 'package:freezed_annotation/freezed_annotation.dart';

part 'csu_posisi.freezed.dart';
part 'csu_posisi.g.dart';

@freezed
class CSUPosisi with _$CSUPosisi {
  factory CSUPosisi({
    @JsonKey(name: 'id_posisi') required int idPosisi,
    @JsonKey(name: 'nama_posisi_eng') required String namaPosisiEng,
    @JsonKey(name: 'nama_posisi_ina') required String namaPosisiInd,
  }) = _CSUPosisi;

  factory CSUPosisi.initial() => CSUPosisi(
        idPosisi: 0,
        namaPosisiEng: '',
        namaPosisiInd: '',
      );

  factory CSUPosisi.fromJson(Map<String, dynamic> json) =>
      _$CSUPosisiFromJson(json);
}
