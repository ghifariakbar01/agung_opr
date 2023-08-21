import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_offline_state.freezed.dart';

@freezed
class CustomerOfflineState with _$CustomerOfflineState {
  const factory CustomerOfflineState.initial() = _Initial;
  const factory CustomerOfflineState.hasOfflineStorage() = _Storage;
  const factory CustomerOfflineState.empty() = _Empty;
}
