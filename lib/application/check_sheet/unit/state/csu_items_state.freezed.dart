// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'csu_items_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CSUItemsState {
  bool get isProcessing => throw _privateConstructorUsedError;
  List<CSUItems> get csuItems => throw _privateConstructorUsedError;
  Option<Either<LocalFailure, Unit>> get FOSOUpdateCSU =>
      throw _privateConstructorUsedError;
  Option<Either<RemoteFailure, List<CSUItems>>> get FOSOUpdateCSUItems =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CSUItemsStateCopyWith<CSUItemsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CSUItemsStateCopyWith<$Res> {
  factory $CSUItemsStateCopyWith(
          CSUItemsState value, $Res Function(CSUItemsState) then) =
      _$CSUItemsStateCopyWithImpl<$Res, CSUItemsState>;
  @useResult
  $Res call(
      {bool isProcessing,
      List<CSUItems> csuItems,
      Option<Either<LocalFailure, Unit>> FOSOUpdateCSU,
      Option<Either<RemoteFailure, List<CSUItems>>> FOSOUpdateCSUItems});
}

/// @nodoc
class _$CSUItemsStateCopyWithImpl<$Res, $Val extends CSUItemsState>
    implements $CSUItemsStateCopyWith<$Res> {
  _$CSUItemsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isProcessing = null,
    Object? csuItems = null,
    Object? FOSOUpdateCSU = null,
    Object? FOSOUpdateCSUItems = null,
  }) {
    return _then(_value.copyWith(
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      csuItems: null == csuItems
          ? _value.csuItems
          : csuItems // ignore: cast_nullable_to_non_nullable
              as List<CSUItems>,
      FOSOUpdateCSU: null == FOSOUpdateCSU
          ? _value.FOSOUpdateCSU
          : FOSOUpdateCSU // ignore: cast_nullable_to_non_nullable
              as Option<Either<LocalFailure, Unit>>,
      FOSOUpdateCSUItems: null == FOSOUpdateCSUItems
          ? _value.FOSOUpdateCSUItems
          : FOSOUpdateCSUItems // ignore: cast_nullable_to_non_nullable
              as Option<Either<RemoteFailure, List<CSUItems>>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CSUItemsStateCopyWith<$Res>
    implements $CSUItemsStateCopyWith<$Res> {
  factory _$$_CSUItemsStateCopyWith(
          _$_CSUItemsState value, $Res Function(_$_CSUItemsState) then) =
      __$$_CSUItemsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isProcessing,
      List<CSUItems> csuItems,
      Option<Either<LocalFailure, Unit>> FOSOUpdateCSU,
      Option<Either<RemoteFailure, List<CSUItems>>> FOSOUpdateCSUItems});
}

/// @nodoc
class __$$_CSUItemsStateCopyWithImpl<$Res>
    extends _$CSUItemsStateCopyWithImpl<$Res, _$_CSUItemsState>
    implements _$$_CSUItemsStateCopyWith<$Res> {
  __$$_CSUItemsStateCopyWithImpl(
      _$_CSUItemsState _value, $Res Function(_$_CSUItemsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isProcessing = null,
    Object? csuItems = null,
    Object? FOSOUpdateCSU = null,
    Object? FOSOUpdateCSUItems = null,
  }) {
    return _then(_$_CSUItemsState(
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      csuItems: null == csuItems
          ? _value._csuItems
          : csuItems // ignore: cast_nullable_to_non_nullable
              as List<CSUItems>,
      FOSOUpdateCSU: null == FOSOUpdateCSU
          ? _value.FOSOUpdateCSU
          : FOSOUpdateCSU // ignore: cast_nullable_to_non_nullable
              as Option<Either<LocalFailure, Unit>>,
      FOSOUpdateCSUItems: null == FOSOUpdateCSUItems
          ? _value.FOSOUpdateCSUItems
          : FOSOUpdateCSUItems // ignore: cast_nullable_to_non_nullable
              as Option<Either<RemoteFailure, List<CSUItems>>>,
    ));
  }
}

/// @nodoc

class _$_CSUItemsState implements _CSUItemsState {
  const _$_CSUItemsState(
      {required this.isProcessing,
      required final List<CSUItems> csuItems,
      required this.FOSOUpdateCSU,
      required this.FOSOUpdateCSUItems})
      : _csuItems = csuItems;

  @override
  final bool isProcessing;
  final List<CSUItems> _csuItems;
  @override
  List<CSUItems> get csuItems {
    if (_csuItems is EqualUnmodifiableListView) return _csuItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_csuItems);
  }

  @override
  final Option<Either<LocalFailure, Unit>> FOSOUpdateCSU;
  @override
  final Option<Either<RemoteFailure, List<CSUItems>>> FOSOUpdateCSUItems;

  @override
  String toString() {
    return 'CSUItemsState(isProcessing: $isProcessing, csuItems: $csuItems, FOSOUpdateCSU: $FOSOUpdateCSU, FOSOUpdateCSUItems: $FOSOUpdateCSUItems)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CSUItemsState &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            const DeepCollectionEquality().equals(other._csuItems, _csuItems) &&
            (identical(other.FOSOUpdateCSU, FOSOUpdateCSU) ||
                other.FOSOUpdateCSU == FOSOUpdateCSU) &&
            (identical(other.FOSOUpdateCSUItems, FOSOUpdateCSUItems) ||
                other.FOSOUpdateCSUItems == FOSOUpdateCSUItems));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isProcessing,
      const DeepCollectionEquality().hash(_csuItems),
      FOSOUpdateCSU,
      FOSOUpdateCSUItems);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CSUItemsStateCopyWith<_$_CSUItemsState> get copyWith =>
      __$$_CSUItemsStateCopyWithImpl<_$_CSUItemsState>(this, _$identity);
}

abstract class _CSUItemsState implements CSUItemsState {
  const factory _CSUItemsState(
      {required final bool isProcessing,
      required final List<CSUItems> csuItems,
      required final Option<Either<LocalFailure, Unit>> FOSOUpdateCSU,
      required final Option<Either<RemoteFailure, List<CSUItems>>>
          FOSOUpdateCSUItems}) = _$_CSUItemsState;

  @override
  bool get isProcessing;
  @override
  List<CSUItems> get csuItems;
  @override
  Option<Either<LocalFailure, Unit>> get FOSOUpdateCSU;
  @override
  Option<Either<RemoteFailure, List<CSUItems>>> get FOSOUpdateCSUItems;
  @override
  @JsonKey(ignore: true)
  _$$_CSUItemsStateCopyWith<_$_CSUItemsState> get copyWith =>
      throw _privateConstructorUsedError;
}
