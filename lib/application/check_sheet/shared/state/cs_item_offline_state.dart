import 'package:freezed_annotation/freezed_annotation.dart';

part 'cs_item_offline_state.freezed.dart';

@freezed
class CSItemOfflineState with _$CSItemOfflineState {
  const factory CSItemOfflineState.initial() = _Initial;
  const factory CSItemOfflineState.hasOfflineStorage() = _Storage;
  const factory CSItemOfflineState.empty() = _Empty;
}
