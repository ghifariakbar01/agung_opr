// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'csu_posisi.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CSUPosisi _$CSUPosisiFromJson(Map<String, dynamic> json) {
  return _CSUPosisi.fromJson(json);
}

/// @nodoc
mixin _$CSUPosisi {
  @JsonKey(name: 'id_posisi')
  int get idPosisi => throw _privateConstructorUsedError;
  @JsonKey(name: 'nama_posisi_eng')
  String get namaPosisiEng => throw _privateConstructorUsedError;
  @JsonKey(name: 'nama_posisi_ina')
  String get namaPosisiInd => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CSUPosisiCopyWith<CSUPosisi> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CSUPosisiCopyWith<$Res> {
  factory $CSUPosisiCopyWith(CSUPosisi value, $Res Function(CSUPosisi) then) =
      _$CSUPosisiCopyWithImpl<$Res, CSUPosisi>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id_posisi') int idPosisi,
      @JsonKey(name: 'nama_posisi_eng') String namaPosisiEng,
      @JsonKey(name: 'nama_posisi_ina') String namaPosisiInd});
}

/// @nodoc
class _$CSUPosisiCopyWithImpl<$Res, $Val extends CSUPosisi>
    implements $CSUPosisiCopyWith<$Res> {
  _$CSUPosisiCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idPosisi = null,
    Object? namaPosisiEng = null,
    Object? namaPosisiInd = null,
  }) {
    return _then(_value.copyWith(
      idPosisi: null == idPosisi
          ? _value.idPosisi
          : idPosisi // ignore: cast_nullable_to_non_nullable
              as int,
      namaPosisiEng: null == namaPosisiEng
          ? _value.namaPosisiEng
          : namaPosisiEng // ignore: cast_nullable_to_non_nullable
              as String,
      namaPosisiInd: null == namaPosisiInd
          ? _value.namaPosisiInd
          : namaPosisiInd // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CSUPosisiCopyWith<$Res> implements $CSUPosisiCopyWith<$Res> {
  factory _$$_CSUPosisiCopyWith(
          _$_CSUPosisi value, $Res Function(_$_CSUPosisi) then) =
      __$$_CSUPosisiCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id_posisi') int idPosisi,
      @JsonKey(name: 'nama_posisi_eng') String namaPosisiEng,
      @JsonKey(name: 'nama_posisi_ina') String namaPosisiInd});
}

/// @nodoc
class __$$_CSUPosisiCopyWithImpl<$Res>
    extends _$CSUPosisiCopyWithImpl<$Res, _$_CSUPosisi>
    implements _$$_CSUPosisiCopyWith<$Res> {
  __$$_CSUPosisiCopyWithImpl(
      _$_CSUPosisi _value, $Res Function(_$_CSUPosisi) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idPosisi = null,
    Object? namaPosisiEng = null,
    Object? namaPosisiInd = null,
  }) {
    return _then(_$_CSUPosisi(
      idPosisi: null == idPosisi
          ? _value.idPosisi
          : idPosisi // ignore: cast_nullable_to_non_nullable
              as int,
      namaPosisiEng: null == namaPosisiEng
          ? _value.namaPosisiEng
          : namaPosisiEng // ignore: cast_nullable_to_non_nullable
              as String,
      namaPosisiInd: null == namaPosisiInd
          ? _value.namaPosisiInd
          : namaPosisiInd // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CSUPosisi implements _CSUPosisi {
  _$_CSUPosisi(
      {@JsonKey(name: 'id_posisi') required this.idPosisi,
      @JsonKey(name: 'nama_posisi_eng') required this.namaPosisiEng,
      @JsonKey(name: 'nama_posisi_ina') required this.namaPosisiInd});

  factory _$_CSUPosisi.fromJson(Map<String, dynamic> json) =>
      _$$_CSUPosisiFromJson(json);

  @override
  @JsonKey(name: 'id_posisi')
  final int idPosisi;
  @override
  @JsonKey(name: 'nama_posisi_eng')
  final String namaPosisiEng;
  @override
  @JsonKey(name: 'nama_posisi_ina')
  final String namaPosisiInd;

  @override
  String toString() {
    return 'CSUPosisi(idPosisi: $idPosisi, namaPosisiEng: $namaPosisiEng, namaPosisiInd: $namaPosisiInd)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CSUPosisi &&
            (identical(other.idPosisi, idPosisi) ||
                other.idPosisi == idPosisi) &&
            (identical(other.namaPosisiEng, namaPosisiEng) ||
                other.namaPosisiEng == namaPosisiEng) &&
            (identical(other.namaPosisiInd, namaPosisiInd) ||
                other.namaPosisiInd == namaPosisiInd));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, idPosisi, namaPosisiEng, namaPosisiInd);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CSUPosisiCopyWith<_$_CSUPosisi> get copyWith =>
      __$$_CSUPosisiCopyWithImpl<_$_CSUPosisi>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CSUPosisiToJson(
      this,
    );
  }
}

abstract class _CSUPosisi implements CSUPosisi {
  factory _CSUPosisi(
      {@JsonKey(name: 'id_posisi') required final int idPosisi,
      @JsonKey(name: 'nama_posisi_eng') required final String namaPosisiEng,
      @JsonKey(name: 'nama_posisi_ina')
      required final String namaPosisiInd}) = _$_CSUPosisi;

  factory _CSUPosisi.fromJson(Map<String, dynamic> json) =
      _$_CSUPosisi.fromJson;

  @override
  @JsonKey(name: 'id_posisi')
  int get idPosisi;
  @override
  @JsonKey(name: 'nama_posisi_eng')
  String get namaPosisiEng;
  @override
  @JsonKey(name: 'nama_posisi_ina')
  String get namaPosisiInd;
  @override
  @JsonKey(ignore: true)
  _$$_CSUPosisiCopyWith<_$_CSUPosisi> get copyWith =>
      throw _privateConstructorUsedError;
}
