// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cs_item_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CSItemState {
  List<CSItem> get csItemList => throw _privateConstructorUsedError;
  Map<int, List<CSItem>> get csItemListByID =>
      throw _privateConstructorUsedError;
  int get selectedId => throw _privateConstructorUsedError;
  bool get isProcessing => throw _privateConstructorUsedError;
  Option<Either<RemoteFailure, List<CSItem>>> get FOSOCSItem =>
      throw _privateConstructorUsedError;
  Option<Either<LocalFailure, Unit>> get FOSOSaveCSItem =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CSItemStateCopyWith<CSItemState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CSItemStateCopyWith<$Res> {
  factory $CSItemStateCopyWith(
          CSItemState value, $Res Function(CSItemState) then) =
      _$CSItemStateCopyWithImpl<$Res, CSItemState>;
  @useResult
  $Res call(
      {List<CSItem> csItemList,
      Map<int, List<CSItem>> csItemListByID,
      int selectedId,
      bool isProcessing,
      Option<Either<RemoteFailure, List<CSItem>>> FOSOCSItem,
      Option<Either<LocalFailure, Unit>> FOSOSaveCSItem});
}

/// @nodoc
class _$CSItemStateCopyWithImpl<$Res, $Val extends CSItemState>
    implements $CSItemStateCopyWith<$Res> {
  _$CSItemStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? csItemList = null,
    Object? csItemListByID = null,
    Object? selectedId = null,
    Object? isProcessing = null,
    Object? FOSOCSItem = null,
    Object? FOSOSaveCSItem = null,
  }) {
    return _then(_value.copyWith(
      csItemList: null == csItemList
          ? _value.csItemList
          : csItemList // ignore: cast_nullable_to_non_nullable
              as List<CSItem>,
      csItemListByID: null == csItemListByID
          ? _value.csItemListByID
          : csItemListByID // ignore: cast_nullable_to_non_nullable
              as Map<int, List<CSItem>>,
      selectedId: null == selectedId
          ? _value.selectedId
          : selectedId // ignore: cast_nullable_to_non_nullable
              as int,
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      FOSOCSItem: null == FOSOCSItem
          ? _value.FOSOCSItem
          : FOSOCSItem // ignore: cast_nullable_to_non_nullable
              as Option<Either<RemoteFailure, List<CSItem>>>,
      FOSOSaveCSItem: null == FOSOSaveCSItem
          ? _value.FOSOSaveCSItem
          : FOSOSaveCSItem // ignore: cast_nullable_to_non_nullable
              as Option<Either<LocalFailure, Unit>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CSItemStateCopyWith<$Res>
    implements $CSItemStateCopyWith<$Res> {
  factory _$$_CSItemStateCopyWith(
          _$_CSItemState value, $Res Function(_$_CSItemState) then) =
      __$$_CSItemStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<CSItem> csItemList,
      Map<int, List<CSItem>> csItemListByID,
      int selectedId,
      bool isProcessing,
      Option<Either<RemoteFailure, List<CSItem>>> FOSOCSItem,
      Option<Either<LocalFailure, Unit>> FOSOSaveCSItem});
}

/// @nodoc
class __$$_CSItemStateCopyWithImpl<$Res>
    extends _$CSItemStateCopyWithImpl<$Res, _$_CSItemState>
    implements _$$_CSItemStateCopyWith<$Res> {
  __$$_CSItemStateCopyWithImpl(
      _$_CSItemState _value, $Res Function(_$_CSItemState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? csItemList = null,
    Object? csItemListByID = null,
    Object? selectedId = null,
    Object? isProcessing = null,
    Object? FOSOCSItem = null,
    Object? FOSOSaveCSItem = null,
  }) {
    return _then(_$_CSItemState(
      csItemList: null == csItemList
          ? _value._csItemList
          : csItemList // ignore: cast_nullable_to_non_nullable
              as List<CSItem>,
      csItemListByID: null == csItemListByID
          ? _value._csItemListByID
          : csItemListByID // ignore: cast_nullable_to_non_nullable
              as Map<int, List<CSItem>>,
      selectedId: null == selectedId
          ? _value.selectedId
          : selectedId // ignore: cast_nullable_to_non_nullable
              as int,
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      FOSOCSItem: null == FOSOCSItem
          ? _value.FOSOCSItem
          : FOSOCSItem // ignore: cast_nullable_to_non_nullable
              as Option<Either<RemoteFailure, List<CSItem>>>,
      FOSOSaveCSItem: null == FOSOSaveCSItem
          ? _value.FOSOSaveCSItem
          : FOSOSaveCSItem // ignore: cast_nullable_to_non_nullable
              as Option<Either<LocalFailure, Unit>>,
    ));
  }
}

/// @nodoc

class _$_CSItemState implements _CSItemState {
  const _$_CSItemState(
      {required final List<CSItem> csItemList,
      required final Map<int, List<CSItem>> csItemListByID,
      required this.selectedId,
      required this.isProcessing,
      required this.FOSOCSItem,
      required this.FOSOSaveCSItem})
      : _csItemList = csItemList,
        _csItemListByID = csItemListByID;

  final List<CSItem> _csItemList;
  @override
  List<CSItem> get csItemList {
    if (_csItemList is EqualUnmodifiableListView) return _csItemList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_csItemList);
  }

  final Map<int, List<CSItem>> _csItemListByID;
  @override
  Map<int, List<CSItem>> get csItemListByID {
    if (_csItemListByID is EqualUnmodifiableMapView) return _csItemListByID;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_csItemListByID);
  }

  @override
  final int selectedId;
  @override
  final bool isProcessing;
  @override
  final Option<Either<RemoteFailure, List<CSItem>>> FOSOCSItem;
  @override
  final Option<Either<LocalFailure, Unit>> FOSOSaveCSItem;

  @override
  String toString() {
    return 'CSItemState(csItemList: $csItemList, csItemListByID: $csItemListByID, selectedId: $selectedId, isProcessing: $isProcessing, FOSOCSItem: $FOSOCSItem, FOSOSaveCSItem: $FOSOSaveCSItem)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CSItemState &&
            const DeepCollectionEquality()
                .equals(other._csItemList, _csItemList) &&
            const DeepCollectionEquality()
                .equals(other._csItemListByID, _csItemListByID) &&
            (identical(other.selectedId, selectedId) ||
                other.selectedId == selectedId) &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            (identical(other.FOSOCSItem, FOSOCSItem) ||
                other.FOSOCSItem == FOSOCSItem) &&
            (identical(other.FOSOSaveCSItem, FOSOSaveCSItem) ||
                other.FOSOSaveCSItem == FOSOSaveCSItem));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_csItemList),
      const DeepCollectionEquality().hash(_csItemListByID),
      selectedId,
      isProcessing,
      FOSOCSItem,
      FOSOSaveCSItem);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CSItemStateCopyWith<_$_CSItemState> get copyWith =>
      __$$_CSItemStateCopyWithImpl<_$_CSItemState>(this, _$identity);
}

abstract class _CSItemState implements CSItemState {
  const factory _CSItemState(
          {required final List<CSItem> csItemList,
          required final Map<int, List<CSItem>> csItemListByID,
          required final int selectedId,
          required final bool isProcessing,
          required final Option<Either<RemoteFailure, List<CSItem>>> FOSOCSItem,
          required final Option<Either<LocalFailure, Unit>> FOSOSaveCSItem}) =
      _$_CSItemState;

  @override
  List<CSItem> get csItemList;
  @override
  Map<int, List<CSItem>> get csItemListByID;
  @override
  int get selectedId;
  @override
  bool get isProcessing;
  @override
  Option<Either<RemoteFailure, List<CSItem>>> get FOSOCSItem;
  @override
  Option<Either<LocalFailure, Unit>> get FOSOSaveCSItem;
  @override
  @JsonKey(ignore: true)
  _$$_CSItemStateCopyWith<_$_CSItemState> get copyWith =>
      throw _privateConstructorUsedError;
}
