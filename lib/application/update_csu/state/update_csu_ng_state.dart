import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_csu_ng_state.freezed.dart';

@freezed
class UpdateCSUNGState with _$UpdateCSUNGState {
  const factory UpdateCSUNGState(
      {required int idCs,
      required int idJenis,
      required int idPenyebab}) = _UpdateCSUNGState;

  factory UpdateCSUNGState.initial() => UpdateCSUNGState(
        idCs: 0,
        idJenis: 0,
        idPenyebab: 0,
      );
}
