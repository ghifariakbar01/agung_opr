// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HistoryState {
  bool get isGetting => throw _privateConstructorUsedError;
  History get history => throw _privateConstructorUsedError;
  Option<Either<RemoteFailure, History?>> get FOSOHistory =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HistoryStateCopyWith<HistoryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryStateCopyWith<$Res> {
  factory $HistoryStateCopyWith(
          HistoryState value, $Res Function(HistoryState) then) =
      _$HistoryStateCopyWithImpl<$Res, HistoryState>;
  @useResult
  $Res call(
      {bool isGetting,
      History history,
      Option<Either<RemoteFailure, History?>> FOSOHistory});

  $HistoryCopyWith<$Res> get history;
}

/// @nodoc
class _$HistoryStateCopyWithImpl<$Res, $Val extends HistoryState>
    implements $HistoryStateCopyWith<$Res> {
  _$HistoryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isGetting = null,
    Object? history = null,
    Object? FOSOHistory = null,
  }) {
    return _then(_value.copyWith(
      isGetting: null == isGetting
          ? _value.isGetting
          : isGetting // ignore: cast_nullable_to_non_nullable
              as bool,
      history: null == history
          ? _value.history
          : history // ignore: cast_nullable_to_non_nullable
              as History,
      FOSOHistory: null == FOSOHistory
          ? _value.FOSOHistory
          : FOSOHistory // ignore: cast_nullable_to_non_nullable
              as Option<Either<RemoteFailure, History?>>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $HistoryCopyWith<$Res> get history {
    return $HistoryCopyWith<$Res>(_value.history, (value) {
      return _then(_value.copyWith(history: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_UserStateCopyWith<$Res>
    implements $HistoryStateCopyWith<$Res> {
  factory _$$_UserStateCopyWith(
          _$_UserState value, $Res Function(_$_UserState) then) =
      __$$_UserStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isGetting,
      History history,
      Option<Either<RemoteFailure, History?>> FOSOHistory});

  @override
  $HistoryCopyWith<$Res> get history;
}

/// @nodoc
class __$$_UserStateCopyWithImpl<$Res>
    extends _$HistoryStateCopyWithImpl<$Res, _$_UserState>
    implements _$$_UserStateCopyWith<$Res> {
  __$$_UserStateCopyWithImpl(
      _$_UserState _value, $Res Function(_$_UserState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isGetting = null,
    Object? history = null,
    Object? FOSOHistory = null,
  }) {
    return _then(_$_UserState(
      isGetting: null == isGetting
          ? _value.isGetting
          : isGetting // ignore: cast_nullable_to_non_nullable
              as bool,
      history: null == history
          ? _value.history
          : history // ignore: cast_nullable_to_non_nullable
              as History,
      FOSOHistory: null == FOSOHistory
          ? _value.FOSOHistory
          : FOSOHistory // ignore: cast_nullable_to_non_nullable
              as Option<Either<RemoteFailure, History?>>,
    ));
  }
}

/// @nodoc

class _$_UserState implements _UserState {
  const _$_UserState(
      {required this.isGetting,
      required this.history,
      required this.FOSOHistory});

  @override
  final bool isGetting;
  @override
  final History history;
  @override
  final Option<Either<RemoteFailure, History?>> FOSOHistory;

  @override
  String toString() {
    return 'HistoryState(isGetting: $isGetting, history: $history, FOSOHistory: $FOSOHistory)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserState &&
            (identical(other.isGetting, isGetting) ||
                other.isGetting == isGetting) &&
            (identical(other.history, history) || other.history == history) &&
            (identical(other.FOSOHistory, FOSOHistory) ||
                other.FOSOHistory == FOSOHistory));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isGetting, history, FOSOHistory);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserStateCopyWith<_$_UserState> get copyWith =>
      __$$_UserStateCopyWithImpl<_$_UserState>(this, _$identity);
}

abstract class _UserState implements HistoryState {
  const factory _UserState(
          {required final bool isGetting,
          required final History history,
          required final Option<Either<RemoteFailure, History?>> FOSOHistory}) =
      _$_UserState;

  @override
  bool get isGetting;
  @override
  History get history;
  @override
  Option<Either<RemoteFailure, History?>> get FOSOHistory;
  @override
  @JsonKey(ignore: true)
  _$$_UserStateCopyWith<_$_UserState> get copyWith =>
      throw _privateConstructorUsedError;
}
