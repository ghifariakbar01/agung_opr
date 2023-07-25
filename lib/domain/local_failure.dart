import 'package:freezed_annotation/freezed_annotation.dart';

part 'local_failure.freezed.dart';

@freezed
class LocalFailure with _$LocalFailure {
  const factory LocalFailure.storage() = _Storage;
  const factory LocalFailure.format([String? message]) = _Format;
  const factory LocalFailure.empty() = _Empty;
}
