import 'package:freezed_annotation/freezed_annotation.dart';

part 'csu_result_offline_state.freezed.dart';

@freezed
class CSUResultOfflineState with _$CSUResultOfflineState {
  const factory CSUResultOfflineState.initial() = _Initial;
  const factory CSUResultOfflineState.hasOfflineStorage() = _Storage;
  const factory CSUResultOfflineState.empty() = _Empty;
}
