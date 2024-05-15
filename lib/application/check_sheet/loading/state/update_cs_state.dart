import 'package:agung_opr/domain/local_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../mode/mode_state.dart';
import '../../../spk/spk.dart';
import 'update_cs_form_state.dart';

part 'update_cs_state.freezed.dart';

@freezed
class UpdateCSState with _$UpdateCSState {
  const factory UpdateCSState({
    required int idCS,
    required SPK selectedSPK,
    required String frameName,
    required bool isProcessing,
    required bool showErrorMessages,
    required ModeState modeSelected,
    required List<ModeState> modeList,
    required UpdateCSFormState updateCSForm,
    required Option<Either<LocalFailure, Unit>> FOSOUpdateCS,
  }) = _UpdateCSState;

  factory UpdateCSState.initial() => UpdateCSState(
        idCS: 0,
        selectedSPK: SPK.initial(),
        isProcessing: false,
        showErrorMessages: false,
        frameName: '',
        modeSelected: ModeState.checkSheetLoading(),
        modeList: [
          ModeState.checkSheetLoading(),
          ModeState.checkSheetUnloading(),
          ModeState.checkSheetLoadingUnloading(),
        ],
        updateCSForm: UpdateCSFormState.initial(),
        FOSOUpdateCS: none(),
      );
}
