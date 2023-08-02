// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'frame_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FrameState {
  List<Frame> get frameList => throw _privateConstructorUsedError;
  int get selectedId => throw _privateConstructorUsedError;
  bool get isProcessing => throw _privateConstructorUsedError;
  Option<Either<RemoteFailure, List<Frame>>> get FOSOFrame =>
      throw _privateConstructorUsedError;
  Option<Either<LocalFailure, Unit>> get FOSOSaveFrame =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FrameStateCopyWith<FrameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FrameStateCopyWith<$Res> {
  factory $FrameStateCopyWith(
          FrameState value, $Res Function(FrameState) then) =
      _$FrameStateCopyWithImpl<$Res, FrameState>;
  @useResult
  $Res call(
      {List<Frame> frameList,
      int selectedId,
      bool isProcessing,
      Option<Either<RemoteFailure, List<Frame>>> FOSOFrame,
      Option<Either<LocalFailure, Unit>> FOSOSaveFrame});
}

/// @nodoc
class _$FrameStateCopyWithImpl<$Res, $Val extends FrameState>
    implements $FrameStateCopyWith<$Res> {
  _$FrameStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frameList = null,
    Object? selectedId = null,
    Object? isProcessing = null,
    Object? FOSOFrame = null,
    Object? FOSOSaveFrame = null,
  }) {
    return _then(_value.copyWith(
      frameList: null == frameList
          ? _value.frameList
          : frameList // ignore: cast_nullable_to_non_nullable
              as List<Frame>,
      selectedId: null == selectedId
          ? _value.selectedId
          : selectedId // ignore: cast_nullable_to_non_nullable
              as int,
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      FOSOFrame: null == FOSOFrame
          ? _value.FOSOFrame
          : FOSOFrame // ignore: cast_nullable_to_non_nullable
              as Option<Either<RemoteFailure, List<Frame>>>,
      FOSOSaveFrame: null == FOSOSaveFrame
          ? _value.FOSOSaveFrame
          : FOSOSaveFrame // ignore: cast_nullable_to_non_nullable
              as Option<Either<LocalFailure, Unit>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FrameStateCopyWith<$Res>
    implements $FrameStateCopyWith<$Res> {
  factory _$$_FrameStateCopyWith(
          _$_FrameState value, $Res Function(_$_FrameState) then) =
      __$$_FrameStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Frame> frameList,
      int selectedId,
      bool isProcessing,
      Option<Either<RemoteFailure, List<Frame>>> FOSOFrame,
      Option<Either<LocalFailure, Unit>> FOSOSaveFrame});
}

/// @nodoc
class __$$_FrameStateCopyWithImpl<$Res>
    extends _$FrameStateCopyWithImpl<$Res, _$_FrameState>
    implements _$$_FrameStateCopyWith<$Res> {
  __$$_FrameStateCopyWithImpl(
      _$_FrameState _value, $Res Function(_$_FrameState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frameList = null,
    Object? selectedId = null,
    Object? isProcessing = null,
    Object? FOSOFrame = null,
    Object? FOSOSaveFrame = null,
  }) {
    return _then(_$_FrameState(
      frameList: null == frameList
          ? _value._frameList
          : frameList // ignore: cast_nullable_to_non_nullable
              as List<Frame>,
      selectedId: null == selectedId
          ? _value.selectedId
          : selectedId // ignore: cast_nullable_to_non_nullable
              as int,
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      FOSOFrame: null == FOSOFrame
          ? _value.FOSOFrame
          : FOSOFrame // ignore: cast_nullable_to_non_nullable
              as Option<Either<RemoteFailure, List<Frame>>>,
      FOSOSaveFrame: null == FOSOSaveFrame
          ? _value.FOSOSaveFrame
          : FOSOSaveFrame // ignore: cast_nullable_to_non_nullable
              as Option<Either<LocalFailure, Unit>>,
    ));
  }
}

/// @nodoc

class _$_FrameState implements _FrameState {
  const _$_FrameState(
      {required final List<Frame> frameList,
      required this.selectedId,
      required this.isProcessing,
      required this.FOSOFrame,
      required this.FOSOSaveFrame})
      : _frameList = frameList;

  final List<Frame> _frameList;
  @override
  List<Frame> get frameList {
    if (_frameList is EqualUnmodifiableListView) return _frameList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_frameList);
  }

  @override
  final int selectedId;
  @override
  final bool isProcessing;
  @override
  final Option<Either<RemoteFailure, List<Frame>>> FOSOFrame;
  @override
  final Option<Either<LocalFailure, Unit>> FOSOSaveFrame;

  @override
  String toString() {
    return 'FrameState(frameList: $frameList, selectedId: $selectedId, isProcessing: $isProcessing, FOSOFrame: $FOSOFrame, FOSOSaveFrame: $FOSOSaveFrame)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FrameState &&
            const DeepCollectionEquality()
                .equals(other._frameList, _frameList) &&
            (identical(other.selectedId, selectedId) ||
                other.selectedId == selectedId) &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            (identical(other.FOSOFrame, FOSOFrame) ||
                other.FOSOFrame == FOSOFrame) &&
            (identical(other.FOSOSaveFrame, FOSOSaveFrame) ||
                other.FOSOSaveFrame == FOSOSaveFrame));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_frameList),
      selectedId,
      isProcessing,
      FOSOFrame,
      FOSOSaveFrame);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FrameStateCopyWith<_$_FrameState> get copyWith =>
      __$$_FrameStateCopyWithImpl<_$_FrameState>(this, _$identity);
}

abstract class _FrameState implements FrameState {
  const factory _FrameState(
          {required final List<Frame> frameList,
          required final int selectedId,
          required final bool isProcessing,
          required final Option<Either<RemoteFailure, List<Frame>>> FOSOFrame,
          required final Option<Either<LocalFailure, Unit>> FOSOSaveFrame}) =
      _$_FrameState;

  @override
  List<Frame> get frameList;
  @override
  int get selectedId;
  @override
  bool get isProcessing;
  @override
  Option<Either<RemoteFailure, List<Frame>>> get FOSOFrame;
  @override
  Option<Either<LocalFailure, Unit>> get FOSOSaveFrame;
  @override
  @JsonKey(ignore: true)
  _$$_FrameStateCopyWith<_$_FrameState> get copyWith =>
      throw _privateConstructorUsedError;
}
