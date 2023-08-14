import 'package:agung_opr/application/check_sheet/unit/state/csu_items.dart';
import 'package:agung_opr/domain/local_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/remote_failure.dart';

part 'csu_items_state.freezed.dart';

@freezed
class CSUItemsState with _$CSUItemsState {
  const factory CSUItemsState({
    required bool isProcessing,
    required List<CSUItems> csuItems,
    required Option<Either<LocalFailure, Unit>> FOSOUpdateCSU,
    required Option<Either<RemoteFailure, List<CSUItems>>> FOSOUpdateCSUItems,
  }) = _CSUItemsState;

  factory CSUItemsState.initial() => CSUItemsState(
      isProcessing: false,
      csuItems: [],
      FOSOUpdateCSU: none(),
      FOSOUpdateCSUItems: none());
}
