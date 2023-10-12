// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sort_data_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SortDataState {
  bool get isGetting => throw _privateConstructorUsedError;
  Option<Either<RemoteFailure, Unit>> get FOSOSPKSortData =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SortDataStateCopyWith<SortDataState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SortDataStateCopyWith<$Res> {
  factory $SortDataStateCopyWith(
          SortDataState value, $Res Function(SortDataState) then) =
      _$SortDataStateCopyWithImpl<$Res, SortDataState>;
  @useResult
  $Res call(
      {bool isGetting, Option<Either<RemoteFailure, Unit>> FOSOSPKSortData});
}

/// @nodoc
class _$SortDataStateCopyWithImpl<$Res, $Val extends SortDataState>
    implements $SortDataStateCopyWith<$Res> {
  _$SortDataStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isGetting = null,
    Object? FOSOSPKSortData = null,
  }) {
    return _then(_value.copyWith(
      isGetting: null == isGetting
          ? _value.isGetting
          : isGetting // ignore: cast_nullable_to_non_nullable
              as bool,
      FOSOSPKSortData: null == FOSOSPKSortData
          ? _value.FOSOSPKSortData
          : FOSOSPKSortData // ignore: cast_nullable_to_non_nullable
              as Option<Either<RemoteFailure, Unit>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SortDataStateCopyWith<$Res>
    implements $SortDataStateCopyWith<$Res> {
  factory _$$_SortDataStateCopyWith(
          _$_SortDataState value, $Res Function(_$_SortDataState) then) =
      __$$_SortDataStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isGetting, Option<Either<RemoteFailure, Unit>> FOSOSPKSortData});
}

/// @nodoc
class __$$_SortDataStateCopyWithImpl<$Res>
    extends _$SortDataStateCopyWithImpl<$Res, _$_SortDataState>
    implements _$$_SortDataStateCopyWith<$Res> {
  __$$_SortDataStateCopyWithImpl(
      _$_SortDataState _value, $Res Function(_$_SortDataState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isGetting = null,
    Object? FOSOSPKSortData = null,
  }) {
    return _then(_$_SortDataState(
      isGetting: null == isGetting
          ? _value.isGetting
          : isGetting // ignore: cast_nullable_to_non_nullable
              as bool,
      FOSOSPKSortData: null == FOSOSPKSortData
          ? _value.FOSOSPKSortData
          : FOSOSPKSortData // ignore: cast_nullable_to_non_nullable
              as Option<Either<RemoteFailure, Unit>>,
    ));
  }
}

/// @nodoc

class _$_SortDataState implements _SortDataState {
  const _$_SortDataState(
      {required this.isGetting, required this.FOSOSPKSortData});

  @override
  final bool isGetting;
  @override
  final Option<Either<RemoteFailure, Unit>> FOSOSPKSortData;

  @override
  String toString() {
    return 'SortDataState(isGetting: $isGetting, FOSOSPKSortData: $FOSOSPKSortData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SortDataState &&
            (identical(other.isGetting, isGetting) ||
                other.isGetting == isGetting) &&
            (identical(other.FOSOSPKSortData, FOSOSPKSortData) ||
                other.FOSOSPKSortData == FOSOSPKSortData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isGetting, FOSOSPKSortData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SortDataStateCopyWith<_$_SortDataState> get copyWith =>
      __$$_SortDataStateCopyWithImpl<_$_SortDataState>(this, _$identity);
}

abstract class _SortDataState implements SortDataState {
  const factory _SortDataState(
          {required final bool isGetting,
          required final Option<Either<RemoteFailure, Unit>> FOSOSPKSortData}) =
      _$_SortDataState;

  @override
  bool get isGetting;
  @override
  Option<Either<RemoteFailure, Unit>> get FOSOSPKSortData;
  @override
  @JsonKey(ignore: true)
  _$$_SortDataStateCopyWith<_$_SortDataState> get copyWith =>
      throw _privateConstructorUsedError;
}
