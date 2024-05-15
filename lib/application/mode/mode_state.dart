import 'package:freezed_annotation/freezed_annotation.dart';

part 'mode_state.freezed.dart';

@freezed
class ModeState with _$ModeState {
  const factory ModeState.initial() = _Initial;

  const factory ModeState.checkSheetLoading() = _CheckSheetLoading;
  const factory ModeState.checkSheetUnloading() = _CheckSheetUnloading;
  const factory ModeState.checkSheetLoadingUnloading() =
      _CheckSheetLoadingUnloading;

  const factory ModeState.checkSheetUnit() = _CheckSheetUnit;
}
