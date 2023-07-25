// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ModelState {
  List<Model> get modelList => throw _privateConstructorUsedError;
  int get idSelected => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  bool get isProcessing => throw _privateConstructorUsedError;
  Option<Either<RemoteFailure, List<Model>>> get FOSOModel =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ModelStateCopyWith<ModelState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModelStateCopyWith<$Res> {
  factory $ModelStateCopyWith(
          ModelState value, $Res Function(ModelState) then) =
      _$ModelStateCopyWithImpl<$Res, ModelState>;
  @useResult
  $Res call(
      {List<Model> modelList,
      int idSelected,
      int page,
      bool hasMore,
      bool isProcessing,
      Option<Either<RemoteFailure, List<Model>>> FOSOModel});
}

/// @nodoc
class _$ModelStateCopyWithImpl<$Res, $Val extends ModelState>
    implements $ModelStateCopyWith<$Res> {
  _$ModelStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modelList = null,
    Object? idSelected = null,
    Object? page = null,
    Object? hasMore = null,
    Object? isProcessing = null,
    Object? FOSOModel = null,
  }) {
    return _then(_value.copyWith(
      modelList: null == modelList
          ? _value.modelList
          : modelList // ignore: cast_nullable_to_non_nullable
              as List<Model>,
      idSelected: null == idSelected
          ? _value.idSelected
          : idSelected // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      FOSOModel: null == FOSOModel
          ? _value.FOSOModel
          : FOSOModel // ignore: cast_nullable_to_non_nullable
              as Option<Either<RemoteFailure, List<Model>>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ModelStateCopyWith<$Res>
    implements $ModelStateCopyWith<$Res> {
  factory _$$_ModelStateCopyWith(
          _$_ModelState value, $Res Function(_$_ModelState) then) =
      __$$_ModelStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Model> modelList,
      int idSelected,
      int page,
      bool hasMore,
      bool isProcessing,
      Option<Either<RemoteFailure, List<Model>>> FOSOModel});
}

/// @nodoc
class __$$_ModelStateCopyWithImpl<$Res>
    extends _$ModelStateCopyWithImpl<$Res, _$_ModelState>
    implements _$$_ModelStateCopyWith<$Res> {
  __$$_ModelStateCopyWithImpl(
      _$_ModelState _value, $Res Function(_$_ModelState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modelList = null,
    Object? idSelected = null,
    Object? page = null,
    Object? hasMore = null,
    Object? isProcessing = null,
    Object? FOSOModel = null,
  }) {
    return _then(_$_ModelState(
      modelList: null == modelList
          ? _value._modelList
          : modelList // ignore: cast_nullable_to_non_nullable
              as List<Model>,
      idSelected: null == idSelected
          ? _value.idSelected
          : idSelected // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      FOSOModel: null == FOSOModel
          ? _value.FOSOModel
          : FOSOModel // ignore: cast_nullable_to_non_nullable
              as Option<Either<RemoteFailure, List<Model>>>,
    ));
  }
}

/// @nodoc

class _$_ModelState implements _ModelState {
  const _$_ModelState(
      {required final List<Model> modelList,
      required this.idSelected,
      required this.page,
      required this.hasMore,
      required this.isProcessing,
      required this.FOSOModel})
      : _modelList = modelList;

  final List<Model> _modelList;
  @override
  List<Model> get modelList {
    if (_modelList is EqualUnmodifiableListView) return _modelList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_modelList);
  }

  @override
  final int idSelected;
  @override
  final int page;
  @override
  final bool hasMore;
  @override
  final bool isProcessing;
  @override
  final Option<Either<RemoteFailure, List<Model>>> FOSOModel;

  @override
  String toString() {
    return 'ModelState(modelList: $modelList, idSelected: $idSelected, page: $page, hasMore: $hasMore, isProcessing: $isProcessing, FOSOModel: $FOSOModel)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ModelState &&
            const DeepCollectionEquality()
                .equals(other._modelList, _modelList) &&
            (identical(other.idSelected, idSelected) ||
                other.idSelected == idSelected) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            (identical(other.FOSOModel, FOSOModel) ||
                other.FOSOModel == FOSOModel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_modelList),
      idSelected,
      page,
      hasMore,
      isProcessing,
      FOSOModel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ModelStateCopyWith<_$_ModelState> get copyWith =>
      __$$_ModelStateCopyWithImpl<_$_ModelState>(this, _$identity);
}

abstract class _ModelState implements ModelState {
  const factory _ModelState(
      {required final List<Model> modelList,
      required final int idSelected,
      required final int page,
      required final bool hasMore,
      required final bool isProcessing,
      required final Option<Either<RemoteFailure, List<Model>>>
          FOSOModel}) = _$_ModelState;

  @override
  List<Model> get modelList;
  @override
  int get idSelected;
  @override
  int get page;
  @override
  bool get hasMore;
  @override
  bool get isProcessing;
  @override
  Option<Either<RemoteFailure, List<Model>>> get FOSOModel;
  @override
  @JsonKey(ignore: true)
  _$$_ModelStateCopyWith<_$_ModelState> get copyWith =>
      throw _privateConstructorUsedError;
}
