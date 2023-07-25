// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auto_data_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AutoDataState {
  bool get isGetting => throw _privateConstructorUsedError;
  Option<Either<RemoteFailure, List<SPK>>> get FOSOSPKAutoData =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AutoDataStateCopyWith<AutoDataState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AutoDataStateCopyWith<$Res> {
  factory $AutoDataStateCopyWith(
          AutoDataState value, $Res Function(AutoDataState) then) =
      _$AutoDataStateCopyWithImpl<$Res, AutoDataState>;
  @useResult
  $Res call(
      {bool isGetting,
      Option<Either<RemoteFailure, List<SPK>>> FOSOSPKAutoData});
}

/// @nodoc
class _$AutoDataStateCopyWithImpl<$Res, $Val extends AutoDataState>
    implements $AutoDataStateCopyWith<$Res> {
  _$AutoDataStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isGetting = null,
    Object? FOSOSPKAutoData = null,
  }) {
    return _then(_value.copyWith(
      isGetting: null == isGetting
          ? _value.isGetting
          : isGetting // ignore: cast_nullable_to_non_nullable
              as bool,
      FOSOSPKAutoData: null == FOSOSPKAutoData
          ? _value.FOSOSPKAutoData
          : FOSOSPKAutoData // ignore: cast_nullable_to_non_nullable
              as Option<Either<RemoteFailure, List<SPK>>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AutoDataStateCopyWith<$Res>
    implements $AutoDataStateCopyWith<$Res> {
  factory _$$_AutoDataStateCopyWith(
          _$_AutoDataState value, $Res Function(_$_AutoDataState) then) =
      __$$_AutoDataStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isGetting,
      Option<Either<RemoteFailure, List<SPK>>> FOSOSPKAutoData});
}

/// @nodoc
class __$$_AutoDataStateCopyWithImpl<$Res>
    extends _$AutoDataStateCopyWithImpl<$Res, _$_AutoDataState>
    implements _$$_AutoDataStateCopyWith<$Res> {
  __$$_AutoDataStateCopyWithImpl(
      _$_AutoDataState _value, $Res Function(_$_AutoDataState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isGetting = null,
    Object? FOSOSPKAutoData = null,
  }) {
    return _then(_$_AutoDataState(
      isGetting: null == isGetting
          ? _value.isGetting
          : isGetting // ignore: cast_nullable_to_non_nullable
              as bool,
      FOSOSPKAutoData: null == FOSOSPKAutoData
          ? _value.FOSOSPKAutoData
          : FOSOSPKAutoData // ignore: cast_nullable_to_non_nullable
              as Option<Either<RemoteFailure, List<SPK>>>,
    ));
  }
}

/// @nodoc

class _$_AutoDataState implements _AutoDataState {
  const _$_AutoDataState(
      {required this.isGetting, required this.FOSOSPKAutoData});

  @override
  final bool isGetting;
  @override
  final Option<Either<RemoteFailure, List<SPK>>> FOSOSPKAutoData;

  @override
  String toString() {
    return 'AutoDataState(isGetting: $isGetting, FOSOSPKAutoData: $FOSOSPKAutoData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AutoDataState &&
            (identical(other.isGetting, isGetting) ||
                other.isGetting == isGetting) &&
            (identical(other.FOSOSPKAutoData, FOSOSPKAutoData) ||
                other.FOSOSPKAutoData == FOSOSPKAutoData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isGetting, FOSOSPKAutoData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AutoDataStateCopyWith<_$_AutoDataState> get copyWith =>
      __$$_AutoDataStateCopyWithImpl<_$_AutoDataState>(this, _$identity);
}

abstract class _AutoDataState implements AutoDataState {
  const factory _AutoDataState(
      {required final bool isGetting,
      required final Option<Either<RemoteFailure, List<SPK>>>
          FOSOSPKAutoData}) = _$_AutoDataState;

  @override
  bool get isGetting;
  @override
  Option<Either<RemoteFailure, List<SPK>>> get FOSOSPKAutoData;
  @override
  @JsonKey(ignore: true)
  _$$_AutoDataStateCopyWith<_$_AutoDataState> get copyWith =>
      throw _privateConstructorUsedError;
}
