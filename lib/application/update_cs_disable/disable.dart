import 'package:freezed_annotation/freezed_annotation.dart';

part 'disable.freezed.dart';
part 'disable.g.dart';

@freezed
class UpdateCsDisable with _$UpdateCsDisable {
  factory UpdateCsDisable({
    required bool loading,
    required bool unload,
    required bool loadunload,
  }) = _UpdateCsuDisable;

  factory UpdateCsDisable.fromJson(Map<String, dynamic> json) =>
      _$UpdateCsDisableFromJson(json);

  factory UpdateCsDisable.inital() => UpdateCsDisable(
        loading: false,
        unload: false,
        loadunload: false,
      );
}
