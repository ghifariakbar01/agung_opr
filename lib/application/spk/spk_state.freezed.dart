// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spk_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SPKState {
  List<SPK> get spkList => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  bool get isProcessing => throw _privateConstructorUsedError;
  Option<Either<RemoteFailure, List<SPK>>> get FOSOSPK =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SPKStateCopyWith<SPKState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SPKStateCopyWith<$Res> {
  factory $SPKStateCopyWith(SPKState value, $Res Function(SPKState) then) =
      _$SPKStateCopyWithImpl<$Res, SPKState>;
  @useResult
  $Res call(
      {List<SPK> spkList,
      int page,
      bool hasMore,
      bool isProcessing,
      Option<Either<RemoteFailure, List<SPK>>> FOSOSPK});
}

/// @nodoc
class _$SPKStateCopyWithImpl<$Res, $Val extends SPKState>
    implements $SPKStateCopyWith<$Res> {
  _$SPKStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? spkList = null,
    Object? page = null,
    Object? hasMore = null,
    Object? isProcessing = null,
    Object? FOSOSPK = null,
  }) {
    return _then(_value.copyWith(
      spkList: null == spkList
          ? _value.spkList
          : spkList // ignore: cast_nullable_to_non_nullable
              as List<SPK>,
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
      FOSOSPK: null == FOSOSPK
          ? _value.FOSOSPK
          : FOSOSPK // ignore: cast_nullable_to_non_nullable
              as Option<Either<RemoteFailure, List<SPK>>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SPKStateCopyWith<$Res> implements $SPKStateCopyWith<$Res> {
  factory _$$_SPKStateCopyWith(
          _$_SPKState value, $Res Function(_$_SPKState) then) =
      __$$_SPKStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<SPK> spkList,
      int page,
      bool hasMore,
      bool isProcessing,
      Option<Either<RemoteFailure, List<SPK>>> FOSOSPK});
}

/// @nodoc
class __$$_SPKStateCopyWithImpl<$Res>
    extends _$SPKStateCopyWithImpl<$Res, _$_SPKState>
    implements _$$_SPKStateCopyWith<$Res> {
  __$$_SPKStateCopyWithImpl(
      _$_SPKState _value, $Res Function(_$_SPKState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? spkList = null,
    Object? page = null,
    Object? hasMore = null,
    Object? isProcessing = null,
    Object? FOSOSPK = null,
  }) {
    return _then(_$_SPKState(
      spkList: null == spkList
          ? _value._spkList
          : spkList // ignore: cast_nullable_to_non_nullable
              as List<SPK>,
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
      FOSOSPK: null == FOSOSPK
          ? _value.FOSOSPK
          : FOSOSPK // ignore: cast_nullable_to_non_nullable
              as Option<Either<RemoteFailure, List<SPK>>>,
    ));
  }
}

/// @nodoc

class _$_SPKState implements _SPKState {
  const _$_SPKState(
      {required final List<SPK> spkList,
      required this.page,
      required this.hasMore,
      required this.isProcessing,
      required this.FOSOSPK})
      : _spkList = spkList;

  final List<SPK> _spkList;
  @override
  List<SPK> get spkList {
    if (_spkList is EqualUnmodifiableListView) return _spkList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_spkList);
  }

  @override
  final int page;
  @override
  final bool hasMore;
  @override
  final bool isProcessing;
  @override
  final Option<Either<RemoteFailure, List<SPK>>> FOSOSPK;

  @override
  String toString() {
    return 'SPKState(spkList: $spkList, page: $page, hasMore: $hasMore, isProcessing: $isProcessing, FOSOSPK: $FOSOSPK)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SPKState &&
            const DeepCollectionEquality().equals(other._spkList, _spkList) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            (identical(other.FOSOSPK, FOSOSPK) || other.FOSOSPK == FOSOSPK));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_spkList),
      page,
      hasMore,
      isProcessing,
      FOSOSPK);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SPKStateCopyWith<_$_SPKState> get copyWith =>
      __$$_SPKStateCopyWithImpl<_$_SPKState>(this, _$identity);
}

abstract class _SPKState implements SPKState {
  const factory _SPKState(
          {required final List<SPK> spkList,
          required final int page,
          required final bool hasMore,
          required final bool isProcessing,
          required final Option<Either<RemoteFailure, List<SPK>>> FOSOSPK}) =
      _$_SPKState;

  @override
  List<SPK> get spkList;
  @override
  int get page;
  @override
  bool get hasMore;
  @override
  bool get isProcessing;
  @override
  Option<Either<RemoteFailure, List<SPK>>> get FOSOSPK;
  @override
  @JsonKey(ignore: true)
  _$$_SPKStateCopyWith<_$_SPKState> get copyWith =>
      throw _privateConstructorUsedError;
}
