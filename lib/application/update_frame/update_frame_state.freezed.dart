// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_frame_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UpdateFrameState {
  int get idSPK => throw _privateConstructorUsedError;
  bool get isProcessing => throw _privateConstructorUsedError;
  List<bool> get showErrorMessages => throw _privateConstructorUsedError;

  /// Hack for model value to change after tapping model
  List<TextEditingController> get modelTextController =>
      throw _privateConstructorUsedError;
  List<UpdateFrameStateSingle> get updateFrameList =>
      throw _privateConstructorUsedError;
  Option<Either<LocalFailure, Unit>> get FOSOUpdateFrame =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UpdateFrameStateCopyWith<UpdateFrameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateFrameStateCopyWith<$Res> {
  factory $UpdateFrameStateCopyWith(
          UpdateFrameState value, $Res Function(UpdateFrameState) then) =
      _$UpdateFrameStateCopyWithImpl<$Res, UpdateFrameState>;
  @useResult
  $Res call(
      {int idSPK,
      bool isProcessing,
      List<bool> showErrorMessages,
      List<TextEditingController> modelTextController,
      List<UpdateFrameStateSingle> updateFrameList,
      Option<Either<LocalFailure, Unit>> FOSOUpdateFrame});
}

/// @nodoc
class _$UpdateFrameStateCopyWithImpl<$Res, $Val extends UpdateFrameState>
    implements $UpdateFrameStateCopyWith<$Res> {
  _$UpdateFrameStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idSPK = null,
    Object? isProcessing = null,
    Object? showErrorMessages = null,
    Object? modelTextController = null,
    Object? updateFrameList = null,
    Object? FOSOUpdateFrame = null,
  }) {
    return _then(_value.copyWith(
      idSPK: null == idSPK
          ? _value.idSPK
          : idSPK // ignore: cast_nullable_to_non_nullable
              as int,
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      showErrorMessages: null == showErrorMessages
          ? _value.showErrorMessages
          : showErrorMessages // ignore: cast_nullable_to_non_nullable
              as List<bool>,
      modelTextController: null == modelTextController
          ? _value.modelTextController
          : modelTextController // ignore: cast_nullable_to_non_nullable
              as List<TextEditingController>,
      updateFrameList: null == updateFrameList
          ? _value.updateFrameList
          : updateFrameList // ignore: cast_nullable_to_non_nullable
              as List<UpdateFrameStateSingle>,
      FOSOUpdateFrame: null == FOSOUpdateFrame
          ? _value.FOSOUpdateFrame
          : FOSOUpdateFrame // ignore: cast_nullable_to_non_nullable
              as Option<Either<LocalFailure, Unit>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UpdateFrameStateCopyWith<$Res>
    implements $UpdateFrameStateCopyWith<$Res> {
  factory _$$_UpdateFrameStateCopyWith(
          _$_UpdateFrameState value, $Res Function(_$_UpdateFrameState) then) =
      __$$_UpdateFrameStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int idSPK,
      bool isProcessing,
      List<bool> showErrorMessages,
      List<TextEditingController> modelTextController,
      List<UpdateFrameStateSingle> updateFrameList,
      Option<Either<LocalFailure, Unit>> FOSOUpdateFrame});
}

/// @nodoc
class __$$_UpdateFrameStateCopyWithImpl<$Res>
    extends _$UpdateFrameStateCopyWithImpl<$Res, _$_UpdateFrameState>
    implements _$$_UpdateFrameStateCopyWith<$Res> {
  __$$_UpdateFrameStateCopyWithImpl(
      _$_UpdateFrameState _value, $Res Function(_$_UpdateFrameState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idSPK = null,
    Object? isProcessing = null,
    Object? showErrorMessages = null,
    Object? modelTextController = null,
    Object? updateFrameList = null,
    Object? FOSOUpdateFrame = null,
  }) {
    return _then(_$_UpdateFrameState(
      idSPK: null == idSPK
          ? _value.idSPK
          : idSPK // ignore: cast_nullable_to_non_nullable
              as int,
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      showErrorMessages: null == showErrorMessages
          ? _value._showErrorMessages
          : showErrorMessages // ignore: cast_nullable_to_non_nullable
              as List<bool>,
      modelTextController: null == modelTextController
          ? _value._modelTextController
          : modelTextController // ignore: cast_nullable_to_non_nullable
              as List<TextEditingController>,
      updateFrameList: null == updateFrameList
          ? _value._updateFrameList
          : updateFrameList // ignore: cast_nullable_to_non_nullable
              as List<UpdateFrameStateSingle>,
      FOSOUpdateFrame: null == FOSOUpdateFrame
          ? _value.FOSOUpdateFrame
          : FOSOUpdateFrame // ignore: cast_nullable_to_non_nullable
              as Option<Either<LocalFailure, Unit>>,
    ));
  }
}

/// @nodoc

class _$_UpdateFrameState implements _UpdateFrameState {
  const _$_UpdateFrameState(
      {required this.idSPK,
      required this.isProcessing,
      required final List<bool> showErrorMessages,
      required final List<TextEditingController> modelTextController,
      required final List<UpdateFrameStateSingle> updateFrameList,
      required this.FOSOUpdateFrame})
      : _showErrorMessages = showErrorMessages,
        _modelTextController = modelTextController,
        _updateFrameList = updateFrameList;

  @override
  final int idSPK;
  @override
  final bool isProcessing;
  final List<bool> _showErrorMessages;
  @override
  List<bool> get showErrorMessages {
    if (_showErrorMessages is EqualUnmodifiableListView)
      return _showErrorMessages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_showErrorMessages);
  }

  /// Hack for model value to change after tapping model
  final List<TextEditingController> _modelTextController;

  /// Hack for model value to change after tapping model
  @override
  List<TextEditingController> get modelTextController {
    if (_modelTextController is EqualUnmodifiableListView)
      return _modelTextController;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_modelTextController);
  }

  final List<UpdateFrameStateSingle> _updateFrameList;
  @override
  List<UpdateFrameStateSingle> get updateFrameList {
    if (_updateFrameList is EqualUnmodifiableListView) return _updateFrameList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_updateFrameList);
  }

  @override
  final Option<Either<LocalFailure, Unit>> FOSOUpdateFrame;

  @override
  String toString() {
    return 'UpdateFrameState(idSPK: $idSPK, isProcessing: $isProcessing, showErrorMessages: $showErrorMessages, modelTextController: $modelTextController, updateFrameList: $updateFrameList, FOSOUpdateFrame: $FOSOUpdateFrame)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UpdateFrameState &&
            (identical(other.idSPK, idSPK) || other.idSPK == idSPK) &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            const DeepCollectionEquality()
                .equals(other._showErrorMessages, _showErrorMessages) &&
            const DeepCollectionEquality()
                .equals(other._modelTextController, _modelTextController) &&
            const DeepCollectionEquality()
                .equals(other._updateFrameList, _updateFrameList) &&
            (identical(other.FOSOUpdateFrame, FOSOUpdateFrame) ||
                other.FOSOUpdateFrame == FOSOUpdateFrame));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      idSPK,
      isProcessing,
      const DeepCollectionEquality().hash(_showErrorMessages),
      const DeepCollectionEquality().hash(_modelTextController),
      const DeepCollectionEquality().hash(_updateFrameList),
      FOSOUpdateFrame);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UpdateFrameStateCopyWith<_$_UpdateFrameState> get copyWith =>
      __$$_UpdateFrameStateCopyWithImpl<_$_UpdateFrameState>(this, _$identity);
}

abstract class _UpdateFrameState implements UpdateFrameState {
  const factory _UpdateFrameState(
          {required final int idSPK,
          required final bool isProcessing,
          required final List<bool> showErrorMessages,
          required final List<TextEditingController> modelTextController,
          required final List<UpdateFrameStateSingle> updateFrameList,
          required final Option<Either<LocalFailure, Unit>> FOSOUpdateFrame}) =
      _$_UpdateFrameState;

  @override
  int get idSPK;
  @override
  bool get isProcessing;
  @override
  List<bool> get showErrorMessages;
  @override

  /// Hack for model value to change after tapping model
  List<TextEditingController> get modelTextController;
  @override
  List<UpdateFrameStateSingle> get updateFrameList;
  @override
  Option<Either<LocalFailure, Unit>> get FOSOUpdateFrame;
  @override
  @JsonKey(ignore: true)
  _$$_UpdateFrameStateCopyWith<_$_UpdateFrameState> get copyWith =>
      throw _privateConstructorUsedError;
}
