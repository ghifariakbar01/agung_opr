// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'supir_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SupirState {
  List<Supir> get supirList => throw _privateConstructorUsedError;
  int get idSelected => throw _privateConstructorUsedError;
  bool get isProcessing => throw _privateConstructorUsedError;
  Option<Either<RemoteFailure, List<Supir>>> get FOSOSupir =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SupirStateCopyWith<SupirState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SupirStateCopyWith<$Res> {
  factory $SupirStateCopyWith(
          SupirState value, $Res Function(SupirState) then) =
      _$SupirStateCopyWithImpl<$Res, SupirState>;
  @useResult
  $Res call(
      {List<Supir> supirList,
      int idSelected,
      bool isProcessing,
      Option<Either<RemoteFailure, List<Supir>>> FOSOSupir});
}

/// @nodoc
class _$SupirStateCopyWithImpl<$Res, $Val extends SupirState>
    implements $SupirStateCopyWith<$Res> {
  _$SupirStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? supirList = null,
    Object? idSelected = null,
    Object? isProcessing = null,
    Object? FOSOSupir = null,
  }) {
    return _then(_value.copyWith(
      supirList: null == supirList
          ? _value.supirList
          : supirList // ignore: cast_nullable_to_non_nullable
              as List<Supir>,
      idSelected: null == idSelected
          ? _value.idSelected
          : idSelected // ignore: cast_nullable_to_non_nullable
              as int,
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      FOSOSupir: null == FOSOSupir
          ? _value.FOSOSupir
          : FOSOSupir // ignore: cast_nullable_to_non_nullable
              as Option<Either<RemoteFailure, List<Supir>>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SupirStateCopyWith<$Res>
    implements $SupirStateCopyWith<$Res> {
  factory _$$_SupirStateCopyWith(
          _$_SupirState value, $Res Function(_$_SupirState) then) =
      __$$_SupirStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Supir> supirList,
      int idSelected,
      bool isProcessing,
      Option<Either<RemoteFailure, List<Supir>>> FOSOSupir});
}

/// @nodoc
class __$$_SupirStateCopyWithImpl<$Res>
    extends _$SupirStateCopyWithImpl<$Res, _$_SupirState>
    implements _$$_SupirStateCopyWith<$Res> {
  __$$_SupirStateCopyWithImpl(
      _$_SupirState _value, $Res Function(_$_SupirState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? supirList = null,
    Object? idSelected = null,
    Object? isProcessing = null,
    Object? FOSOSupir = null,
  }) {
    return _then(_$_SupirState(
      supirList: null == supirList
          ? _value._supirList
          : supirList // ignore: cast_nullable_to_non_nullable
              as List<Supir>,
      idSelected: null == idSelected
          ? _value.idSelected
          : idSelected // ignore: cast_nullable_to_non_nullable
              as int,
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      FOSOSupir: null == FOSOSupir
          ? _value.FOSOSupir
          : FOSOSupir // ignore: cast_nullable_to_non_nullable
              as Option<Either<RemoteFailure, List<Supir>>>,
    ));
  }
}

/// @nodoc

class _$_SupirState implements _SupirState {
  const _$_SupirState(
      {required final List<Supir> supirList,
      required this.idSelected,
      required this.isProcessing,
      required this.FOSOSupir})
      : _supirList = supirList;

  final List<Supir> _supirList;
  @override
  List<Supir> get supirList {
    if (_supirList is EqualUnmodifiableListView) return _supirList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_supirList);
  }

  @override
  final int idSelected;
  @override
  final bool isProcessing;
  @override
  final Option<Either<RemoteFailure, List<Supir>>> FOSOSupir;

  @override
  String toString() {
    return 'SupirState(supirList: $supirList, idSelected: $idSelected, isProcessing: $isProcessing, FOSOSupir: $FOSOSupir)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SupirState &&
            const DeepCollectionEquality()
                .equals(other._supirList, _supirList) &&
            (identical(other.idSelected, idSelected) ||
                other.idSelected == idSelected) &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            (identical(other.FOSOSupir, FOSOSupir) ||
                other.FOSOSupir == FOSOSupir));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_supirList),
      idSelected,
      isProcessing,
      FOSOSupir);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SupirStateCopyWith<_$_SupirState> get copyWith =>
      __$$_SupirStateCopyWithImpl<_$_SupirState>(this, _$identity);
}

abstract class _SupirState implements SupirState {
  const factory _SupirState(
      {required final List<Supir> supirList,
      required final int idSelected,
      required final bool isProcessing,
      required final Option<Either<RemoteFailure, List<Supir>>>
          FOSOSupir}) = _$_SupirState;

  @override
  List<Supir> get supirList;
  @override
  int get idSelected;
  @override
  bool get isProcessing;
  @override
  Option<Either<RemoteFailure, List<Supir>>> get FOSOSupir;
  @override
  @JsonKey(ignore: true)
  _$$_SupirStateCopyWith<_$_SupirState> get copyWith =>
      throw _privateConstructorUsedError;
}
