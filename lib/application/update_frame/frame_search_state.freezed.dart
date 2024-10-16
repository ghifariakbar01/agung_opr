// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'frame_search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FrameSearchState {
  bool get isSearching => throw _privateConstructorUsedError;
  String get searchText => throw _privateConstructorUsedError;
  FocusNode get focusNode => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FrameSearchStateCopyWith<FrameSearchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FrameSearchStateCopyWith<$Res> {
  factory $FrameSearchStateCopyWith(
          FrameSearchState value, $Res Function(FrameSearchState) then) =
      _$FrameSearchStateCopyWithImpl<$Res, FrameSearchState>;
  @useResult
  $Res call({bool isSearching, String searchText, FocusNode focusNode});
}

/// @nodoc
class _$FrameSearchStateCopyWithImpl<$Res, $Val extends FrameSearchState>
    implements $FrameSearchStateCopyWith<$Res> {
  _$FrameSearchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSearching = null,
    Object? searchText = null,
    Object? focusNode = null,
  }) {
    return _then(_value.copyWith(
      isSearching: null == isSearching
          ? _value.isSearching
          : isSearching // ignore: cast_nullable_to_non_nullable
              as bool,
      searchText: null == searchText
          ? _value.searchText
          : searchText // ignore: cast_nullable_to_non_nullable
              as String,
      focusNode: null == focusNode
          ? _value.focusNode
          : focusNode // ignore: cast_nullable_to_non_nullable
              as FocusNode,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SPKSearchStateCopyWith<$Res>
    implements $FrameSearchStateCopyWith<$Res> {
  factory _$$_SPKSearchStateCopyWith(
          _$_SPKSearchState value, $Res Function(_$_SPKSearchState) then) =
      __$$_SPKSearchStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isSearching, String searchText, FocusNode focusNode});
}

/// @nodoc
class __$$_SPKSearchStateCopyWithImpl<$Res>
    extends _$FrameSearchStateCopyWithImpl<$Res, _$_SPKSearchState>
    implements _$$_SPKSearchStateCopyWith<$Res> {
  __$$_SPKSearchStateCopyWithImpl(
      _$_SPKSearchState _value, $Res Function(_$_SPKSearchState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSearching = null,
    Object? searchText = null,
    Object? focusNode = null,
  }) {
    return _then(_$_SPKSearchState(
      isSearching: null == isSearching
          ? _value.isSearching
          : isSearching // ignore: cast_nullable_to_non_nullable
              as bool,
      searchText: null == searchText
          ? _value.searchText
          : searchText // ignore: cast_nullable_to_non_nullable
              as String,
      focusNode: null == focusNode
          ? _value.focusNode
          : focusNode // ignore: cast_nullable_to_non_nullable
              as FocusNode,
    ));
  }
}

/// @nodoc

class _$_SPKSearchState implements _SPKSearchState {
  const _$_SPKSearchState(
      {required this.isSearching,
      required this.searchText,
      required this.focusNode});

  @override
  final bool isSearching;
  @override
  final String searchText;
  @override
  final FocusNode focusNode;

  @override
  String toString() {
    return 'FrameSearchState(isSearching: $isSearching, searchText: $searchText, focusNode: $focusNode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SPKSearchState &&
            (identical(other.isSearching, isSearching) ||
                other.isSearching == isSearching) &&
            (identical(other.searchText, searchText) ||
                other.searchText == searchText) &&
            (identical(other.focusNode, focusNode) ||
                other.focusNode == focusNode));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isSearching, searchText, focusNode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SPKSearchStateCopyWith<_$_SPKSearchState> get copyWith =>
      __$$_SPKSearchStateCopyWithImpl<_$_SPKSearchState>(this, _$identity);
}

abstract class _SPKSearchState implements FrameSearchState {
  const factory _SPKSearchState(
      {required final bool isSearching,
      required final String searchText,
      required final FocusNode focusNode}) = _$_SPKSearchState;

  @override
  bool get isSearching;
  @override
  String get searchText;
  @override
  FocusNode get focusNode;
  @override
  @JsonKey(ignore: true)
  _$$_SPKSearchStateCopyWith<_$_SPKSearchState> get copyWith =>
      throw _privateConstructorUsedError;
}
