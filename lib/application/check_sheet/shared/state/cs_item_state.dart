//  "id": 1,
//  "idList": 1,
//  "description": "Posisi Tangga Lurus Dengan Jalur Rak Car Carrier.",
//  "wewenang": "MAINT"

import 'package:freezed_annotation/freezed_annotation.dart';

part 'cs_item_state.freezed.dart';

@freezed
class CSItemState with _$CSItemState {
  const factory CSItemState(
      {required int id,
      required int idList,
      required String description,
      required String wewenang}) = _CSItemState;

  factory CSItemState.initial() =>
      CSItemState(id: 0, idList: 0, description: '', wewenang: '');
}
