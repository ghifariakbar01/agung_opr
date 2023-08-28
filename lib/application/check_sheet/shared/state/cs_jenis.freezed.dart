// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cs_jenis.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CSJenis _$CSJenisFromJson(Map<String, dynamic> json) {
  return _CSJenis.fromJson(json);
}

/// @nodoc
mixin _$CSJenis {
  int get id => throw _privateConstructorUsedError;
  String get nama => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CSJenisCopyWith<CSJenis> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CSJenisCopyWith<$Res> {
  factory $CSJenisCopyWith(CSJenis value, $Res Function(CSJenis) then) =
      _$CSJenisCopyWithImpl<$Res, CSJenis>;
  @useResult
  $Res call({int id, String nama});
}

/// @nodoc
class _$CSJenisCopyWithImpl<$Res, $Val extends CSJenis>
    implements $CSJenisCopyWith<$Res> {
  _$CSJenisCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nama = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      nama: null == nama
          ? _value.nama
          : nama // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CSJenisCopyWith<$Res> implements $CSJenisCopyWith<$Res> {
  factory _$$_CSJenisCopyWith(
          _$_CSJenis value, $Res Function(_$_CSJenis) then) =
      __$$_CSJenisCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String nama});
}

/// @nodoc
class __$$_CSJenisCopyWithImpl<$Res>
    extends _$CSJenisCopyWithImpl<$Res, _$_CSJenis>
    implements _$$_CSJenisCopyWith<$Res> {
  __$$_CSJenisCopyWithImpl(_$_CSJenis _value, $Res Function(_$_CSJenis) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nama = null,
  }) {
    return _then(_$_CSJenis(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      nama: null == nama
          ? _value.nama
          : nama // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CSJenis implements _CSJenis {
  const _$_CSJenis({required this.id, required this.nama});

  factory _$_CSJenis.fromJson(Map<String, dynamic> json) =>
      _$$_CSJenisFromJson(json);

  @override
  final int id;
  @override
  final String nama;

  @override
  String toString() {
    return 'CSJenis(id: $id, nama: $nama)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CSJenis &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nama, nama) || other.nama == nama));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, nama);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CSJenisCopyWith<_$_CSJenis> get copyWith =>
      __$$_CSJenisCopyWithImpl<_$_CSJenis>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CSJenisToJson(
      this,
    );
  }
}

abstract class _CSJenis implements CSJenis {
  const factory _CSJenis({required final int id, required final String nama}) =
      _$_CSJenis;

  factory _CSJenis.fromJson(Map<String, dynamic> json) = _$_CSJenis.fromJson;

  @override
  int get id;
  @override
  String get nama;
  @override
  @JsonKey(ignore: true)
  _$$_CSJenisCopyWith<_$_CSJenis> get copyWith =>
      throw _privateConstructorUsedError;
}
