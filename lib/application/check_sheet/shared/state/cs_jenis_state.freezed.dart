// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cs_jenis_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CSJenisState _$CSJenisStateFromJson(Map<String, dynamic> json) {
  return _CSJenisState.fromJson(json);
}

/// @nodoc
mixin _$CSJenisState {
  int get id => throw _privateConstructorUsedError;
  String get nama => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CSJenisStateCopyWith<CSJenisState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CSJenisStateCopyWith<$Res> {
  factory $CSJenisStateCopyWith(
          CSJenisState value, $Res Function(CSJenisState) then) =
      _$CSJenisStateCopyWithImpl<$Res, CSJenisState>;
  @useResult
  $Res call({int id, String nama});
}

/// @nodoc
class _$CSJenisStateCopyWithImpl<$Res, $Val extends CSJenisState>
    implements $CSJenisStateCopyWith<$Res> {
  _$CSJenisStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nama = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      nama: null == nama
          ? _value.nama
          : nama // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CSJenisStateCopyWith<$Res>
    implements $CSJenisStateCopyWith<$Res> {
  factory _$$_CSJenisStateCopyWith(
          _$_CSJenisState value, $Res Function(_$_CSJenisState) then) =
      __$$_CSJenisStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String nama});
}

/// @nodoc
class __$$_CSJenisStateCopyWithImpl<$Res>
    extends _$CSJenisStateCopyWithImpl<$Res, _$_CSJenisState>
    implements _$$_CSJenisStateCopyWith<$Res> {
  __$$_CSJenisStateCopyWithImpl(
      _$_CSJenisState _value, $Res Function(_$_CSJenisState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nama = null,
  }) {
    return _then(_$_CSJenisState(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      nama: null == nama
          ? _value.nama
          : nama // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CSJenisState implements _CSJenisState {
  const _$_CSJenisState({required this.id, required this.nama});

  factory _$_CSJenisState.fromJson(Map<String, dynamic> json) =>
      _$$_CSJenisStateFromJson(json);

  @override
  final int id;
  @override
  final String nama;

  @override
  String toString() {
    return 'CSJenisState(id: $id, nama: $nama)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CSJenisState &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nama, nama) || other.nama == nama));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, nama);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CSJenisStateCopyWith<_$_CSJenisState> get copyWith =>
      __$$_CSJenisStateCopyWithImpl<_$_CSJenisState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CSJenisStateToJson(
      this,
    );
  }
}

abstract class _CSJenisState implements CSJenisState {
  const factory _CSJenisState(
      {required final int id, required final String nama}) = _$_CSJenisState;

  factory _CSJenisState.fromJson(Map<String, dynamic> json) =
      _$_CSJenisState.fromJson;

  @override
  int get id;
  @override
  String get nama;
  @override
  @JsonKey(ignore: true)
  _$$_CSJenisStateCopyWith<_$_CSJenisState> get copyWith =>
      throw _privateConstructorUsedError;
}
