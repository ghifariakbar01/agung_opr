// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clear_data_essential_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ClearDataEssentialState {
  bool get isClearing => throw _privateConstructorUsedError;
  Option<Either<LocalFailure, Unit>> get FOSOSPKClearDataEssential =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ClearDataEssentialStateCopyWith<ClearDataEssentialState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClearDataEssentialStateCopyWith<$Res> {
  factory $ClearDataEssentialStateCopyWith(ClearDataEssentialState value,
          $Res Function(ClearDataEssentialState) then) =
      _$ClearDataEssentialStateCopyWithImpl<$Res, ClearDataEssentialState>;
  @useResult
  $Res call(
      {bool isClearing,
      Option<Either<LocalFailure, Unit>> FOSOSPKClearDataEssential});
}

/// @nodoc
class _$ClearDataEssentialStateCopyWithImpl<$Res,
        $Val extends ClearDataEssentialState>
    implements $ClearDataEssentialStateCopyWith<$Res> {
  _$ClearDataEssentialStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isClearing = null,
    Object? FOSOSPKClearDataEssential = null,
  }) {
    return _then(_value.copyWith(
      isClearing: null == isClearing
          ? _value.isClearing
          : isClearing // ignore: cast_nullable_to_non_nullable
              as bool,
      FOSOSPKClearDataEssential: null == FOSOSPKClearDataEssential
          ? _value.FOSOSPKClearDataEssential
          : FOSOSPKClearDataEssential // ignore: cast_nullable_to_non_nullable
              as Option<Either<LocalFailure, Unit>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ClearDataEssentialStateCopyWith<$Res>
    implements $ClearDataEssentialStateCopyWith<$Res> {
  factory _$$_ClearDataEssentialStateCopyWith(_$_ClearDataEssentialState value,
          $Res Function(_$_ClearDataEssentialState) then) =
      __$$_ClearDataEssentialStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isClearing,
      Option<Either<LocalFailure, Unit>> FOSOSPKClearDataEssential});
}

/// @nodoc
class __$$_ClearDataEssentialStateCopyWithImpl<$Res>
    extends _$ClearDataEssentialStateCopyWithImpl<$Res,
        _$_ClearDataEssentialState>
    implements _$$_ClearDataEssentialStateCopyWith<$Res> {
  __$$_ClearDataEssentialStateCopyWithImpl(_$_ClearDataEssentialState _value,
      $Res Function(_$_ClearDataEssentialState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isClearing = null,
    Object? FOSOSPKClearDataEssential = null,
  }) {
    return _then(_$_ClearDataEssentialState(
      isClearing: null == isClearing
          ? _value.isClearing
          : isClearing // ignore: cast_nullable_to_non_nullable
              as bool,
      FOSOSPKClearDataEssential: null == FOSOSPKClearDataEssential
          ? _value.FOSOSPKClearDataEssential
          : FOSOSPKClearDataEssential // ignore: cast_nullable_to_non_nullable
              as Option<Either<LocalFailure, Unit>>,
    ));
  }
}

/// @nodoc

class _$_ClearDataEssentialState implements _ClearDataEssentialState {
  const _$_ClearDataEssentialState(
      {required this.isClearing, required this.FOSOSPKClearDataEssential});

  @override
  final bool isClearing;
  @override
  final Option<Either<LocalFailure, Unit>> FOSOSPKClearDataEssential;

  @override
  String toString() {
    return 'ClearDataEssentialState(isClearing: $isClearing, FOSOSPKClearDataEssential: $FOSOSPKClearDataEssential)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ClearDataEssentialState &&
            (identical(other.isClearing, isClearing) ||
                other.isClearing == isClearing) &&
            (identical(other.FOSOSPKClearDataEssential,
                    FOSOSPKClearDataEssential) ||
                other.FOSOSPKClearDataEssential == FOSOSPKClearDataEssential));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isClearing, FOSOSPKClearDataEssential);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ClearDataEssentialStateCopyWith<_$_ClearDataEssentialState>
      get copyWith =>
          __$$_ClearDataEssentialStateCopyWithImpl<_$_ClearDataEssentialState>(
              this, _$identity);
}

abstract class _ClearDataEssentialState implements ClearDataEssentialState {
  const factory _ClearDataEssentialState(
      {required final bool isClearing,
      required final Option<Either<LocalFailure, Unit>>
          FOSOSPKClearDataEssential}) = _$_ClearDataEssentialState;

  @override
  bool get isClearing;
  @override
  Option<Either<LocalFailure, Unit>> get FOSOSPKClearDataEssential;
  @override
  @JsonKey(ignore: true)
  _$$_ClearDataEssentialStateCopyWith<_$_ClearDataEssentialState>
      get copyWith => throw _privateConstructorUsedError;
}
