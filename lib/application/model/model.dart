import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';

part 'model.g.dart';

@freezed
class Model with _$Model {
  const factory Model(
      {required int id,
      required String? merk,
      required String? nama,
      required String? category,
      required double? grossweight,
      required double? measurement}) = _Model;

  factory Model.initial() => Model(
      id: 0, merk: '', nama: '', category: '', grossweight: 0, measurement: 0);

  factory Model.fromJson(Map<String, Object?> json) => _$ModelFromJson(json);

  static List<Model> ModelListFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((e) => Model.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static String ModelListToJson(List<Model> resultList) {
    List<Map<String, dynamic>> jsonList =
        resultList.map((e) => e.toJson()).toList();
    return jsonEncode(jsonList);
  }
}
