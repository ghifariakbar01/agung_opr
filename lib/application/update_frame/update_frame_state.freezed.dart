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
  List<UpdateFrameStateSingle> get updateFrameList =>
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
  $Res call({List<UpdateFrameStateSingle> updateFrameList});
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
    Object? updateFrameList = null,
  }) {
    return _then(_value.copyWith(
      updateFrameList: null == updateFrameList
          ? _value.updateFrameList
          : updateFrameList // ignore: cast_nullable_to_non_nullable
              as List<UpdateFrameStateSingle>,
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
  $Res call({List<UpdateFrameStateSingle> updateFrameList});
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
    Object? updateFrameList = null,
  }) {
    return _then(_$_UpdateFrameState(
      updateFrameList: null == updateFrameList
          ? _value._updateFrameList
          : updateFrameList // ignore: cast_nullable_to_non_nullable
              as List<UpdateFrameStateSingle>,
    ));
  }
}

/// @nodoc

class _$_UpdateFrameState implements _UpdateFrameState {
  const _$_UpdateFrameState(
      {required final List<UpdateFrameStateSingle> updateFrameList})
      : _updateFrameList = updateFrameList;

  final List<UpdateFrameStateSingle> _updateFrameList;
  @override
  List<UpdateFrameStateSingle> get updateFrameList {
    if (_updateFrameList is EqualUnmodifiableListView) return _updateFrameList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_updateFrameList);
  }

  @override
  String toString() {
    return 'UpdateFrameState(updateFrameList: $updateFrameList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UpdateFrameState &&
            const DeepCollectionEquality()
                .equals(other._updateFrameList, _updateFrameList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_updateFrameList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UpdateFrameStateCopyWith<_$_UpdateFrameState> get copyWith =>
      __$$_UpdateFrameStateCopyWithImpl<_$_UpdateFrameState>(this, _$identity);
}

abstract class _UpdateFrameState implements UpdateFrameState {
  const factory _UpdateFrameState(
          {required final List<UpdateFrameStateSingle> updateFrameList}) =
      _$_UpdateFrameState;

  @override
  List<UpdateFrameStateSingle> get updateFrameList;
  @override
  @JsonKey(ignore: true)
  _$$_UpdateFrameStateCopyWith<_$_UpdateFrameState> get copyWith =>
      throw _privateConstructorUsedError;
}
