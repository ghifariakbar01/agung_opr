// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_cs_ng_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UpdateCSNGState {
  int get id => throw _privateConstructorUsedError;
  OKorNG get status => throw _privateConstructorUsedError;
  Keterangan get keterangan => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UpdateCSNGStateCopyWith<UpdateCSNGState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateCSNGStateCopyWith<$Res> {
  factory $UpdateCSNGStateCopyWith(
          UpdateCSNGState value, $Res Function(UpdateCSNGState) then) =
      _$UpdateCSNGStateCopyWithImpl<$Res, UpdateCSNGState>;
  @useResult
  $Res call({int id, OKorNG status, Keterangan keterangan});
}

/// @nodoc
class _$UpdateCSNGStateCopyWithImpl<$Res, $Val extends UpdateCSNGState>
    implements $UpdateCSNGStateCopyWith<$Res> {
  _$UpdateCSNGStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? keterangan = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OKorNG,
      keterangan: null == keterangan
          ? _value.keterangan
          : keterangan // ignore: cast_nullable_to_non_nullable
              as Keterangan,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UpdateCSNGStateCopyWith<$Res>
    implements $UpdateCSNGStateCopyWith<$Res> {
  factory _$$_UpdateCSNGStateCopyWith(
          _$_UpdateCSNGState value, $Res Function(_$_UpdateCSNGState) then) =
      __$$_UpdateCSNGStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, OKorNG status, Keterangan keterangan});
}

/// @nodoc
class __$$_UpdateCSNGStateCopyWithImpl<$Res>
    extends _$UpdateCSNGStateCopyWithImpl<$Res, _$_UpdateCSNGState>
    implements _$$_UpdateCSNGStateCopyWith<$Res> {
  __$$_UpdateCSNGStateCopyWithImpl(
      _$_UpdateCSNGState _value, $Res Function(_$_UpdateCSNGState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? keterangan = null,
  }) {
    return _then(_$_UpdateCSNGState(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OKorNG,
      keterangan: null == keterangan
          ? _value.keterangan
          : keterangan // ignore: cast_nullable_to_non_nullable
              as Keterangan,
    ));
  }
}

/// @nodoc

class _$_UpdateCSNGState implements _UpdateCSNGState {
  const _$_UpdateCSNGState(
      {required this.id, required this.status, required this.keterangan});

  @override
  final int id;
  @override
  final OKorNG status;
  @override
  final Keterangan keterangan;

  @override
  String toString() {
    return 'UpdateCSNGState(id: $id, status: $status, keterangan: $keterangan)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UpdateCSNGState &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.keterangan, keterangan) ||
                other.keterangan == keterangan));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, status, keterangan);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UpdateCSNGStateCopyWith<_$_UpdateCSNGState> get copyWith =>
      __$$_UpdateCSNGStateCopyWithImpl<_$_UpdateCSNGState>(this, _$identity);
}

abstract class _UpdateCSNGState implements UpdateCSNGState {
  const factory _UpdateCSNGState(
      {required final int id,
      required final OKorNG status,
      required final Keterangan keterangan}) = _$_UpdateCSNGState;

  @override
  int get id;
  @override
  OKorNG get status;
  @override
  Keterangan get keterangan;
  @override
  @JsonKey(ignore: true)
  _$$_UpdateCSNGStateCopyWith<_$_UpdateCSNGState> get copyWith =>
      throw _privateConstructorUsedError;
}
