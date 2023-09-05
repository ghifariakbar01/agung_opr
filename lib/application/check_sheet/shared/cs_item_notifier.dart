
import 'package:agung_opr/domain/remote_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../infrastructure/cs/cs_items_repository.dart';
import 'state/cs_item.dart';
import 'state/cs_item_state.dart';

class CheckSheetItemNotifier extends StateNotifier<CSItemState> {
  CheckSheetItemNotifier(this._repository) : super(CSItemState.initial());

  final CSItemsRepository _repository;

  List<CSItem> getCSItemById(int id) =>
      state.csItemList.where((element) => element.idList == id).toList();

  Future<void> getCSItems() async {
    final Either<RemoteFailure, List<CSItem>> FOS;

    state = state.copyWith(isProcessing: true, FOSOCSItem: none());

    FOS = await _repository.getCSItems();

    state = state.copyWith(isProcessing: false, FOSOCSItem: optionOf(FOS));
  }

  Future<void> getCSItemsOFFLINE() async {
    final Either<RemoteFailure, List<CSItem>> FOS;

    state = state.copyWith(isProcessing: true, FOSOCSItem: none());

    FOS = await _repository.getCSItemsOFFLINE();

    state = state.copyWith(isProcessing: false, FOSOCSItem: optionOf(FOS));
  }

  void changeCSItemsByIDList(Map<int, List<CSItem>> CSItemsList) {
    state = state.copyWith(csItemListByID: CSItemsList);
  }

  void changeCSItemsList(List<CSItem> CSItemsList) {
    state = state.copyWith(csItemList: [...CSItemsList]);
  }

  void changeId(int id) {
    state = state.copyWith(selectedId: id);
  }

  int getIndex({required int index, required int indexPrev}) {
    final csIdMap = state.csItemListByID;

    if (indexPrev == 0) return index;

    int prevIndexLength = 0;

    for (int i = 0; i < indexPrev; i++) {
      prevIndexLength =
          prevIndexLength + csIdMap.entries.elementAt(i).value.length;
    }

    final finalIndex = prevIndexLength + index;

    return finalIndex - 1;
  }

  List<int> getCSId(int id) {
    switch (id) {
      case 1:
        // LOADING & FINAL INSPECTION
        return [1, 2];
      case 2:
        // LOADING, FINAL INSPECTION & UNLOADING
        return [1, 2, 3];
      case 3:
        // UNLOADING & LANGSIR SELF DRIVE
        return [3, 4];
      default:
        [];
    }
    return [];
  }
}
