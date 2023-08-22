// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cs_item_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CSItemState _$CSItemStateFromJson(Map<String, dynamic> json) {
  return _CSItemState.fromJson(json);
}

/// @nodoc
mixin _$CSItemState {
  int get id => throw _privateConstructorUsedError;
  int get idList => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get wewenang => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CSItemStateCopyWith<CSItemState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CSItemStateCopyWith<$Res> {
  factory $CSItemStateCopyWith(
          CSItemState value, $Res Function(CSItemState) then) =
      _$CSItemStateCopyWithImpl<$Res, CSItemState>;
  @useResult
  $Res call({int id, int idList, String description, String wewenang});
}

/// @nodoc
class _$CSItemStateCopyWithImpl<$Res, $Val extends CSItemState>
    implements $CSItemStateCopyWith<$Res> {
  _$CSItemStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? idList = null,
    Object? description = null,
    Object? wewenang = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      idList: null == idList
          ? _value.idList
          : idList // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      wewenang: null == wewenang
          ? _value.wewenang
          : wewenang // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CSItemStateCopyWith<$Res>
    implements $CSItemStateCopyWith<$Res> {
  factory _$$_CSItemStateCopyWith(
          _$_CSItemState value, $Res Function(_$_CSItemState) then) =
      __$$_CSItemStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int idList, String description, String wewenang});
}

/// @nodoc
class __$$_CSItemStateCopyWithImpl<$Res>
    extends _$CSItemStateCopyWithImpl<$Res, _$_CSItemState>
    implements _$$_CSItemStateCopyWith<$Res> {
  __$$_CSItemStateCopyWithImpl(
      _$_CSItemState _value, $Res Function(_$_CSItemState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? idList = null,
    Object? description = null,
    Object? wewenang = null,
  }) {
    return _then(_$_CSItemState(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      idList: null == idList
          ? _value.idList
          : idList // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      wewenang: null == wewenang
          ? _value.wewenang
          : wewenang // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CSItemState implements _CSItemState {
  const _$_CSItemState(
      {required this.id,
      required this.idList,
      required this.description,
      required this.wewenang});

  factory _$_CSItemState.fromJson(Map<String, dynamic> json) =>
      _$$_CSItemStateFromJson(json);

  @override
  final int id;
  @override
  final int idList;
  @override
  final String description;
  @override
  final String wewenang;

  @override
  String toString() {
    return 'CSItemState(id: $id, idList: $idList, description: $description, wewenang: $wewenang)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CSItemState &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.idList, idList) || other.idList == idList) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.wewenang, wewenang) ||
                other.wewenang == wewenang));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, idList, description, wewenang);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CSItemStateCopyWith<_$_CSItemState> get copyWith =>
      __$$_CSItemStateCopyWithImpl<_$_CSItemState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CSItemStateToJson(
      this,
    );
  }
}

abstract class _CSItemState implements CSItemState {
  const factory _CSItemState(
      {required final int id,
      required final int idList,
      required final String description,
      required final String wewenang}) = _$_CSItemState;

  factory _CSItemState.fromJson(Map<String, dynamic> json) =
      _$_CSItemState.fromJson;

  @override
  int get id;
  @override
  int get idList;
  @override
  String get description;
  @override
  String get wewenang;
  @override
  @JsonKey(ignore: true)
  _$$_CSItemStateCopyWith<_$_CSItemState> get copyWith =>
      throw _privateConstructorUsedError;
}
