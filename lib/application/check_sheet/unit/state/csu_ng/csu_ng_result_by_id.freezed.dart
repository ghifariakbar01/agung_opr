// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'csu_ng_result_by_id.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CSUNGResultByID _$CSUNGResultByIDFromJson(Map<String, dynamic> json) {
  return _CSUNGResult.fromJson(json);
}

/// @nodoc
mixin _$CSUNGResultByID {
  int get idCS => throw _privateConstructorUsedError;
  List<CSUNGResult> get csuNGResult => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CSUNGResultByIDCopyWith<CSUNGResultByID> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CSUNGResultByIDCopyWith<$Res> {
  factory $CSUNGResultByIDCopyWith(
          CSUNGResultByID value, $Res Function(CSUNGResultByID) then) =
      _$CSUNGResultByIDCopyWithImpl<$Res, CSUNGResultByID>;
  @useResult
  $Res call({int idCS, List<CSUNGResult> csuNGResult});
}

/// @nodoc
class _$CSUNGResultByIDCopyWithImpl<$Res, $Val extends CSUNGResultByID>
    implements $CSUNGResultByIDCopyWith<$Res> {
  _$CSUNGResultByIDCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idCS = null,
    Object? csuNGResult = null,
  }) {
    return _then(_value.copyWith(
      idCS: null == idCS
          ? _value.idCS
          : idCS // ignore: cast_nullable_to_non_nullable
              as int,
      csuNGResult: null == csuNGResult
          ? _value.csuNGResult
          : csuNGResult // ignore: cast_nullable_to_non_nullable
              as List<CSUNGResult>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CSUNGResultCopyWith<$Res>
    implements $CSUNGResultByIDCopyWith<$Res> {
  factory _$$_CSUNGResultCopyWith(
          _$_CSUNGResult value, $Res Function(_$_CSUNGResult) then) =
      __$$_CSUNGResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int idCS, List<CSUNGResult> csuNGResult});
}

/// @nodoc
class __$$_CSUNGResultCopyWithImpl<$Res>
    extends _$CSUNGResultByIDCopyWithImpl<$Res, _$_CSUNGResult>
    implements _$$_CSUNGResultCopyWith<$Res> {
  __$$_CSUNGResultCopyWithImpl(
      _$_CSUNGResult _value, $Res Function(_$_CSUNGResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idCS = null,
    Object? csuNGResult = null,
  }) {
    return _then(_$_CSUNGResult(
      idCS: null == idCS
          ? _value.idCS
          : idCS // ignore: cast_nullable_to_non_nullable
              as int,
      csuNGResult: null == csuNGResult
          ? _value._csuNGResult
          : csuNGResult // ignore: cast_nullable_to_non_nullable
              as List<CSUNGResult>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CSUNGResult implements _CSUNGResult {
  const _$_CSUNGResult(
      {required this.idCS, required final List<CSUNGResult> csuNGResult})
      : _csuNGResult = csuNGResult;

  factory _$_CSUNGResult.fromJson(Map<String, dynamic> json) =>
      _$$_CSUNGResultFromJson(json);

  @override
  final int idCS;
  final List<CSUNGResult> _csuNGResult;
  @override
  List<CSUNGResult> get csuNGResult {
    if (_csuNGResult is EqualUnmodifiableListView) return _csuNGResult;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_csuNGResult);
  }

  @override
  String toString() {
    return 'CSUNGResultByID(idCS: $idCS, csuNGResult: $csuNGResult)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CSUNGResult &&
            (identical(other.idCS, idCS) || other.idCS == idCS) &&
            const DeepCollectionEquality()
                .equals(other._csuNGResult, _csuNGResult));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, idCS, const DeepCollectionEquality().hash(_csuNGResult));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CSUNGResultCopyWith<_$_CSUNGResult> get copyWith =>
      __$$_CSUNGResultCopyWithImpl<_$_CSUNGResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CSUNGResultToJson(
      this,
    );
  }
}

abstract class _CSUNGResult implements CSUNGResultByID {
  const factory _CSUNGResult(
      {required final int idCS,
      required final List<CSUNGResult> csuNGResult}) = _$_CSUNGResult;

  factory _CSUNGResult.fromJson(Map<String, dynamic> json) =
      _$_CSUNGResult.fromJson;

  @override
  int get idCS;
  @override
  List<CSUNGResult> get csuNGResult;
  @override
  @JsonKey(ignore: true)
  _$$_CSUNGResultCopyWith<_$_CSUNGResult> get copyWith =>
      throw _privateConstructorUsedError;
}
