import 'package:freezed_annotation/freezed_annotation.dart';

part 'csu_jenis_penyebab_offline_state.freezed.dart';

@freezed
class CSUJenisPenyebabOfflineState with _$CSUJenisPenyebabOfflineState {
  const factory CSUJenisPenyebabOfflineState.initial() = _Initial;
  const factory CSUJenisPenyebabOfflineState.hasOfflineStorage() = _Storage;
  const factory CSUJenisPenyebabOfflineState.empty() = _Empty;
}
