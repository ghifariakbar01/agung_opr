import 'package:freezed_annotation/freezed_annotation.dart';

part 'cs_jenis_state.freezed.dart';

@freezed
class CSJenisState with _$CSJenisState {
  const factory CSJenisState({required int id, required String nama}) =
      _CSJenisState;

  factory CSJenisState.initial() => CSJenisState(id: 0, nama: '');
}
