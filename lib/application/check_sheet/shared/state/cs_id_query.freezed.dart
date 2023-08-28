// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cs_id_query.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CSIDQuery _$CSIDQueryFromJson(Map<String, dynamic> json) {
  return _CSIDQuery.fromJson(json);
}

/// @nodoc
mixin _$CSIDQuery {
  int get idSPK => throw _privateConstructorUsedError;
  String get query => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CSIDQueryCopyWith<CSIDQuery> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CSIDQueryCopyWith<$Res> {
  factory $CSIDQueryCopyWith(CSIDQuery value, $Res Function(CSIDQuery) then) =
      _$CSIDQueryCopyWithImpl<$Res, CSIDQuery>;
  @useResult
  $Res call({int idSPK, String query});
}

/// @nodoc
class _$CSIDQueryCopyWithImpl<$Res, $Val extends CSIDQuery>
    implements $CSIDQueryCopyWith<$Res> {
  _$CSIDQueryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idSPK = null,
    Object? query = null,
  }) {
    return _then(_value.copyWith(
      idSPK: null == idSPK
          ? _value.idSPK
          : idSPK // ignore: cast_nullable_to_non_nullable
              as int,
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CSIDQueryCopyWith<$Res> implements $CSIDQueryCopyWith<$Res> {
  factory _$$_CSIDQueryCopyWith(
          _$_CSIDQuery value, $Res Function(_$_CSIDQuery) then) =
      __$$_CSIDQueryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int idSPK, String query});
}

/// @nodoc
class __$$_CSIDQueryCopyWithImpl<$Res>
    extends _$CSIDQueryCopyWithImpl<$Res, _$_CSIDQuery>
    implements _$$_CSIDQueryCopyWith<$Res> {
  __$$_CSIDQueryCopyWithImpl(
      _$_CSIDQuery _value, $Res Function(_$_CSIDQuery) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idSPK = null,
    Object? query = null,
  }) {
    return _then(_$_CSIDQuery(
      idSPK: null == idSPK
          ? _value.idSPK
          : idSPK // ignore: cast_nullable_to_non_nullable
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
class _$_CSIDQuery implements _CSIDQuery {
  const _$_CSIDQuery({required this.idSPK, required this.query});

  factory _$_CSIDQuery.fromJson(Map<String, dynamic> json) =>
      _$$_CSIDQueryFromJson(json);

  @override
  final int idSPK;
  @override
  final String query;

  @override
  String toString() {
    return 'CSIDQuery(idSPK: $idSPK, query: $query)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CSIDQuery &&
            (identical(other.idSPK, idSPK) || other.idSPK == idSPK) &&
            (identical(other.query, query) || other.query == query));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, idSPK, query);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CSIDQueryCopyWith<_$_CSIDQuery> get copyWith =>
      __$$_CSIDQueryCopyWithImpl<_$_CSIDQuery>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CSIDQueryToJson(
      this,
    );
  }
}

abstract class _CSIDQuery implements CSIDQuery {
  const factory _CSIDQuery(
      {required final int idSPK, required final String query}) = _$_CSIDQuery;

  factory _CSIDQuery.fromJson(Map<String, dynamic> json) =
      _$_CSIDQuery.fromJson;

  @override
  int get idSPK;
  @override
  String get query;
  @override
  @JsonKey(ignore: true)
  _$$_CSIDQueryCopyWith<_$_CSIDQuery> get copyWith =>
      throw _privateConstructorUsedError;
}
