// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_csu_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UpdateCSUState {
  int get idUnit => throw _privateConstructorUsedError;
  bool get isProcessing => throw _privateConstructorUsedError;

  ///
  UpdateCSUFrameStateSingle get updateFrameList =>
      throw _privateConstructorUsedError;
  List<CSUItems> get csuItems => throw _privateConstructorUsedError;
  List<CSUJenisPenyebabItem> get csuJenisItems =>
      throw _privateConstructorUsedError;
  List<CSUJenisPenyebabItem> get csuPenyebabItems =>
      throw _privateConstructorUsedError; //
  Option<Either<LocalFailure, Unit>> get FOSOUpdateCSU =>
      throw _privateConstructorUsedError;
  Option<Either<RemoteFailure, List<CSUItems>>> get FOSOUpdateCSUItems =>
      throw _privateConstructorUsedError;
  Option<Either<RemoteFailure, List<CSUJenisPenyebabItem>>>
      get FOSOUpdateCSUJenisItems => throw _privateConstructorUsedError;
  Option<Either<RemoteFailure, List<CSUJenisPenyebabItem>>>
      get FOSOUpdateCSUPenyebabItems => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UpdateCSUStateCopyWith<UpdateCSUState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateCSUStateCopyWith<$Res> {
  factory $UpdateCSUStateCopyWith(
          UpdateCSUState value, $Res Function(UpdateCSUState) then) =
      _$UpdateCSUStateCopyWithImpl<$Res, UpdateCSUState>;
  @useResult
  $Res call(
      {int idUnit,
      bool isProcessing,
      UpdateCSUFrameStateSingle updateFrameList,
      List<CSUItems> csuItems,
      List<CSUJenisPenyebabItem> csuJenisItems,
      List<CSUJenisPenyebabItem> csuPenyebabItems,
      Option<Either<LocalFailure, Unit>> FOSOUpdateCSU,
      Option<Either<RemoteFailure, List<CSUItems>>> FOSOUpdateCSUItems,
      Option<Either<RemoteFailure, List<CSUJenisPenyebabItem>>>
          FOSOUpdateCSUJenisItems,
      Option<Either<RemoteFailure, List<CSUJenisPenyebabItem>>>
          FOSOUpdateCSUPenyebabItems});

  $UpdateCSUFrameStateSingleCopyWith<$Res> get updateFrameList;
}

/// @nodoc
class _$UpdateCSUStateCopyWithImpl<$Res, $Val extends UpdateCSUState>
    implements $UpdateCSUStateCopyWith<$Res> {
  _$UpdateCSUStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idUnit = null,
    Object? isProcessing = null,
    Object? updateFrameList = null,
    Object? csuItems = null,
    Object? csuJenisItems = null,
    Object? csuPenyebabItems = null,
    Object? FOSOUpdateCSU = null,
    Object? FOSOUpdateCSUItems = null,
    Object? FOSOUpdateCSUJenisItems = null,
    Object? FOSOUpdateCSUPenyebabItems = null,
  }) {
    return _then(_value.copyWith(
      idUnit: null == idUnit
          ? _value.idUnit
          : idUnit // ignore: cast_nullable_to_non_nullable
              as int,
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      updateFrameList: null == updateFrameList
          ? _value.updateFrameList
          : updateFrameList // ignore: cast_nullable_to_non_nullable
              as UpdateCSUFrameStateSingle,
      csuItems: null == csuItems
          ? _value.csuItems
          : csuItems // ignore: cast_nullable_to_non_nullable
              as List<CSUItems>,
      csuJenisItems: null == csuJenisItems
          ? _value.csuJenisItems
          : csuJenisItems // ignore: cast_nullable_to_non_nullable
              as List<CSUJenisPenyebabItem>,
      csuPenyebabItems: null == csuPenyebabItems
          ? _value.csuPenyebabItems
          : csuPenyebabItems // ignore: cast_nullable_to_non_nullable
              as List<CSUJenisPenyebabItem>,
      FOSOUpdateCSU: null == FOSOUpdateCSU
          ? _value.FOSOUpdateCSU
          : FOSOUpdateCSU // ignore: cast_nullable_to_non_nullable
              as Option<Either<LocalFailure, Unit>>,
      FOSOUpdateCSUItems: null == FOSOUpdateCSUItems
          ? _value.FOSOUpdateCSUItems
          : FOSOUpdateCSUItems // ignore: cast_nullable_to_non_nullable
              as Option<Either<RemoteFailure, List<CSUItems>>>,
      FOSOUpdateCSUJenisItems: null == FOSOUpdateCSUJenisItems
          ? _value.FOSOUpdateCSUJenisItems
          : FOSOUpdateCSUJenisItems // ignore: cast_nullable_to_non_nullable
              as Option<Either<RemoteFailure, List<CSUJenisPenyebabItem>>>,
      FOSOUpdateCSUPenyebabItems: null == FOSOUpdateCSUPenyebabItems
          ? _value.FOSOUpdateCSUPenyebabItems
          : FOSOUpdateCSUPenyebabItems // ignore: cast_nullable_to_non_nullable
              as Option<Either<RemoteFailure, List<CSUJenisPenyebabItem>>>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UpdateCSUFrameStateSingleCopyWith<$Res> get updateFrameList {
    return $UpdateCSUFrameStateSingleCopyWith<$Res>(_value.updateFrameList,
        (value) {
      return _then(_value.copyWith(updateFrameList: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_UpdateCSUStateCopyWith<$Res>
    implements $UpdateCSUStateCopyWith<$Res> {
  factory _$$_UpdateCSUStateCopyWith(
          _$_UpdateCSUState value, $Res Function(_$_UpdateCSUState) then) =
      __$$_UpdateCSUStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int idUnit,
      bool isProcessing,
      UpdateCSUFrameStateSingle updateFrameList,
      List<CSUItems> csuItems,
      List<CSUJenisPenyebabItem> csuJenisItems,
      List<CSUJenisPenyebabItem> csuPenyebabItems,
      Option<Either<LocalFailure, Unit>> FOSOUpdateCSU,
      Option<Either<RemoteFailure, List<CSUItems>>> FOSOUpdateCSUItems,
      Option<Either<RemoteFailure, List<CSUJenisPenyebabItem>>>
          FOSOUpdateCSUJenisItems,
      Option<Either<RemoteFailure, List<CSUJenisPenyebabItem>>>
          FOSOUpdateCSUPenyebabItems});

  @override
  $UpdateCSUFrameStateSingleCopyWith<$Res> get updateFrameList;
}

/// @nodoc
class __$$_UpdateCSUStateCopyWithImpl<$Res>
    extends _$UpdateCSUStateCopyWithImpl<$Res, _$_UpdateCSUState>
    implements _$$_UpdateCSUStateCopyWith<$Res> {
  __$$_UpdateCSUStateCopyWithImpl(
      _$_UpdateCSUState _value, $Res Function(_$_UpdateCSUState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idUnit = null,
    Object? isProcessing = null,
    Object? updateFrameList = null,
    Object? csuItems = null,
    Object? csuJenisItems = null,
    Object? csuPenyebabItems = null,
    Object? FOSOUpdateCSU = null,
    Object? FOSOUpdateCSUItems = null,
    Object? FOSOUpdateCSUJenisItems = null,
    Object? FOSOUpdateCSUPenyebabItems = null,
  }) {
    return _then(_$_UpdateCSUState(
      idUnit: null == idUnit
          ? _value.idUnit
          : idUnit // ignore: cast_nullable_to_non_nullable
              as int,
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      updateFrameList: null == updateFrameList
          ? _value.updateFrameList
          : updateFrameList // ignore: cast_nullable_to_non_nullable
              as UpdateCSUFrameStateSingle,
      csuItems: null == csuItems
          ? _value._csuItems
          : csuItems // ignore: cast_nullable_to_non_nullable
              as List<CSUItems>,
      csuJenisItems: null == csuJenisItems
          ? _value._csuJenisItems
          : csuJenisItems // ignore: cast_nullable_to_non_nullable
              as List<CSUJenisPenyebabItem>,
      csuPenyebabItems: null == csuPenyebabItems
          ? _value._csuPenyebabItems
          : csuPenyebabItems // ignore: cast_nullable_to_non_nullable
              as List<CSUJenisPenyebabItem>,
      FOSOUpdateCSU: null == FOSOUpdateCSU
          ? _value.FOSOUpdateCSU
          : FOSOUpdateCSU // ignore: cast_nullable_to_non_nullable
              as Option<Either<LocalFailure, Unit>>,
      FOSOUpdateCSUItems: null == FOSOUpdateCSUItems
          ? _value.FOSOUpdateCSUItems
          : FOSOUpdateCSUItems // ignore: cast_nullable_to_non_nullable
              as Option<Either<RemoteFailure, List<CSUItems>>>,
      FOSOUpdateCSUJenisItems: null == FOSOUpdateCSUJenisItems
          ? _value.FOSOUpdateCSUJenisItems
          : FOSOUpdateCSUJenisItems // ignore: cast_nullable_to_non_nullable
              as Option<Either<RemoteFailure, List<CSUJenisPenyebabItem>>>,
      FOSOUpdateCSUPenyebabItems: null == FOSOUpdateCSUPenyebabItems
          ? _value.FOSOUpdateCSUPenyebabItems
          : FOSOUpdateCSUPenyebabItems // ignore: cast_nullable_to_non_nullable
              as Option<Either<RemoteFailure, List<CSUJenisPenyebabItem>>>,
    ));
  }
}

/// @nodoc

class _$_UpdateCSUState implements _UpdateCSUState {
  const _$_UpdateCSUState(
      {required this.idUnit,
      required this.isProcessing,
      required this.updateFrameList,
      required final List<CSUItems> csuItems,
      required final List<CSUJenisPenyebabItem> csuJenisItems,
      required final List<CSUJenisPenyebabItem> csuPenyebabItems,
      required this.FOSOUpdateCSU,
      required this.FOSOUpdateCSUItems,
      required this.FOSOUpdateCSUJenisItems,
      required this.FOSOUpdateCSUPenyebabItems})
      : _csuItems = csuItems,
        _csuJenisItems = csuJenisItems,
        _csuPenyebabItems = csuPenyebabItems;

  @override
  final int idUnit;
  @override
  final bool isProcessing;

  ///
  @override
  final UpdateCSUFrameStateSingle updateFrameList;
  final List<CSUItems> _csuItems;
  @override
  List<CSUItems> get csuItems {
    if (_csuItems is EqualUnmodifiableListView) return _csuItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_csuItems);
  }

  final List<CSUJenisPenyebabItem> _csuJenisItems;
  @override
  List<CSUJenisPenyebabItem> get csuJenisItems {
    if (_csuJenisItems is EqualUnmodifiableListView) return _csuJenisItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_csuJenisItems);
  }

  final List<CSUJenisPenyebabItem> _csuPenyebabItems;
  @override
  List<CSUJenisPenyebabItem> get csuPenyebabItems {
    if (_csuPenyebabItems is EqualUnmodifiableListView)
      return _csuPenyebabItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_csuPenyebabItems);
  }

//
  @override
  final Option<Either<LocalFailure, Unit>> FOSOUpdateCSU;
  @override
  final Option<Either<RemoteFailure, List<CSUItems>>> FOSOUpdateCSUItems;
  @override
  final Option<Either<RemoteFailure, List<CSUJenisPenyebabItem>>>
      FOSOUpdateCSUJenisItems;
  @override
  final Option<Either<RemoteFailure, List<CSUJenisPenyebabItem>>>
      FOSOUpdateCSUPenyebabItems;

  @override
  String toString() {
    return 'UpdateCSUState(idUnit: $idUnit, isProcessing: $isProcessing, updateFrameList: $updateFrameList, csuItems: $csuItems, csuJenisItems: $csuJenisItems, csuPenyebabItems: $csuPenyebabItems, FOSOUpdateCSU: $FOSOUpdateCSU, FOSOUpdateCSUItems: $FOSOUpdateCSUItems, FOSOUpdateCSUJenisItems: $FOSOUpdateCSUJenisItems, FOSOUpdateCSUPenyebabItems: $FOSOUpdateCSUPenyebabItems)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UpdateCSUState &&
            (identical(other.idUnit, idUnit) || other.idUnit == idUnit) &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            (identical(other.updateFrameList, updateFrameList) ||
                other.updateFrameList == updateFrameList) &&
            const DeepCollectionEquality().equals(other._csuItems, _csuItems) &&
            const DeepCollectionEquality()
                .equals(other._csuJenisItems, _csuJenisItems) &&
            const DeepCollectionEquality()
                .equals(other._csuPenyebabItems, _csuPenyebabItems) &&
            (identical(other.FOSOUpdateCSU, FOSOUpdateCSU) ||
                other.FOSOUpdateCSU == FOSOUpdateCSU) &&
            (identical(other.FOSOUpdateCSUItems, FOSOUpdateCSUItems) ||
                other.FOSOUpdateCSUItems == FOSOUpdateCSUItems) &&
            (identical(
                    other.FOSOUpdateCSUJenisItems, FOSOUpdateCSUJenisItems) ||
                other.FOSOUpdateCSUJenisItems == FOSOUpdateCSUJenisItems) &&
            (identical(other.FOSOUpdateCSUPenyebabItems,
                    FOSOUpdateCSUPenyebabItems) ||
                other.FOSOUpdateCSUPenyebabItems ==
                    FOSOUpdateCSUPenyebabItems));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      idUnit,
      isProcessing,
      updateFrameList,
      const DeepCollectionEquality().hash(_csuItems),
      const DeepCollectionEquality().hash(_csuJenisItems),
      const DeepCollectionEquality().hash(_csuPenyebabItems),
      FOSOUpdateCSU,
      FOSOUpdateCSUItems,
      FOSOUpdateCSUJenisItems,
      FOSOUpdateCSUPenyebabItems);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UpdateCSUStateCopyWith<_$_UpdateCSUState> get copyWith =>
      __$$_UpdateCSUStateCopyWithImpl<_$_UpdateCSUState>(this, _$identity);
}

abstract class _UpdateCSUState implements UpdateCSUState {
  const factory _UpdateCSUState(
      {required final int idUnit,
      required final bool isProcessing,
      required final UpdateCSUFrameStateSingle updateFrameList,
      required final List<CSUItems> csuItems,
      required final List<CSUJenisPenyebabItem> csuJenisItems,
      required final List<CSUJenisPenyebabItem> csuPenyebabItems,
      required final Option<Either<LocalFailure, Unit>> FOSOUpdateCSU,
      required final Option<Either<RemoteFailure, List<CSUItems>>>
          FOSOUpdateCSUItems,
      required final Option<Either<RemoteFailure, List<CSUJenisPenyebabItem>>>
          FOSOUpdateCSUJenisItems,
      required final Option<Either<RemoteFailure, List<CSUJenisPenyebabItem>>>
          FOSOUpdateCSUPenyebabItems}) = _$_UpdateCSUState;

  @override
  int get idUnit;
  @override
  bool get isProcessing;
  @override

  ///
  UpdateCSUFrameStateSingle get updateFrameList;
  @override
  List<CSUItems> get csuItems;
  @override
  List<CSUJenisPenyebabItem> get csuJenisItems;
  @override
  List<CSUJenisPenyebabItem> get csuPenyebabItems;
  @override //
  Option<Either<LocalFailure, Unit>> get FOSOUpdateCSU;
  @override
  Option<Either<RemoteFailure, List<CSUItems>>> get FOSOUpdateCSUItems;
  @override
  Option<Either<RemoteFailure, List<CSUJenisPenyebabItem>>>
      get FOSOUpdateCSUJenisItems;
  @override
  Option<Either<RemoteFailure, List<CSUJenisPenyebabItem>>>
      get FOSOUpdateCSUPenyebabItems;
  @override
  @JsonKey(ignore: true)
  _$$_UpdateCSUStateCopyWith<_$_UpdateCSUState> get copyWith =>
      throw _privateConstructorUsedError;
}
