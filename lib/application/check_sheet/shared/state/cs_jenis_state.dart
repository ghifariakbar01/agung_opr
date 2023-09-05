import 'package:agung_opr/application/check_sheet/shared/state/cs_jenis.dart';
import 'package:agung_opr/domain/local_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/remote_failure.dart';

part 'cs_jenis_state.freezed.dart';

@freezed
class CSJenisState with _$CSJenisState {
  const factory CSJenisState({
    required List<CSJenis> csJenisList,
    required int selectedId,
    required bool isProcessing,
    required Option<Either<RemoteFailure, List<CSJenis>>> FOSOCSJenis,
    required Option<Either<LocalFailure, Unit>> FOSOSaveCSJenis,
  }) = _CSJenisState;

  factory CSJenisState.initial() => CSJenisState(
        csJenisList: [],
        selectedId: 0,
        isProcessing: false,
        FOSOCSJenis: none(),
        FOSOSaveCSJenis: none(),
      );
}
