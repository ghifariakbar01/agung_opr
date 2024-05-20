// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'remember_me_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RememberMeState _$RememberMeStateFromJson(Map<String, dynamic> json) {
  return _RememberMeState.fromJson(json);
}

/// @nodoc
mixin _$RememberMeState {
  String get nik => throw _privateConstructorUsedError;
  String get nama => throw _privateConstructorUsedError;
  String get jobdesk => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RememberMeStateCopyWith<RememberMeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RememberMeStateCopyWith<$Res> {
  factory $RememberMeStateCopyWith(
          RememberMeState value, $Res Function(RememberMeState) then) =
      _$RememberMeStateCopyWithImpl<$Res, RememberMeState>;
  @useResult
  $Res call({String nik, String nama, String jobdesk, String password});
}

/// @nodoc
class _$RememberMeStateCopyWithImpl<$Res, $Val extends RememberMeState>
    implements $RememberMeStateCopyWith<$Res> {
  _$RememberMeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nik = null,
    Object? nama = null,
    Object? jobdesk = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      nik: null == nik
          ? _value.nik
          : nik // ignore: cast_nullable_to_non_nullable
              as String,
      nama: null == nama
          ? _value.nama
          : nama // ignore: cast_nullable_to_non_nullable
              as String,
      jobdesk: null == jobdesk
          ? _value.jobdesk
          : jobdesk // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RememberMeStateCopyWith<$Res>
    implements $RememberMeStateCopyWith<$Res> {
  factory _$$_RememberMeStateCopyWith(
          _$_RememberMeState value, $Res Function(_$_RememberMeState) then) =
      __$$_RememberMeStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String nik, String nama, String jobdesk, String password});
}

/// @nodoc
class __$$_RememberMeStateCopyWithImpl<$Res>
    extends _$RememberMeStateCopyWithImpl<$Res, _$_RememberMeState>
    implements _$$_RememberMeStateCopyWith<$Res> {
  __$$_RememberMeStateCopyWithImpl(
      _$_RememberMeState _value, $Res Function(_$_RememberMeState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nik = null,
    Object? nama = null,
    Object? jobdesk = null,
    Object? password = null,
  }) {
    return _then(_$_RememberMeState(
      nik: null == nik
          ? _value.nik
          : nik // ignore: cast_nullable_to_non_nullable
              as String,
      nama: null == nama
          ? _value.nama
          : nama // ignore: cast_nullable_to_non_nullable
              as String,
      jobdesk: null == jobdesk
          ? _value.jobdesk
          : jobdesk // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RememberMeState implements _RememberMeState {
  const _$_RememberMeState(
      {required this.nik,
      required this.nama,
      required this.jobdesk,
      required this.password});

  factory _$_RememberMeState.fromJson(Map<String, dynamic> json) =>
      _$$_RememberMeStateFromJson(json);

  @override
  final String nik;
  @override
  final String nama;
  @override
  final String jobdesk;
  @override
  final String password;

  @override
  String toString() {
    return 'RememberMeState(nik: $nik, nama: $nama, jobdesk: $jobdesk, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RememberMeState &&
            (identical(other.nik, nik) || other.nik == nik) &&
            (identical(other.nama, nama) || other.nama == nama) &&
            (identical(other.jobdesk, jobdesk) || other.jobdesk == jobdesk) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, nik, nama, jobdesk, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RememberMeStateCopyWith<_$_RememberMeState> get copyWith =>
      __$$_RememberMeStateCopyWithImpl<_$_RememberMeState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RememberMeStateToJson(
      this,
    );
  }
}

abstract class _RememberMeState implements RememberMeState {
  const factory _RememberMeState(
      {required final String nik,
      required final String nama,
      required final String jobdesk,
      required final String password}) = _$_RememberMeState;

  factory _RememberMeState.fromJson(Map<String, dynamic> json) =
      _$_RememberMeState.fromJson;

  @override
  String get nik;
  @override
  String get nama;
  @override
  String get jobdesk;
  @override
  String get password;
  @override
  @JsonKey(ignore: true)
  _$$_RememberMeStateCopyWith<_$_RememberMeState> get copyWith =>
      throw _privateConstructorUsedError;
}
