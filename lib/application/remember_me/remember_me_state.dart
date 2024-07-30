import 'package:freezed_annotation/freezed_annotation.dart';

part 'remember_me_state.freezed.dart';

part 'remember_me_state.g.dart';

@freezed
class RememberMeState with _$RememberMeState {
  const factory RememberMeState({
    required String nik,
    required String nama,
    required String jobdesk,
    required String password,
    @JsonKey(name: 'no_ktp') required String noKtp,
  }) = _RememberMeState;

  factory RememberMeState.fromJson(Map<String, Object?> json) =>
      _$RememberMeStateFromJson(json);
}
