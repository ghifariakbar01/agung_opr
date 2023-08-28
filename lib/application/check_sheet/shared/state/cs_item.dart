//  "id": 1,
//  "idList": 1,
//  "description": "Posisi Tangga Lurus Dengan Jalur Rak Car Carrier.",
//  "wewenang": "MAINT"

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'cs_item.freezed.dart';

part 'cs_item.g.dart';

@freezed
class CSItem with _$CSItem {
  const factory CSItem(
      {required int id,
      required int idList,
      required String description,
      required String wewenang}) = _CSItem;

  factory CSItem.initial() =>
      CSItem(id: 0, idList: 0, description: '', wewenang: '');

  factory CSItem.fromJson(Map<String, Object?> json) => _$CSItemFromJson(json);

  static List<CSItem> CSItemListFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((e) => CSItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static String CSItemListToJson(List<CSItem> resultList) {
    List<Map<String, dynamic>> jsonList =
        resultList.map((e) => e.toJson()).toList();
    return jsonEncode(jsonList);
  }
}
