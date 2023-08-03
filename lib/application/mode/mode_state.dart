import 'package:freezed_annotation/freezed_annotation.dart';

part 'mode_state.freezed.dart';

@freezed
class ModeState with _$ModeState {
  const factory ModeState.initial() = _Initial;
  const factory ModeState.updateFrameDummy() = _UpdateFrameDummy;
  const factory ModeState.checkSheetLoading() = _CheckSheetLoading;
  const factory ModeState.checkSheetUnloading() = _CheckSheetUnloading;
  const factory ModeState.checkSheetGateMerak() = _CheckSheetGateMerak;
  const factory ModeState.assignUnitMerak() = _AssignUnitMerak;
  const factory ModeState.dataUpdateQuery() = _DataUpdateQuery;
}
