import 'package:freezed_annotation/freezed_annotation.dart';

part 'csu_items_offline_state.freezed.dart';

@freezed
class CSUItemsOfflineState with _$CSUItemsOfflineState {
  const factory CSUItemsOfflineState.initial() = _Initial;
  const factory CSUItemsOfflineState.hasOfflineStorage() = _Storage;
  const factory CSUItemsOfflineState.empty() = _Empty;
}
