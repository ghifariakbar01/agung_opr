import 'package:freezed_annotation/freezed_annotation.dart';

part 'csu_ng_by_id_offline_state.freezed.dart';

@freezed
class CSUNGByIDfflineState with _$CSUNGByIDfflineState {
  const factory CSUNGByIDfflineState.initial() = _Initial;
  const factory CSUNGByIDfflineState.hasOfflineStorage() = _Storage;
  const factory CSUNGByIDfflineState.empty() = _Empty;
}
