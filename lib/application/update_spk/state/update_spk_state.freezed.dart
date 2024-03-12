// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_spk_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UpdateSPKState {
  SPK get selectedSPK => throw _privateConstructorUsedError; //
  Keterangan get keterangan => throw _privateConstructorUsedError; //
  bool get isProcessing => throw _privateConstructorUsedError;
  Option<Either<LocalFailure, Unit>> get FOSOUpdateSPK =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UpdateSPKStateCopyWith<UpdateSPKState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateSPKStateCopyWith<$Res> {
  factory $UpdateSPKStateCopyWith(
          UpdateSPKState value, $Res Function(UpdateSPKState) then) =
      _$UpdateSPKStateCopyWithImpl<$Res, UpdateSPKState>;
  @useResult
  $Res call(
      {SPK selectedSPK,
      Keterangan keterangan,
      bool isProcessing,
      Option<Either<LocalFailure, Unit>> FOSOUpdateSPK});

  $SPKCopyWith<$Res> get selectedSPK;
}

/// @nodoc
class _$UpdateSPKStateCopyWithImpl<$Res, $Val extends UpdateSPKState>
    implements $UpdateSPKStateCopyWith<$Res> {
  _$UpdateSPKStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedSPK = null,
    Object? keterangan = null,
    Object? isProcessing = null,
    Object? FOSOUpdateSPK = null,
  }) {
    return _then(_value.copyWith(
      selectedSPK: null == selectedSPK
          ? _value.selectedSPK
          : selectedSPK // ignore: cast_nullable_to_non_nullable
              as SPK,
      keterangan: null == keterangan
          ? _value.keterangan
          : keterangan // ignore: cast_nullable_to_non_nullable
              as Keterangan,
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      FOSOUpdateSPK: null == FOSOUpdateSPK
          ? _value.FOSOUpdateSPK
          : FOSOUpdateSPK // ignore: cast_nullable_to_non_nullable
              as Option<Either<LocalFailure, Unit>>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SPKCopyWith<$Res> get selectedSPK {
    return $SPKCopyWith<$Res>(_value.selectedSPK, (value) {
      return _then(_value.copyWith(selectedSPK: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_UpdateCSStateCopyWith<$Res>
    implements $UpdateSPKStateCopyWith<$Res> {
  factory _$$_UpdateCSStateCopyWith(
          _$_UpdateCSState value, $Res Function(_$_UpdateCSState) then) =
      __$$_UpdateCSStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SPK selectedSPK,
      Keterangan keterangan,
      bool isProcessing,
      Option<Either<LocalFailure, Unit>> FOSOUpdateSPK});

  @override
  $SPKCopyWith<$Res> get selectedSPK;
}

/// @nodoc
class __$$_UpdateCSStateCopyWithImpl<$Res>
    extends _$UpdateSPKStateCopyWithImpl<$Res, _$_UpdateCSState>
    implements _$$_UpdateCSStateCopyWith<$Res> {
  __$$_UpdateCSStateCopyWithImpl(
      _$_UpdateCSState _value, $Res Function(_$_UpdateCSState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedSPK = null,
    Object? keterangan = null,
    Object? isProcessing = null,
    Object? FOSOUpdateSPK = null,
  }) {
    return _then(_$_UpdateCSState(
      selectedSPK: null == selectedSPK
          ? _value.selectedSPK
          : selectedSPK // ignore: cast_nullable_to_non_nullable
              as SPK,
      keterangan: null == keterangan
          ? _value.keterangan
          : keterangan // ignore: cast_nullable_to_non_nullable
              as Keterangan,
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      FOSOUpdateSPK: null == FOSOUpdateSPK
          ? _value.FOSOUpdateSPK
          : FOSOUpdateSPK // ignore: cast_nullable_to_non_nullable
              as Option<Either<LocalFailure, Unit>>,
    ));
  }
}

/// @nodoc

class _$_UpdateCSState implements _UpdateCSState {
  const _$_UpdateCSState(
      {required this.selectedSPK,
      required this.keterangan,
      required this.isProcessing,
      required this.FOSOUpdateSPK});

  @override
  final SPK selectedSPK;
//
  @override
  final Keterangan keterangan;
//
  @override
  final bool isProcessing;
  @override
  final Option<Either<LocalFailure, Unit>> FOSOUpdateSPK;

  @override
  String toString() {
    return 'UpdateSPKState(selectedSPK: $selectedSPK, keterangan: $keterangan, isProcessing: $isProcessing, FOSOUpdateSPK: $FOSOUpdateSPK)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UpdateCSState &&
            (identical(other.selectedSPK, selectedSPK) ||
                other.selectedSPK == selectedSPK) &&
            (identical(other.keterangan, keterangan) ||
                other.keterangan == keterangan) &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            (identical(other.FOSOUpdateSPK, FOSOUpdateSPK) ||
                other.FOSOUpdateSPK == FOSOUpdateSPK));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, selectedSPK, keterangan, isProcessing, FOSOUpdateSPK);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UpdateCSStateCopyWith<_$_UpdateCSState> get copyWith =>
      __$$_UpdateCSStateCopyWithImpl<_$_UpdateCSState>(this, _$identity);
}

abstract class _UpdateCSState implements UpdateSPKState {
  const factory _UpdateCSState(
          {required final SPK selectedSPK,
          required final Keterangan keterangan,
          required final bool isProcessing,
          required final Option<Either<LocalFailure, Unit>> FOSOUpdateSPK}) =
      _$_UpdateCSState;

  @override
  SPK get selectedSPK;
  @override //
  Keterangan get keterangan;
  @override //
  bool get isProcessing;
  @override
  Option<Either<LocalFailure, Unit>> get FOSOUpdateSPK;
  @override
  @JsonKey(ignore: true)
  _$$_UpdateCSStateCopyWith<_$_UpdateCSState> get copyWith =>
      throw _privateConstructorUsedError;
}
