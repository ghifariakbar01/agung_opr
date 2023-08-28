import 'package:freezed_annotation/freezed_annotation.dart';

part 'cs_jenis_offline_state.freezed.dart';

@freezed
class CSJenisOfflineState with _$CSJenisOfflineState {
  const factory CSJenisOfflineState.initial() = _Initial;
  const factory CSJenisOfflineState.hasOfflineStorage() = _Storage;
  const factory CSJenisOfflineState.empty() = _Empty;
}
