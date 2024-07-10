import 'package:agung_opr/domain/local_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/remote_failure.dart';
import '../csu_posisi/csu_posisi.dart';
import 'csu_jenis_penyebab_item.dart';

part 'csu_jenis_penyebab_state.freezed.dart';

@freezed
class CSUJenisPenyebabState with _$CSUJenisPenyebabState {
  const factory CSUJenisPenyebabState({
    required bool isProcessing,
    required List<CSUJenisPenyebabItem> csuJenisItems,
    required List<CSUPosisi> csuPosisiItems,
    required Option<Either<LocalFailure, Unit>> FOSOJenisPenyebabCSU,
    required Option<Either<RemoteFailure, List<CSUJenisPenyebabItem>>>
        FOSOUpdateCSUJenisItems,
    required Option<Either<RemoteFailure, List<CSUPosisi>>>
        FOSOUpdateCSUPosisiItems,
  }) = _CSUJenisPenyebabState;

  factory CSUJenisPenyebabState.initial() => CSUJenisPenyebabState(
      isProcessing: false,
      csuJenisItems: [],
      csuPosisiItems: [],
      FOSOJenisPenyebabCSU: none(),
      FOSOUpdateCSUJenisItems: none(),
      FOSOUpdateCSUPosisiItems: none());
}
