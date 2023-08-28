import 'package:agung_opr/domain/value_objects_copy.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_cs_ng_state.freezed.dart';

enum OKorNG { Unknown, OK, NG }

enum Tipe { Unknown, loading, unload, loadunload }

@freezed
class UpdateCSNGState with _$UpdateCSNGState {
  const factory UpdateCSNGState(
      {required int id,
      required OKorNG status,
      required Keterangan keterangan}) = _UpdateCSNGState;

  factory UpdateCSNGState.initial() => UpdateCSNGState(
        id: 0,
        status: OKorNG.OK,
        keterangan: Keterangan(''),
      );
}
