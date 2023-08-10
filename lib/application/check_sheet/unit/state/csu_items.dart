// {
//   "id_item": 1,
//   "nama_ina": "Semua Area",
//   "nama_eng": "All Area",
//   "grup": "Exterior"
// },

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'csu_items.freezed.dart';

part 'csu_items.g.dart';

List<CSUItems> listCSUItemsFromJson(List<dynamic> jsonList) {
  return jsonList
      .map((e) => CSUItems.fromJson(e as Map<String, dynamic>))
      .toList();
}

String listCSUItemsToJsonSavable(List<CSUItems> resultList) {
  List<Map<String, dynamic>> jsonList =
      resultList.map((e) => e.toJson()).toList();
  return jsonEncode(jsonList);
}

@freezed
class CSUItems with _$CSUItems {
  const factory CSUItems(
      {@JsonKey(name: 'id_item') required int id,
      @JsonKey(name: 'nama_ina') required String? ind,
      @JsonKey(name: 'nama_eng') required String? eng,
      required String? grup}) = _CSUItems;

  factory CSUItems.fromJson(Map<String, Object?> json) =>
      _$CSUItemsFromJson(json);
}
