//  "id": 119886,
//  "frame": "DUMMY 324",
//  "gate": "TAM CCY CIBITUNG",
//  "inOut": false,
//  "isDefect": 0,
//  "updatedAt": "2019-10-09 09:39:34"

// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'csu_result.dart';

part 'spk_csu_result.freezed.dart';

part 'spk_csu_result.g.dart';

List<Map<String, dynamic>> listToJson(List<CSUResult> list) {
  return list.map((item) => item.toJson()).toList();
}

List<FrameNameCSUResult> listFrameNameCSUResultFromJson(
    List<dynamic> jsonList) {
  return jsonList
      .map((e) => FrameNameCSUResult.fromJson(e as Map<String, dynamic>))
      .toList();
}

String listFrameNameCSUResultToJson(List<FrameNameCSUResult> resultList) {
  List<Map<String, dynamic>> jsonList =
      resultList.map((e) => e.toJson()).toList();
  return jsonEncode(jsonList);
}

@freezed
class FrameNameCSUResult with _$FrameNameCSUResult {
  const factory FrameNameCSUResult(
          {required String frameName,
          @JsonKey(toJson: listToJson) required List<CSUResult> csuResult}) =
      _FrameNameCSUResult;

  factory FrameNameCSUResult.fromJson(Map<String, Object?> json) =>
      _$FrameNameCSUResultFromJson(json);
}
