// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

History _$HistoryFromJson(Map<String, dynamic> json) {
  return _History.fromJson(json);
}

/// @nodoc
mixin _$History {
  @JsonKey(name: 'id_user')
  int get idUser => throw _privateConstructorUsedError;
  String get query => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'c_user')
  String? get cUser => throw _privateConstructorUsedError;
  @JsonKey(name: 'c_date')
  String? get cDate => throw _privateConstructorUsedError;
  @JsonKey(name: 's_date')
  String? get sDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HistoryCopyWith<History> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryCopyWith<$Res> {
  factory $HistoryCopyWith(History value, $Res Function(History) then) =
      _$HistoryCopyWithImpl<$Res, History>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id_user') int idUser,
      String query,
      String content,
      @JsonKey(name: 'c_user') String? cUser,
      @JsonKey(name: 'c_date') String? cDate,
      @JsonKey(name: 's_date') String? sDate});
}

/// @nodoc
class _$HistoryCopyWithImpl<$Res, $Val extends History>
    implements $HistoryCopyWith<$Res> {
  _$HistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idUser = null,
    Object? query = null,
    Object? content = null,
    Object? cUser = freezed,
    Object? cDate = freezed,
    Object? sDate = freezed,
  }) {
    return _then(_value.copyWith(
      idUser: null == idUser
          ? _value.idUser
          : idUser // ignore: cast_nullable_to_non_nullable
              as int,
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      cUser: freezed == cUser
          ? _value.cUser
          : cUser // ignore: cast_nullable_to_non_nullable
              as String?,
      cDate: freezed == cDate
          ? _value.cDate
          : cDate // ignore: cast_nullable_to_non_nullable
              as String?,
      sDate: freezed == sDate
          ? _value.sDate
          : sDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HistoryCopyWith<$Res> implements $HistoryCopyWith<$Res> {
  factory _$$_HistoryCopyWith(
          _$_History value, $Res Function(_$_History) then) =
      __$$_HistoryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id_user') int idUser,
      String query,
      String content,
      @JsonKey(name: 'c_user') String? cUser,
      @JsonKey(name: 'c_date') String? cDate,
      @JsonKey(name: 's_date') String? sDate});
}

/// @nodoc
class __$$_HistoryCopyWithImpl<$Res>
    extends _$HistoryCopyWithImpl<$Res, _$_History>
    implements _$$_HistoryCopyWith<$Res> {
  __$$_HistoryCopyWithImpl(_$_History _value, $Res Function(_$_History) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idUser = null,
    Object? query = null,
    Object? content = null,
    Object? cUser = freezed,
    Object? cDate = freezed,
    Object? sDate = freezed,
  }) {
    return _then(_$_History(
      idUser: null == idUser
          ? _value.idUser
          : idUser // ignore: cast_nullable_to_non_nullable
              as int,
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      cUser: freezed == cUser
          ? _value.cUser
          : cUser // ignore: cast_nullable_to_non_nullable
              as String?,
      cDate: freezed == cDate
          ? _value.cDate
          : cDate // ignore: cast_nullable_to_non_nullable
              as String?,
      sDate: freezed == sDate
          ? _value.sDate
          : sDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_History implements _History {
  const _$_History(
      {@JsonKey(name: 'id_user') required this.idUser,
      required this.query,
      required this.content,
      @JsonKey(name: 'c_user') required this.cUser,
      @JsonKey(name: 'c_date') required this.cDate,
      @JsonKey(name: 's_date') required this.sDate});

  factory _$_History.fromJson(Map<String, dynamic> json) =>
      _$$_HistoryFromJson(json);

  @override
  @JsonKey(name: 'id_user')
  final int idUser;
  @override
  final String query;
  @override
  final String content;
  @override
  @JsonKey(name: 'c_user')
  final String? cUser;
  @override
  @JsonKey(name: 'c_date')
  final String? cDate;
  @override
  @JsonKey(name: 's_date')
  final String? sDate;

  @override
  String toString() {
    return 'History(idUser: $idUser, query: $query, content: $content, cUser: $cUser, cDate: $cDate, sDate: $sDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_History &&
            (identical(other.idUser, idUser) || other.idUser == idUser) &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.cUser, cUser) || other.cUser == cUser) &&
            (identical(other.cDate, cDate) || other.cDate == cDate) &&
            (identical(other.sDate, sDate) || other.sDate == sDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, idUser, query, content, cUser, cDate, sDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HistoryCopyWith<_$_History> get copyWith =>
      __$$_HistoryCopyWithImpl<_$_History>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HistoryToJson(
      this,
    );
  }
}

abstract class _History implements History {
  const factory _History(
      {@JsonKey(name: 'id_user') required final int idUser,
      required final String query,
      required final String content,
      @JsonKey(name: 'c_user') required final String? cUser,
      @JsonKey(name: 'c_date') required final String? cDate,
      @JsonKey(name: 's_date') required final String? sDate}) = _$_History;

  factory _History.fromJson(Map<String, dynamic> json) = _$_History.fromJson;

  @override
  @JsonKey(name: 'id_user')
  int get idUser;
  @override
  String get query;
  @override
  String get content;
  @override
  @JsonKey(name: 'c_user')
  String? get cUser;
  @override
  @JsonKey(name: 'c_date')
  String? get cDate;
  @override
  @JsonKey(name: 's_date')
  String? get sDate;
  @override
  @JsonKey(ignore: true)
  _$$_HistoryCopyWith<_$_History> get copyWith =>
      throw _privateConstructorUsedError;
}
