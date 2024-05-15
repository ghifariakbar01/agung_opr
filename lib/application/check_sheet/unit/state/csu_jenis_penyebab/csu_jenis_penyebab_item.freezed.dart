// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'csu_jenis_penyebab_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CSUJenisPenyebabItem _$CSUJenisPenyebabItemFromJson(Map<String, dynamic> json) {
  return _CSUJenisPenyebabItem.fromJson(json);
}

/// @nodoc
mixin _$CSUJenisPenyebabItem {
  int get id => throw _privateConstructorUsedError;
  String? get ind => throw _privateConstructorUsedError;
  String? get eng => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CSUJenisPenyebabItemCopyWith<CSUJenisPenyebabItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CSUJenisPenyebabItemCopyWith<$Res> {
  factory $CSUJenisPenyebabItemCopyWith(CSUJenisPenyebabItem value,
          $Res Function(CSUJenisPenyebabItem) then) =
      _$CSUJenisPenyebabItemCopyWithImpl<$Res, CSUJenisPenyebabItem>;
  @useResult
  $Res call({int id, String? ind, String? eng});
}

/// @nodoc
class _$CSUJenisPenyebabItemCopyWithImpl<$Res,
        $Val extends CSUJenisPenyebabItem>
    implements $CSUJenisPenyebabItemCopyWith<$Res> {
  _$CSUJenisPenyebabItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ind = freezed,
    Object? eng = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      ind: freezed == ind
          ? _value.ind
          : ind // ignore: cast_nullable_to_non_nullable
              as String?,
      eng: freezed == eng
          ? _value.eng
          : eng // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CSUJenisPenyebabItemCopyWith<$Res>
    implements $CSUJenisPenyebabItemCopyWith<$Res> {
  factory _$$_CSUJenisPenyebabItemCopyWith(_$_CSUJenisPenyebabItem value,
          $Res Function(_$_CSUJenisPenyebabItem) then) =
      __$$_CSUJenisPenyebabItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String? ind, String? eng});
}

/// @nodoc
class __$$_CSUJenisPenyebabItemCopyWithImpl<$Res>
    extends _$CSUJenisPenyebabItemCopyWithImpl<$Res, _$_CSUJenisPenyebabItem>
    implements _$$_CSUJenisPenyebabItemCopyWith<$Res> {
  __$$_CSUJenisPenyebabItemCopyWithImpl(_$_CSUJenisPenyebabItem _value,
      $Res Function(_$_CSUJenisPenyebabItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ind = freezed,
    Object? eng = freezed,
  }) {
    return _then(_$_CSUJenisPenyebabItem(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      ind: freezed == ind
          ? _value.ind
          : ind // ignore: cast_nullable_to_non_nullable
              as String?,
      eng: freezed == eng
          ? _value.eng
          : eng // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CSUJenisPenyebabItem implements _CSUJenisPenyebabItem {
  const _$_CSUJenisPenyebabItem(
      {required this.id, required this.ind, required this.eng});

  factory _$_CSUJenisPenyebabItem.fromJson(Map<String, dynamic> json) =>
      _$$_CSUJenisPenyebabItemFromJson(json);

  @override
  final int id;
  @override
  final String? ind;
  @override
  final String? eng;

  @override
  String toString() {
    return 'CSUJenisPenyebabItem(id: $id, ind: $ind, eng: $eng)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CSUJenisPenyebabItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ind, ind) || other.ind == ind) &&
            (identical(other.eng, eng) || other.eng == eng));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, ind, eng);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CSUJenisPenyebabItemCopyWith<_$_CSUJenisPenyebabItem> get copyWith =>
      __$$_CSUJenisPenyebabItemCopyWithImpl<_$_CSUJenisPenyebabItem>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CSUJenisPenyebabItemToJson(
      this,
    );
  }
}

abstract class _CSUJenisPenyebabItem implements CSUJenisPenyebabItem {
  const factory _CSUJenisPenyebabItem(
      {required final int id,
      required final String? ind,
      required final String? eng}) = _$_CSUJenisPenyebabItem;

  factory _CSUJenisPenyebabItem.fromJson(Map<String, dynamic> json) =
      _$_CSUJenisPenyebabItem.fromJson;

  @override
  int get id;
  @override
  String? get ind;
  @override
  String? get eng;
  @override
  @JsonKey(ignore: true)
  _$$_CSUJenisPenyebabItemCopyWith<_$_CSUJenisPenyebabItem> get copyWith =>
      throw _privateConstructorUsedError;
}
