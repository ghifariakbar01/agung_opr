// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'csu_items.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CSUItems _$CSUItemsFromJson(Map<String, dynamic> json) {
  return _CSUItems.fromJson(json);
}

/// @nodoc
mixin _$CSUItems {
  @JsonKey(name: 'id_item')
  int get id => throw _privateConstructorUsedError;
  int get NoUrut => throw _privateConstructorUsedError;
  @JsonKey(name: 'nama_ina')
  String? get ind => throw _privateConstructorUsedError;
  @JsonKey(name: 'nama_eng')
  String? get eng => throw _privateConstructorUsedError;
  String? get Grup => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CSUItemsCopyWith<CSUItems> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CSUItemsCopyWith<$Res> {
  factory $CSUItemsCopyWith(CSUItems value, $Res Function(CSUItems) then) =
      _$CSUItemsCopyWithImpl<$Res, CSUItems>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id_item') int id,
      int NoUrut,
      @JsonKey(name: 'nama_ina') String? ind,
      @JsonKey(name: 'nama_eng') String? eng,
      String? Grup});
}

/// @nodoc
class _$CSUItemsCopyWithImpl<$Res, $Val extends CSUItems>
    implements $CSUItemsCopyWith<$Res> {
  _$CSUItemsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? NoUrut = null,
    Object? ind = freezed,
    Object? eng = freezed,
    Object? Grup = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      NoUrut: null == NoUrut
          ? _value.NoUrut
          : NoUrut // ignore: cast_nullable_to_non_nullable
              as int,
      ind: freezed == ind
          ? _value.ind
          : ind // ignore: cast_nullable_to_non_nullable
              as String?,
      eng: freezed == eng
          ? _value.eng
          : eng // ignore: cast_nullable_to_non_nullable
              as String?,
      Grup: freezed == Grup
          ? _value.Grup
          : Grup // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CSUItemsCopyWith<$Res> implements $CSUItemsCopyWith<$Res> {
  factory _$$_CSUItemsCopyWith(
          _$_CSUItems value, $Res Function(_$_CSUItems) then) =
      __$$_CSUItemsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id_item') int id,
      int NoUrut,
      @JsonKey(name: 'nama_ina') String? ind,
      @JsonKey(name: 'nama_eng') String? eng,
      String? Grup});
}

/// @nodoc
class __$$_CSUItemsCopyWithImpl<$Res>
    extends _$CSUItemsCopyWithImpl<$Res, _$_CSUItems>
    implements _$$_CSUItemsCopyWith<$Res> {
  __$$_CSUItemsCopyWithImpl(
      _$_CSUItems _value, $Res Function(_$_CSUItems) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? NoUrut = null,
    Object? ind = freezed,
    Object? eng = freezed,
    Object? Grup = freezed,
  }) {
    return _then(_$_CSUItems(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      NoUrut: null == NoUrut
          ? _value.NoUrut
          : NoUrut // ignore: cast_nullable_to_non_nullable
              as int,
      ind: freezed == ind
          ? _value.ind
          : ind // ignore: cast_nullable_to_non_nullable
              as String?,
      eng: freezed == eng
          ? _value.eng
          : eng // ignore: cast_nullable_to_non_nullable
              as String?,
      Grup: freezed == Grup
          ? _value.Grup
          : Grup // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CSUItems implements _CSUItems {
  const _$_CSUItems(
      {@JsonKey(name: 'id_item') required this.id,
      required this.NoUrut,
      @JsonKey(name: 'nama_ina') required this.ind,
      @JsonKey(name: 'nama_eng') required this.eng,
      required this.Grup});

  factory _$_CSUItems.fromJson(Map<String, dynamic> json) =>
      _$$_CSUItemsFromJson(json);

  @override
  @JsonKey(name: 'id_item')
  final int id;
  @override
  final int NoUrut;
  @override
  @JsonKey(name: 'nama_ina')
  final String? ind;
  @override
  @JsonKey(name: 'nama_eng')
  final String? eng;
  @override
  final String? Grup;

  @override
  String toString() {
    return 'CSUItems(id: $id, NoUrut: $NoUrut, ind: $ind, eng: $eng, Grup: $Grup)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CSUItems &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.NoUrut, NoUrut) || other.NoUrut == NoUrut) &&
            (identical(other.ind, ind) || other.ind == ind) &&
            (identical(other.eng, eng) || other.eng == eng) &&
            (identical(other.Grup, Grup) || other.Grup == Grup));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, NoUrut, ind, eng, Grup);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CSUItemsCopyWith<_$_CSUItems> get copyWith =>
      __$$_CSUItemsCopyWithImpl<_$_CSUItems>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CSUItemsToJson(
      this,
    );
  }
}

abstract class _CSUItems implements CSUItems {
  const factory _CSUItems(
      {@JsonKey(name: 'id_item') required final int id,
      required final int NoUrut,
      @JsonKey(name: 'nama_ina') required final String? ind,
      @JsonKey(name: 'nama_eng') required final String? eng,
      required final String? Grup}) = _$_CSUItems;

  factory _CSUItems.fromJson(Map<String, dynamic> json) = _$_CSUItems.fromJson;

  @override
  @JsonKey(name: 'id_item')
  int get id;
  @override
  int get NoUrut;
  @override
  @JsonKey(name: 'nama_ina')
  String? get ind;
  @override
  @JsonKey(name: 'nama_eng')
  String? get eng;
  @override
  String? get Grup;
  @override
  @JsonKey(ignore: true)
  _$$_CSUItemsCopyWith<_$_CSUItems> get copyWith =>
      throw _privateConstructorUsedError;
}
