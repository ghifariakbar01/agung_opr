import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_csu_ng_state.freezed.dart';

@freezed
class UpdateCSUNGState with _$UpdateCSUNGState {
  const factory UpdateCSUNGState({
    required String ket,
    required int idItem,
    required int idJenis,
    required int idPosisi,
  }) = _UpdateCSUNGState;

  factory UpdateCSUNGState.initial() => UpdateCSUNGState(
        ket: '',
        idItem: 0,
        idJenis: 0,
        idPosisi: 0,
      );
}
