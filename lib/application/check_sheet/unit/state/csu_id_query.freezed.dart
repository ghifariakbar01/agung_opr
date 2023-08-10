// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'csu_id_query.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CSUIDQuery _$CSUIDQueryFromJson(Map<String, dynamic> json) {
  return _CSUIDQuery.fromJson(json);
}

/// @nodoc
mixin _$CSUIDQuery {
  int get idUnit => throw _privateConstructorUsedError;
  String get query => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CSUIDQueryCopyWith<CSUIDQuery> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CSUIDQueryCopyWith<$Res> {
  factory $CSUIDQueryCopyWith(
          CSUIDQuery value, $Res Function(CSUIDQuery) then) =
      _$CSUIDQueryCopyWithImpl<$Res, CSUIDQuery>;
  @useResult
  $Res call({int idUnit, String query});
}

/// @nodoc
class _$CSUIDQueryCopyWithImpl<$Res, $Val extends CSUIDQuery>
    implements $CSUIDQueryCopyWith<$Res> {
  _$CSUIDQueryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idUnit = null,
    Object? query = null,
  }) {
    return _then(_value.copyWith(
      idUnit: null == idUnit
          ? _value.idUnit
          : idUnit // ignore: cast_nullable_to_non_nullable
              as int,
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CSUIDQueryCopyWith<$Res>
    implements $CSUIDQueryCopyWith<$Res> {
  factory _$$_CSUIDQueryCopyWith(
          _$_CSUIDQuery value, $Res Function(_$_CSUIDQuery) then) =
      __$$_CSUIDQueryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int idUnit, String query});
}

/// @nodoc
class __$$_CSUIDQueryCopyWithImpl<$Res>
    extends _$CSUIDQueryCopyWithImpl<$Res, _$_CSUIDQuery>
    implements _$$_CSUIDQueryCopyWith<$Res> {
  __$$_CSUIDQueryCopyWithImpl(
      _$_CSUIDQuery _value, $Res Function(_$_CSUIDQuery) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idUnit = null,
    Object? query = null,
  }) {
    return _then(_$_CSUIDQuery(
      idUnit: null == idUnit
          ? _value.idUnit
          : idUnit // ignore: cast_nullable_to_non_nullable
              as int,
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CSUIDQuery implements _CSUIDQuery {
  const _$_CSUIDQuery({required this.idUnit, required this.query});

  factory _$_CSUIDQuery.fromJson(Map<String, dynamic> json) =>
      _$$_CSUIDQueryFromJson(json);

  @override
  final int idUnit;
  @override
  final String query;

  @override
  String toString() {
    return 'CSUIDQuery(idUnit: $idUnit, query: $query)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CSUIDQuery &&
            (identical(other.idUnit, idUnit) || other.idUnit == idUnit) &&
            (identical(other.query, query) || other.query == query));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, idUnit, query);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CSUIDQueryCopyWith<_$_CSUIDQuery> get copyWith =>
      __$$_CSUIDQueryCopyWithImpl<_$_CSUIDQuery>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CSUIDQueryToJson(
      this,
    );
  }
}

abstract class _CSUIDQuery implements CSUIDQuery {
  const factory _CSUIDQuery(
      {required final int idUnit, required final String query}) = _$_CSUIDQuery;

  factory _CSUIDQuery.fromJson(Map<String, dynamic> json) =
      _$_CSUIDQuery.fromJson;

  @override
  int get idUnit;
  @override
  String get query;
  @override
  @JsonKey(ignore: true)
  _$$_CSUIDQueryCopyWith<_$_CSUIDQuery> get copyWith =>
      throw _privateConstructorUsedError;
}
