// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_csu_ng_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UpdateCSUNGState {
  int get idCs => throw _privateConstructorUsedError;
  int get idJenis => throw _privateConstructorUsedError;
  int get idPenyebab => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UpdateCSUNGStateCopyWith<UpdateCSUNGState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateCSUNGStateCopyWith<$Res> {
  factory $UpdateCSUNGStateCopyWith(
          UpdateCSUNGState value, $Res Function(UpdateCSUNGState) then) =
      _$UpdateCSUNGStateCopyWithImpl<$Res, UpdateCSUNGState>;
  @useResult
  $Res call({int idCs, int idJenis, int idPenyebab});
}

/// @nodoc
class _$UpdateCSUNGStateCopyWithImpl<$Res, $Val extends UpdateCSUNGState>
    implements $UpdateCSUNGStateCopyWith<$Res> {
  _$UpdateCSUNGStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idCs = null,
    Object? idJenis = null,
    Object? idPenyebab = null,
  }) {
    return _then(_value.copyWith(
      idCs: null == idCs
          ? _value.idCs
          : idCs // ignore: cast_nullable_to_non_nullable
              as int,
      idJenis: null == idJenis
          ? _value.idJenis
          : idJenis // ignore: cast_nullable_to_non_nullable
              as int,
      idPenyebab: null == idPenyebab
          ? _value.idPenyebab
          : idPenyebab // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UpdateCSUNGStateCopyWith<$Res>
    implements $UpdateCSUNGStateCopyWith<$Res> {
  factory _$$_UpdateCSUNGStateCopyWith(
          _$_UpdateCSUNGState value, $Res Function(_$_UpdateCSUNGState) then) =
      __$$_UpdateCSUNGStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int idCs, int idJenis, int idPenyebab});
}

/// @nodoc
class __$$_UpdateCSUNGStateCopyWithImpl<$Res>
    extends _$UpdateCSUNGStateCopyWithImpl<$Res, _$_UpdateCSUNGState>
    implements _$$_UpdateCSUNGStateCopyWith<$Res> {
  __$$_UpdateCSUNGStateCopyWithImpl(
      _$_UpdateCSUNGState _value, $Res Function(_$_UpdateCSUNGState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idCs = null,
    Object? idJenis = null,
    Object? idPenyebab = null,
  }) {
    return _then(_$_UpdateCSUNGState(
      idCs: null == idCs
          ? _value.idCs
          : idCs // ignore: cast_nullable_to_non_nullable
              as int,
      idJenis: null == idJenis
          ? _value.idJenis
          : idJenis // ignore: cast_nullable_to_non_nullable
              as int,
      idPenyebab: null == idPenyebab
          ? _value.idPenyebab
          : idPenyebab // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_UpdateCSUNGState implements _UpdateCSUNGState {
  const _$_UpdateCSUNGState(
      {required this.idCs, required this.idJenis, required this.idPenyebab});

  @override
  final int idCs;
  @override
  final int idJenis;
  @override
  final int idPenyebab;

  @override
  String toString() {
    return 'UpdateCSUNGState(idCs: $idCs, idJenis: $idJenis, idPenyebab: $idPenyebab)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UpdateCSUNGState &&
            (identical(other.idCs, idCs) || other.idCs == idCs) &&
            (identical(other.idJenis, idJenis) || other.idJenis == idJenis) &&
            (identical(other.idPenyebab, idPenyebab) ||
                other.idPenyebab == idPenyebab));
  }

  @override
  int get hashCode => Object.hash(runtimeType, idCs, idJenis, idPenyebab);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UpdateCSUNGStateCopyWith<_$_UpdateCSUNGState> get copyWith =>
      __$$_UpdateCSUNGStateCopyWithImpl<_$_UpdateCSUNGState>(this, _$identity);
}

abstract class _UpdateCSUNGState implements UpdateCSUNGState {
  const factory _UpdateCSUNGState(
      {required final int idCs,
      required final int idJenis,
      required final int idPenyebab}) = _$_UpdateCSUNGState;

  @override
  int get idCs;
  @override
  int get idJenis;
  @override
  int get idPenyebab;
  @override
  @JsonKey(ignore: true)
  _$$_UpdateCSUNGStateCopyWith<_$_UpdateCSUNGState> get copyWith =>
      throw _privateConstructorUsedError;
}
