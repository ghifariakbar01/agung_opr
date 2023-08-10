// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'frame.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Frame _$FrameFromJson(Map<String, dynamic> json) {
  return _Frame.fromJson(json);
}

/// @nodoc
mixin _$Frame {
  @JsonKey(name: 'id_unit')
  int get idUnit => throw _privateConstructorUsedError;
  String? get frame => throw _privateConstructorUsedError;
  String? get engine => throw _privateConstructorUsedError;
  String? get warna => throw _privateConstructorUsedError;
  @JsonKey(name: 'no_reff_expor')
  String? get noReffExp => throw _privateConstructorUsedError;
  @JsonKey(name: 'id_kend_type')
  int? get idKendType => throw _privateConstructorUsedError;
  String? get custnm => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FrameCopyWith<Frame> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FrameCopyWith<$Res> {
  factory $FrameCopyWith(Frame value, $Res Function(Frame) then) =
      _$FrameCopyWithImpl<$Res, Frame>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id_unit') int idUnit,
      String? frame,
      String? engine,
      String? warna,
      @JsonKey(name: 'no_reff_expor') String? noReffExp,
      @JsonKey(name: 'id_kend_type') int? idKendType,
      String? custnm});
}

/// @nodoc
class _$FrameCopyWithImpl<$Res, $Val extends Frame>
    implements $FrameCopyWith<$Res> {
  _$FrameCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idUnit = null,
    Object? frame = freezed,
    Object? engine = freezed,
    Object? warna = freezed,
    Object? noReffExp = freezed,
    Object? idKendType = freezed,
    Object? custnm = freezed,
  }) {
    return _then(_value.copyWith(
      idUnit: null == idUnit
          ? _value.idUnit
          : idUnit // ignore: cast_nullable_to_non_nullable
              as int,
      frame: freezed == frame
          ? _value.frame
          : frame // ignore: cast_nullable_to_non_nullable
              as String?,
      engine: freezed == engine
          ? _value.engine
          : engine // ignore: cast_nullable_to_non_nullable
              as String?,
      warna: freezed == warna
          ? _value.warna
          : warna // ignore: cast_nullable_to_non_nullable
              as String?,
      noReffExp: freezed == noReffExp
          ? _value.noReffExp
          : noReffExp // ignore: cast_nullable_to_non_nullable
              as String?,
      idKendType: freezed == idKendType
          ? _value.idKendType
          : idKendType // ignore: cast_nullable_to_non_nullable
              as int?,
      custnm: freezed == custnm
          ? _value.custnm
          : custnm // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FrameCopyWith<$Res> implements $FrameCopyWith<$Res> {
  factory _$$_FrameCopyWith(_$_Frame value, $Res Function(_$_Frame) then) =
      __$$_FrameCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id_unit') int idUnit,
      String? frame,
      String? engine,
      String? warna,
      @JsonKey(name: 'no_reff_expor') String? noReffExp,
      @JsonKey(name: 'id_kend_type') int? idKendType,
      String? custnm});
}

/// @nodoc
class __$$_FrameCopyWithImpl<$Res> extends _$FrameCopyWithImpl<$Res, _$_Frame>
    implements _$$_FrameCopyWith<$Res> {
  __$$_FrameCopyWithImpl(_$_Frame _value, $Res Function(_$_Frame) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idUnit = null,
    Object? frame = freezed,
    Object? engine = freezed,
    Object? warna = freezed,
    Object? noReffExp = freezed,
    Object? idKendType = freezed,
    Object? custnm = freezed,
  }) {
    return _then(_$_Frame(
      idUnit: null == idUnit
          ? _value.idUnit
          : idUnit // ignore: cast_nullable_to_non_nullable
              as int,
      frame: freezed == frame
          ? _value.frame
          : frame // ignore: cast_nullable_to_non_nullable
              as String?,
      engine: freezed == engine
          ? _value.engine
          : engine // ignore: cast_nullable_to_non_nullable
              as String?,
      warna: freezed == warna
          ? _value.warna
          : warna // ignore: cast_nullable_to_non_nullable
              as String?,
      noReffExp: freezed == noReffExp
          ? _value.noReffExp
          : noReffExp // ignore: cast_nullable_to_non_nullable
              as String?,
      idKendType: freezed == idKendType
          ? _value.idKendType
          : idKendType // ignore: cast_nullable_to_non_nullable
              as int?,
      custnm: freezed == custnm
          ? _value.custnm
          : custnm // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Frame implements _Frame {
  const _$_Frame(
      {@JsonKey(name: 'id_unit') required this.idUnit,
      required this.frame,
      required this.engine,
      required this.warna,
      @JsonKey(name: 'no_reff_expor') required this.noReffExp,
      @JsonKey(name: 'id_kend_type') required this.idKendType,
      required this.custnm});

  factory _$_Frame.fromJson(Map<String, dynamic> json) =>
      _$$_FrameFromJson(json);

  @override
  @JsonKey(name: 'id_unit')
  final int idUnit;
  @override
  final String? frame;
  @override
  final String? engine;
  @override
  final String? warna;
  @override
  @JsonKey(name: 'no_reff_expor')
  final String? noReffExp;
  @override
  @JsonKey(name: 'id_kend_type')
  final int? idKendType;
  @override
  final String? custnm;

  @override
  String toString() {
    return 'Frame(idUnit: $idUnit, frame: $frame, engine: $engine, warna: $warna, noReffExp: $noReffExp, idKendType: $idKendType, custnm: $custnm)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Frame &&
            (identical(other.idUnit, idUnit) || other.idUnit == idUnit) &&
            (identical(other.frame, frame) || other.frame == frame) &&
            (identical(other.engine, engine) || other.engine == engine) &&
            (identical(other.warna, warna) || other.warna == warna) &&
            (identical(other.noReffExp, noReffExp) ||
                other.noReffExp == noReffExp) &&
            (identical(other.idKendType, idKendType) ||
                other.idKendType == idKendType) &&
            (identical(other.custnm, custnm) || other.custnm == custnm));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, idUnit, frame, engine, warna, noReffExp, idKendType, custnm);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FrameCopyWith<_$_Frame> get copyWith =>
      __$$_FrameCopyWithImpl<_$_Frame>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FrameToJson(
      this,
    );
  }
}

abstract class _Frame implements Frame {
  const factory _Frame(
      {@JsonKey(name: 'id_unit') required final int idUnit,
      required final String? frame,
      required final String? engine,
      required final String? warna,
      @JsonKey(name: 'no_reff_expor') required final String? noReffExp,
      @JsonKey(name: 'id_kend_type') required final int? idKendType,
      required final String? custnm}) = _$_Frame;

  factory _Frame.fromJson(Map<String, dynamic> json) = _$_Frame.fromJson;

  @override
  @JsonKey(name: 'id_unit')
  int get idUnit;
  @override
  String? get frame;
  @override
  String? get engine;
  @override
  String? get warna;
  @override
  @JsonKey(name: 'no_reff_expor')
  String? get noReffExp;
  @override
  @JsonKey(name: 'id_kend_type')
  int? get idKendType;
  @override
  String? get custnm;
  @override
  @JsonKey(ignore: true)
  _$$_FrameCopyWith<_$_Frame> get copyWith =>
      throw _privateConstructorUsedError;
}
