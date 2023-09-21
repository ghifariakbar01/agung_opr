// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clear_data_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ClearDataState {
  bool get isClearing => throw _privateConstructorUsedError;
  Option<Either<LocalFailure, Unit>> get FOSOSPKClearData =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ClearDataStateCopyWith<ClearDataState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClearDataStateCopyWith<$Res> {
  factory $ClearDataStateCopyWith(
          ClearDataState value, $Res Function(ClearDataState) then) =
      _$ClearDataStateCopyWithImpl<$Res, ClearDataState>;
  @useResult
  $Res call(
      {bool isClearing, Option<Either<LocalFailure, Unit>> FOSOSPKClearData});
}

/// @nodoc
class _$ClearDataStateCopyWithImpl<$Res, $Val extends ClearDataState>
    implements $ClearDataStateCopyWith<$Res> {
  _$ClearDataStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isClearing = null,
    Object? FOSOSPKClearData = null,
  }) {
    return _then(_value.copyWith(
      isClearing: null == isClearing
          ? _value.isClearing
          : isClearing // ignore: cast_nullable_to_non_nullable
              as bool,
      FOSOSPKClearData: null == FOSOSPKClearData
          ? _value.FOSOSPKClearData
          : FOSOSPKClearData // ignore: cast_nullable_to_non_nullable
              as Option<Either<LocalFailure, Unit>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ClearDataStateCopyWith<$Res>
    implements $ClearDataStateCopyWith<$Res> {
  factory _$$_ClearDataStateCopyWith(
          _$_ClearDataState value, $Res Function(_$_ClearDataState) then) =
      __$$_ClearDataStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isClearing, Option<Either<LocalFailure, Unit>> FOSOSPKClearData});
}

/// @nodoc
class __$$_ClearDataStateCopyWithImpl<$Res>
    extends _$ClearDataStateCopyWithImpl<$Res, _$_ClearDataState>
    implements _$$_ClearDataStateCopyWith<$Res> {
  __$$_ClearDataStateCopyWithImpl(
      _$_ClearDataState _value, $Res Function(_$_ClearDataState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isClearing = null,
    Object? FOSOSPKClearData = null,
  }) {
    return _then(_$_ClearDataState(
      isClearing: null == isClearing
          ? _value.isClearing
          : isClearing // ignore: cast_nullable_to_non_nullable
              as bool,
      FOSOSPKClearData: null == FOSOSPKClearData
          ? _value.FOSOSPKClearData
          : FOSOSPKClearData // ignore: cast_nullable_to_non_nullable
              as Option<Either<LocalFailure, Unit>>,
    ));
  }
}

/// @nodoc

class _$_ClearDataState implements _ClearDataState {
  const _$_ClearDataState(
      {required this.isClearing, required this.FOSOSPKClearData});

  @override
  final bool isClearing;
  @override
  final Option<Either<LocalFailure, Unit>> FOSOSPKClearData;

  @override
  String toString() {
    return 'ClearDataState(isClearing: $isClearing, FOSOSPKClearData: $FOSOSPKClearData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ClearDataState &&
            (identical(other.isClearing, isClearing) ||
                other.isClearing == isClearing) &&
            (identical(other.FOSOSPKClearData, FOSOSPKClearData) ||
                other.FOSOSPKClearData == FOSOSPKClearData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isClearing, FOSOSPKClearData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ClearDataStateCopyWith<_$_ClearDataState> get copyWith =>
      __$$_ClearDataStateCopyWithImpl<_$_ClearDataState>(this, _$identity);
}

abstract class _ClearDataState implements ClearDataState {
  const factory _ClearDataState(
          {required final bool isClearing,
          required final Option<Either<LocalFailure, Unit>> FOSOSPKClearData}) =
      _$_ClearDataState;

  @override
  bool get isClearing;
  @override
  Option<Either<LocalFailure, Unit>> get FOSOSPKClearData;
  @override
  @JsonKey(ignore: true)
  _$$_ClearDataStateCopyWith<_$_ClearDataState> get copyWith =>
      throw _privateConstructorUsedError;
}
