// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auto_data_timer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AutoDataTimerState {
  int get durationInSeconds => throw _privateConstructorUsedError;
  bool get isRunning => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AutoDataTimerStateCopyWith<AutoDataTimerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AutoDataTimerStateCopyWith<$Res> {
  factory $AutoDataTimerStateCopyWith(
          AutoDataTimerState value, $Res Function(AutoDataTimerState) then) =
      _$AutoDataTimerStateCopyWithImpl<$Res, AutoDataTimerState>;
  @useResult
  $Res call({int durationInSeconds, bool isRunning});
}

/// @nodoc
class _$AutoDataTimerStateCopyWithImpl<$Res, $Val extends AutoDataTimerState>
    implements $AutoDataTimerStateCopyWith<$Res> {
  _$AutoDataTimerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? durationInSeconds = null,
    Object? isRunning = null,
  }) {
    return _then(_value.copyWith(
      durationInSeconds: null == durationInSeconds
          ? _value.durationInSeconds
          : durationInSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      isRunning: null == isRunning
          ? _value.isRunning
          : isRunning // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AutoDataTimerStateCopyWith<$Res>
    implements $AutoDataTimerStateCopyWith<$Res> {
  factory _$$_AutoDataTimerStateCopyWith(_$_AutoDataTimerState value,
          $Res Function(_$_AutoDataTimerState) then) =
      __$$_AutoDataTimerStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int durationInSeconds, bool isRunning});
}

/// @nodoc
class __$$_AutoDataTimerStateCopyWithImpl<$Res>
    extends _$AutoDataTimerStateCopyWithImpl<$Res, _$_AutoDataTimerState>
    implements _$$_AutoDataTimerStateCopyWith<$Res> {
  __$$_AutoDataTimerStateCopyWithImpl(
      _$_AutoDataTimerState _value, $Res Function(_$_AutoDataTimerState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? durationInSeconds = null,
    Object? isRunning = null,
  }) {
    return _then(_$_AutoDataTimerState(
      durationInSeconds: null == durationInSeconds
          ? _value.durationInSeconds
          : durationInSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      isRunning: null == isRunning
          ? _value.isRunning
          : isRunning // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_AutoDataTimerState
    with DiagnosticableTreeMixin
    implements _AutoDataTimerState {
  const _$_AutoDataTimerState(
      {required this.durationInSeconds, required this.isRunning});

  @override
  final int durationInSeconds;
  @override
  final bool isRunning;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AutoDataTimerState(durationInSeconds: $durationInSeconds, isRunning: $isRunning)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AutoDataTimerState'))
      ..add(DiagnosticsProperty('durationInSeconds', durationInSeconds))
      ..add(DiagnosticsProperty('isRunning', isRunning));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AutoDataTimerState &&
            (identical(other.durationInSeconds, durationInSeconds) ||
                other.durationInSeconds == durationInSeconds) &&
            (identical(other.isRunning, isRunning) ||
                other.isRunning == isRunning));
  }

  @override
  int get hashCode => Object.hash(runtimeType, durationInSeconds, isRunning);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AutoDataTimerStateCopyWith<_$_AutoDataTimerState> get copyWith =>
      __$$_AutoDataTimerStateCopyWithImpl<_$_AutoDataTimerState>(
          this, _$identity);
}

abstract class _AutoDataTimerState implements AutoDataTimerState {
  const factory _AutoDataTimerState(
      {required final int durationInSeconds,
      required final bool isRunning}) = _$_AutoDataTimerState;

  @override
  int get durationInSeconds;
  @override
  bool get isRunning;
  @override
  @JsonKey(ignore: true)
  _$$_AutoDataTimerStateCopyWith<_$_AutoDataTimerState> get copyWith =>
      throw _privateConstructorUsedError;
}
