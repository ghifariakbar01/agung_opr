import 'package:freezed_annotation/freezed_annotation.dart';

import '../update_cs_disable/disable.dart';

part 'double.g.dart';
part 'double.freezed.dart';

@freezed
class SPKDouble with _$SPKDouble {
  factory SPKDouble({
    required int idSpk,
    required UpdateCsDisable disable,
  }) = _Double;

  factory SPKDouble.initial() => SPKDouble(
        idSpk: 0,
        disable: UpdateCsDisable.inital(),
      );

  factory SPKDouble.fromJson(Map<String, dynamic> json) =>
      _$SPKDoubleFromJson(json);
}
