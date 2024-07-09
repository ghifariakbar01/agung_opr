// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'csu_gate_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CSUGateState {
  bool get isProcessing => throw _privateConstructorUsedError;
  CSUMSTGate get defaultGate => throw _privateConstructorUsedError;
  List<CSUMSTGate> get gates => throw _privateConstructorUsedError;
  Option<Either<RemoteFailure, List<CSUMSTGate>>> get FOSOGate =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CSUGateStateCopyWith<CSUGateState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CSUGateStateCopyWith<$Res> {
  factory $CSUGateStateCopyWith(
          CSUGateState value, $Res Function(CSUGateState) then) =
      _$CSUGateStateCopyWithImpl<$Res, CSUGateState>;
  @useResult
  $Res call(
      {bool isProcessing,
      CSUMSTGate defaultGate,
      List<CSUMSTGate> gates,
      Option<Either<RemoteFailure, List<CSUMSTGate>>> FOSOGate});

  $CSUMSTGateCopyWith<$Res> get defaultGate;
}

/// @nodoc
class _$CSUGateStateCopyWithImpl<$Res, $Val extends CSUGateState>
    implements $CSUGateStateCopyWith<$Res> {
  _$CSUGateStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isProcessing = null,
    Object? defaultGate = null,
    Object? gates = null,
    Object? FOSOGate = null,
  }) {
    return _then(_value.copyWith(
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      defaultGate: null == defaultGate
          ? _value.defaultGate
          : defaultGate // ignore: cast_nullable_to_non_nullable
              as CSUMSTGate,
      gates: null == gates
          ? _value.gates
          : gates // ignore: cast_nullable_to_non_nullable
              as List<CSUMSTGate>,
      FOSOGate: null == FOSOGate
          ? _value.FOSOGate
          : FOSOGate // ignore: cast_nullable_to_non_nullable
              as Option<Either<RemoteFailure, List<CSUMSTGate>>>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CSUMSTGateCopyWith<$Res> get defaultGate {
    return $CSUMSTGateCopyWith<$Res>(_value.defaultGate, (value) {
      return _then(_value.copyWith(defaultGate: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CSUGateStateCopyWith<$Res>
    implements $CSUGateStateCopyWith<$Res> {
  factory _$$_CSUGateStateCopyWith(
          _$_CSUGateState value, $Res Function(_$_CSUGateState) then) =
      __$$_CSUGateStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isProcessing,
      CSUMSTGate defaultGate,
      List<CSUMSTGate> gates,
      Option<Either<RemoteFailure, List<CSUMSTGate>>> FOSOGate});

  @override
  $CSUMSTGateCopyWith<$Res> get defaultGate;
}

/// @nodoc
class __$$_CSUGateStateCopyWithImpl<$Res>
    extends _$CSUGateStateCopyWithImpl<$Res, _$_CSUGateState>
    implements _$$_CSUGateStateCopyWith<$Res> {
  __$$_CSUGateStateCopyWithImpl(
      _$_CSUGateState _value, $Res Function(_$_CSUGateState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isProcessing = null,
    Object? defaultGate = null,
    Object? gates = null,
    Object? FOSOGate = null,
  }) {
    return _then(_$_CSUGateState(
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      defaultGate: null == defaultGate
          ? _value.defaultGate
          : defaultGate // ignore: cast_nullable_to_non_nullable
              as CSUMSTGate,
      gates: null == gates
          ? _value._gates
          : gates // ignore: cast_nullable_to_non_nullable
              as List<CSUMSTGate>,
      FOSOGate: null == FOSOGate
          ? _value.FOSOGate
          : FOSOGate // ignore: cast_nullable_to_non_nullable
              as Option<Either<RemoteFailure, List<CSUMSTGate>>>,
    ));
  }
}

/// @nodoc

class _$_CSUGateState implements _CSUGateState {
  const _$_CSUGateState(
      {required this.isProcessing,
      required this.defaultGate,
      required final List<CSUMSTGate> gates,
      required this.FOSOGate})
      : _gates = gates;

  @override
  final bool isProcessing;
  @override
  final CSUMSTGate defaultGate;
  final List<CSUMSTGate> _gates;
  @override
  List<CSUMSTGate> get gates {
    if (_gates is EqualUnmodifiableListView) return _gates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_gates);
  }

  @override
  final Option<Either<RemoteFailure, List<CSUMSTGate>>> FOSOGate;

  @override
  String toString() {
    return 'CSUGateState(isProcessing: $isProcessing, defaultGate: $defaultGate, gates: $gates, FOSOGate: $FOSOGate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CSUGateState &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            (identical(other.defaultGate, defaultGate) ||
                other.defaultGate == defaultGate) &&
            const DeepCollectionEquality().equals(other._gates, _gates) &&
            (identical(other.FOSOGate, FOSOGate) ||
                other.FOSOGate == FOSOGate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isProcessing, defaultGate,
      const DeepCollectionEquality().hash(_gates), FOSOGate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CSUGateStateCopyWith<_$_CSUGateState> get copyWith =>
      __$$_CSUGateStateCopyWithImpl<_$_CSUGateState>(this, _$identity);
}

abstract class _CSUGateState implements CSUGateState {
  const factory _CSUGateState(
      {required final bool isProcessing,
      required final CSUMSTGate defaultGate,
      required final List<CSUMSTGate> gates,
      required final Option<Either<RemoteFailure, List<CSUMSTGate>>>
          FOSOGate}) = _$_CSUGateState;

  @override
  bool get isProcessing;
  @override
  CSUMSTGate get defaultGate;
  @override
  List<CSUMSTGate> get gates;
  @override
  Option<Either<RemoteFailure, List<CSUMSTGate>>> get FOSOGate;
  @override
  @JsonKey(ignore: true)
  _$$_CSUGateStateCopyWith<_$_CSUGateState> get copyWith =>
      throw _privateConstructorUsedError;
}
