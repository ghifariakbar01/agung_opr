// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spk_id_query.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SPKIdQuery _$SPKIdQueryFromJson(Map<String, dynamic> json) {
  return _SPKIdQuery.fromJson(json);
}

/// @nodoc
mixin _$SPKIdQuery {
  int get idSPK => throw _privateConstructorUsedError;
  String get query => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SPKIdQueryCopyWith<SPKIdQuery> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SPKIdQueryCopyWith<$Res> {
  factory $SPKIdQueryCopyWith(
          SPKIdQuery value, $Res Function(SPKIdQuery) then) =
      _$SPKIdQueryCopyWithImpl<$Res, SPKIdQuery>;
  @useResult
  $Res call({int idSPK, String query});
}

/// @nodoc
class _$SPKIdQueryCopyWithImpl<$Res, $Val extends SPKIdQuery>
    implements $SPKIdQueryCopyWith<$Res> {
  _$SPKIdQueryCopyWithImpl(this._value, this._then);

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
abstract class _$$_SPKIdQueryCopyWith<$Res>
    implements $SPKIdQueryCopyWith<$Res> {
  factory _$$_SPKIdQueryCopyWith(
          _$_SPKIdQuery value, $Res Function(_$_SPKIdQuery) then) =
      __$$_SPKIdQueryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int idSPK, String query});
}

/// @nodoc
class __$$_SPKIdQueryCopyWithImpl<$Res>
    extends _$SPKIdQueryCopyWithImpl<$Res, _$_SPKIdQuery>
    implements _$$_SPKIdQueryCopyWith<$Res> {
  __$$_SPKIdQueryCopyWithImpl(
      _$_SPKIdQuery _value, $Res Function(_$_SPKIdQuery) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idSPK = null,
    Object? query = null,
  }) {
    return _then(_$_SPKIdQuery(
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
class _$_SPKIdQuery implements _SPKIdQuery {
  const _$_SPKIdQuery({required this.idSPK, required this.query});

  factory _$_SPKIdQuery.fromJson(Map<String, dynamic> json) =>
      _$$_SPKIdQueryFromJson(json);

  @override
  final int idSPK;
  @override
  final String query;

  @override
  String toString() {
    return 'SPKIdQuery(idSPK: $idSPK, query: $query)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SPKIdQuery &&
            (identical(other.idSPK, idSPK) || other.idSPK == idSPK) &&
            (identical(other.query, query) || other.query == query));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, idSPK, query);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SPKIdQueryCopyWith<_$_SPKIdQuery> get copyWith =>
      __$$_SPKIdQueryCopyWithImpl<_$_SPKIdQuery>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SPKIdQueryToJson(
      this,
    );
  }
}

abstract class _SPKIdQuery implements SPKIdQuery {
  const factory _SPKIdQuery(
      {required final int idSPK, required final String query}) = _$_SPKIdQuery;

  factory _SPKIdQuery.fromJson(Map<String, dynamic> json) =
      _$_SPKIdQuery.fromJson;

  @override
  int get idSPK;
  @override
  String get query;
  @override
  @JsonKey(ignore: true)
  _$$_SPKIdQueryCopyWith<_$_SPKIdQuery> get copyWith =>
      throw _privateConstructorUsedError;
}
