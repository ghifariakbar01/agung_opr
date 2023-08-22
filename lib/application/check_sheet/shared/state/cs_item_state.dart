//  "id": 1,
//  "idList": 1,
//  "description": "Posisi Tangga Lurus Dengan Jalur Rak Car Carrier.",
//  "wewenang": "MAINT"

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'cs_item_state.freezed.dart';

part 'cs_item_state.g.dart';

@freezed
class CSItemState with _$CSItemState {
  const factory CSItemState(
      {required int id,
      required int idList,
      required String description,
      required String wewenang}) = _CSItemState;

  factory CSItemState.initial() =>
      CSItemState(id: 0, idList: 0, description: '', wewenang: '');

  factory CSItemState.fromJson(Map<String, Object?> json) =>
      _$CSItemStateFromJson(json);

  static List<CSItemState> CSItemListFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((e) => CSItemState.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static String CSItemListToJson(List<CSItemState> resultList) {
    List<Map<String, dynamic>> jsonList =
        resultList.map((e) => e.toJson()).toList();
    return jsonEncode(jsonList);
  }
}
