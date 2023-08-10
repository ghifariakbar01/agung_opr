import 'package:agung_opr/domain/local_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/remote_failure.dart';
import '../../check_sheet/unit/state/csu_items.dart';
import '../../check_sheet/unit/state/csu_jenis_penyebab_item.dart';
import 'update_csu_form_state.dart';

part 'update_csu_state.freezed.dart';

@freezed
class UpdateCSUState with _$UpdateCSUState {
  const factory UpdateCSUState({
    required int idUnit,
    required bool isProcessing,

    ///
    required UpdateCSUFrameStateSingle updateFrameList,
    required List<CSUItems> csuItems,
    required List<CSUJenisPenyebabItem> csuJenisItems,
    required List<CSUJenisPenyebabItem> csuPenyebabItems,

    //
    required Option<Either<LocalFailure, Unit>> FOSOUpdateCSU,
    required Option<Either<RemoteFailure, List<CSUItems>>> FOSOUpdateCSUItems,
    required Option<Either<RemoteFailure, List<CSUJenisPenyebabItem>>>
        FOSOUpdateCSUJenisItems,
    required Option<Either<RemoteFailure, List<CSUJenisPenyebabItem>>>
        FOSOUpdateCSUPenyebabItems,
  }) = _UpdateCSUState;

  factory UpdateCSUState.initial() => UpdateCSUState(
      idUnit: 0,
      isProcessing: false,
      updateFrameList: UpdateCSUFrameStateSingle.initial(),
      csuItems: [],
      csuJenisItems: [],
      csuPenyebabItems: [],
      FOSOUpdateCSU: none(),
      FOSOUpdateCSUItems: none(),
      FOSOUpdateCSUJenisItems: none(),
      FOSOUpdateCSUPenyebabItems: none());
}
