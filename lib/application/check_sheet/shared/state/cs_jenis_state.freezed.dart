// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cs_jenis_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CSJenisState {
  List<CSJenis> get csJenisList => throw _privateConstructorUsedError;
  int get selectedId => throw _privateConstructorUsedError;
  bool get isProcessing => throw _privateConstructorUsedError;
  Option<Either<RemoteFailure, List<CSJenis>>> get FOSOCSJenis =>
      throw _privateConstructorUsedError;
  Option<Either<LocalFailure, Unit>> get FOSOSaveCSJenis =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CSJenisStateCopyWith<CSJenisState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CSJenisStateCopyWith<$Res> {
  factory $CSJenisStateCopyWith(
          CSJenisState value, $Res Function(CSJenisState) then) =
      _$CSJenisStateCopyWithImpl<$Res, CSJenisState>;
  @useResult
  $Res call(
      {List<CSJenis> csJenisList,
      int selectedId,
      bool isProcessing,
      Option<Either<RemoteFailure, List<CSJenis>>> FOSOCSJenis,
      Option<Either<LocalFailure, Unit>> FOSOSaveCSJenis});
}

/// @nodoc
class _$CSJenisStateCopyWithImpl<$Res, $Val extends CSJenisState>
    implements $CSJenisStateCopyWith<$Res> {
  _$CSJenisStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? csJenisList = null,
    Object? selectedId = null,
    Object? isProcessing = null,
    Object? FOSOCSJenis = null,
    Object? FOSOSaveCSJenis = null,
  }) {
    return _then(_value.copyWith(
      csJenisList: null == csJenisList
          ? _value.csJenisList
          : csJenisList // ignore: cast_nullable_to_non_nullable
              as List<CSJenis>,
      selectedId: null == selectedId
          ? _value.selectedId
          : selectedId // ignore: cast_nullable_to_non_nullable
              as int,
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      FOSOCSJenis: null == FOSOCSJenis
          ? _value.FOSOCSJenis
          : FOSOCSJenis // ignore: cast_nullable_to_non_nullable
              as Option<Either<RemoteFailure, List<CSJenis>>>,
      FOSOSaveCSJenis: null == FOSOSaveCSJenis
          ? _value.FOSOSaveCSJenis
          : FOSOSaveCSJenis // ignore: cast_nullable_to_non_nullable
              as Option<Either<LocalFailure, Unit>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CSJenisStateCopyWith<$Res>
    implements $CSJenisStateCopyWith<$Res> {
  factory _$$_CSJenisStateCopyWith(
          _$_CSJenisState value, $Res Function(_$_CSJenisState) then) =
      __$$_CSJenisStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<CSJenis> csJenisList,
      int selectedId,
      bool isProcessing,
      Option<Either<RemoteFailure, List<CSJenis>>> FOSOCSJenis,
      Option<Either<LocalFailure, Unit>> FOSOSaveCSJenis});
}

/// @nodoc
class __$$_CSJenisStateCopyWithImpl<$Res>
    extends _$CSJenisStateCopyWithImpl<$Res, _$_CSJenisState>
    implements _$$_CSJenisStateCopyWith<$Res> {
  __$$_CSJenisStateCopyWithImpl(
      _$_CSJenisState _value, $Res Function(_$_CSJenisState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? csJenisList = null,
    Object? selectedId = null,
    Object? isProcessing = null,
    Object? FOSOCSJenis = null,
    Object? FOSOSaveCSJenis = null,
  }) {
    return _then(_$_CSJenisState(
      csJenisList: null == csJenisList
          ? _value._csJenisList
          : csJenisList // ignore: cast_nullable_to_non_nullable
              as List<CSJenis>,
      selectedId: null == selectedId
          ? _value.selectedId
          : selectedId // ignore: cast_nullable_to_non_nullable
              as int,
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      FOSOCSJenis: null == FOSOCSJenis
          ? _value.FOSOCSJenis
          : FOSOCSJenis // ignore: cast_nullable_to_non_nullable
              as Option<Either<RemoteFailure, List<CSJenis>>>,
      FOSOSaveCSJenis: null == FOSOSaveCSJenis
          ? _value.FOSOSaveCSJenis
          : FOSOSaveCSJenis // ignore: cast_nullable_to_non_nullable
              as Option<Either<LocalFailure, Unit>>,
    ));
  }
}

/// @nodoc

class _$_CSJenisState implements _CSJenisState {
  const _$_CSJenisState(
      {required final List<CSJenis> csJenisList,
      required this.selectedId,
      required this.isProcessing,
      required this.FOSOCSJenis,
      required this.FOSOSaveCSJenis})
      : _csJenisList = csJenisList;

  final List<CSJenis> _csJenisList;
  @override
  List<CSJenis> get csJenisList {
    if (_csJenisList is EqualUnmodifiableListView) return _csJenisList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_csJenisList);
  }

  @override
  final int selectedId;
  @override
  final bool isProcessing;
  @override
  final Option<Either<RemoteFailure, List<CSJenis>>> FOSOCSJenis;
  @override
  final Option<Either<LocalFailure, Unit>> FOSOSaveCSJenis;

  @override
  String toString() {
    return 'CSJenisState(csJenisList: $csJenisList, selectedId: $selectedId, isProcessing: $isProcessing, FOSOCSJenis: $FOSOCSJenis, FOSOSaveCSJenis: $FOSOSaveCSJenis)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CSJenisState &&
            const DeepCollectionEquality()
                .equals(other._csJenisList, _csJenisList) &&
            (identical(other.selectedId, selectedId) ||
                other.selectedId == selectedId) &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            (identical(other.FOSOCSJenis, FOSOCSJenis) ||
                other.FOSOCSJenis == FOSOCSJenis) &&
            (identical(other.FOSOSaveCSJenis, FOSOSaveCSJenis) ||
                other.FOSOSaveCSJenis == FOSOSaveCSJenis));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_csJenisList),
      selectedId,
      isProcessing,
      FOSOCSJenis,
      FOSOSaveCSJenis);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CSJenisStateCopyWith<_$_CSJenisState> get copyWith =>
      __$$_CSJenisStateCopyWithImpl<_$_CSJenisState>(this, _$identity);
}

abstract class _CSJenisState implements CSJenisState {
  const factory _CSJenisState(
      {required final List<CSJenis> csJenisList,
      required final int selectedId,
      required final bool isProcessing,
      required final Option<Either<RemoteFailure, List<CSJenis>>> FOSOCSJenis,
      required final Option<Either<LocalFailure, Unit>>
          FOSOSaveCSJenis}) = _$_CSJenisState;

  @override
  List<CSJenis> get csJenisList;
  @override
  int get selectedId;
  @override
  bool get isProcessing;
  @override
  Option<Either<RemoteFailure, List<CSJenis>>> get FOSOCSJenis;
  @override
  Option<Either<LocalFailure, Unit>> get FOSOSaveCSJenis;
  @override
  @JsonKey(ignore: true)
  _$$_CSJenisStateCopyWith<_$_CSJenisState> get copyWith =>
      throw _privateConstructorUsedError;
}
