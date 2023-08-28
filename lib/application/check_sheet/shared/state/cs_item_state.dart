import 'package:agung_opr/application/check_sheet/shared/state/cs_item.dart';
import 'package:agung_opr/domain/local_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/remote_failure.dart';

part 'cs_item_state.freezed.dart';

@freezed
class CSItemState with _$CSItemState {
  const factory CSItemState({
    required List<CSItem> csItemList,
    required Map<int, List<CSItem>> csItemListByID,
    required int selectedId,
    required bool isProcessing,
    required Option<Either<RemoteFailure, List<CSItem>>> FOSOCSItem,
    required Option<Either<LocalFailure, Unit>> FOSOSaveCSItem,
  }) = _CSItemState;

  factory CSItemState.initial() => CSItemState(
        csItemList: [],
        csItemListByID: {},
        selectedId: 0,
        isProcessing: false,
        FOSOCSItem: none(),
        FOSOSaveCSItem: none(),
      );
}
