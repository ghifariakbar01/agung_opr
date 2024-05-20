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
  List<HistoryCheckSheet> get historyCheckSheet =>
      throw _privateConstructorUsedError;
  List<HistoryCSUOk> get historyCSUOk => throw _privateConstructorUsedError;
  List<HistoryCSUNg> get historyCSUNg => throw _privateConstructorUsedError;

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
      {List<HistoryCheckSheet> historyCheckSheet,
      List<HistoryCSUOk> historyCSUOk,
      List<HistoryCSUNg> historyCSUNg});
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
    Object? historyCheckSheet = null,
    Object? historyCSUOk = null,
    Object? historyCSUNg = null,
  }) {
    return _then(_value.copyWith(
      historyCheckSheet: null == historyCheckSheet
          ? _value.historyCheckSheet
          : historyCheckSheet // ignore: cast_nullable_to_non_nullable
              as List<HistoryCheckSheet>,
      historyCSUOk: null == historyCSUOk
          ? _value.historyCSUOk
          : historyCSUOk // ignore: cast_nullable_to_non_nullable
              as List<HistoryCSUOk>,
      historyCSUNg: null == historyCSUNg
          ? _value.historyCSUNg
          : historyCSUNg // ignore: cast_nullable_to_non_nullable
              as List<HistoryCSUNg>,
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
      {List<HistoryCheckSheet> historyCheckSheet,
      List<HistoryCSUOk> historyCSUOk,
      List<HistoryCSUNg> historyCSUNg});
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
    Object? historyCheckSheet = null,
    Object? historyCSUOk = null,
    Object? historyCSUNg = null,
  }) {
    return _then(_$_History(
      historyCheckSheet: null == historyCheckSheet
          ? _value._historyCheckSheet
          : historyCheckSheet // ignore: cast_nullable_to_non_nullable
              as List<HistoryCheckSheet>,
      historyCSUOk: null == historyCSUOk
          ? _value._historyCSUOk
          : historyCSUOk // ignore: cast_nullable_to_non_nullable
              as List<HistoryCSUOk>,
      historyCSUNg: null == historyCSUNg
          ? _value._historyCSUNg
          : historyCSUNg // ignore: cast_nullable_to_non_nullable
              as List<HistoryCSUNg>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_History implements _History {
  _$_History(
      {required final List<HistoryCheckSheet> historyCheckSheet,
      required final List<HistoryCSUOk> historyCSUOk,
      required final List<HistoryCSUNg> historyCSUNg})
      : _historyCheckSheet = historyCheckSheet,
        _historyCSUOk = historyCSUOk,
        _historyCSUNg = historyCSUNg;

  factory _$_History.fromJson(Map<String, dynamic> json) =>
      _$$_HistoryFromJson(json);

  final List<HistoryCheckSheet> _historyCheckSheet;
  @override
  List<HistoryCheckSheet> get historyCheckSheet {
    if (_historyCheckSheet is EqualUnmodifiableListView)
      return _historyCheckSheet;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_historyCheckSheet);
  }

  final List<HistoryCSUOk> _historyCSUOk;
  @override
  List<HistoryCSUOk> get historyCSUOk {
    if (_historyCSUOk is EqualUnmodifiableListView) return _historyCSUOk;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_historyCSUOk);
  }

  final List<HistoryCSUNg> _historyCSUNg;
  @override
  List<HistoryCSUNg> get historyCSUNg {
    if (_historyCSUNg is EqualUnmodifiableListView) return _historyCSUNg;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_historyCSUNg);
  }

  @override
  String toString() {
    return 'History(historyCheckSheet: $historyCheckSheet, historyCSUOk: $historyCSUOk, historyCSUNg: $historyCSUNg)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_History &&
            const DeepCollectionEquality()
                .equals(other._historyCheckSheet, _historyCheckSheet) &&
            const DeepCollectionEquality()
                .equals(other._historyCSUOk, _historyCSUOk) &&
            const DeepCollectionEquality()
                .equals(other._historyCSUNg, _historyCSUNg));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_historyCheckSheet),
      const DeepCollectionEquality().hash(_historyCSUOk),
      const DeepCollectionEquality().hash(_historyCSUNg));

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
  factory _History(
      {required final List<HistoryCheckSheet> historyCheckSheet,
      required final List<HistoryCSUOk> historyCSUOk,
      required final List<HistoryCSUNg> historyCSUNg}) = _$_History;

  factory _History.fromJson(Map<String, dynamic> json) = _$_History.fromJson;

  @override
  List<HistoryCheckSheet> get historyCheckSheet;
  @override
  List<HistoryCSUOk> get historyCSUOk;
  @override
  List<HistoryCSUNg> get historyCSUNg;
  @override
  @JsonKey(ignore: true)
  _$$_HistoryCopyWith<_$_History> get copyWith =>
      throw _privateConstructorUsedError;
}

HistoryCheckSheet _$HistoryCheckSheetFromJson(Map<String, dynamic> json) {
  return _HistoryCheckSheet.fromJson(json);
}

/// @nodoc
mixin _$HistoryCheckSheet {
  @JsonKey(name: 'id_kr_chk')
  int? get idKrChk => throw _privateConstructorUsedError;
  @JsonKey(name: 'id_spk')
  int? get idSpk => throw _privateConstructorUsedError;
  String? get nopol => throw _privateConstructorUsedError;
  String? get driver1 => throw _privateConstructorUsedError;
  String? get driver2 => throw _privateConstructorUsedError;
  String? get jamload => throw _privateConstructorUsedError;
  String? get gate => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get tipe => throw _privateConstructorUsedError;
  String? get ket => throw _privateConstructorUsedError;
  int? get program => throw _privateConstructorUsedError;
  @JsonKey(name: 'c_date')
  String? get cDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'c_user')
  String? get cUser => throw _privateConstructorUsedError;
  @JsonKey(name: 'u_date')
  String? get uDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'u_user')
  String? get uUser => throw _privateConstructorUsedError;
  @JsonKey(name: 'tgl_berangkat')
  String? get tglBerangkat => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HistoryCheckSheetCopyWith<HistoryCheckSheet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryCheckSheetCopyWith<$Res> {
  factory $HistoryCheckSheetCopyWith(
          HistoryCheckSheet value, $Res Function(HistoryCheckSheet) then) =
      _$HistoryCheckSheetCopyWithImpl<$Res, HistoryCheckSheet>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id_kr_chk') int? idKrChk,
      @JsonKey(name: 'id_spk') int? idSpk,
      String? nopol,
      String? driver1,
      String? driver2,
      String? jamload,
      String? gate,
      String? status,
      String? tipe,
      String? ket,
      int? program,
      @JsonKey(name: 'c_date') String? cDate,
      @JsonKey(name: 'c_user') String? cUser,
      @JsonKey(name: 'u_date') String? uDate,
      @JsonKey(name: 'u_user') String? uUser,
      @JsonKey(name: 'tgl_berangkat') String? tglBerangkat});
}

/// @nodoc
class _$HistoryCheckSheetCopyWithImpl<$Res, $Val extends HistoryCheckSheet>
    implements $HistoryCheckSheetCopyWith<$Res> {
  _$HistoryCheckSheetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idKrChk = freezed,
    Object? idSpk = freezed,
    Object? nopol = freezed,
    Object? driver1 = freezed,
    Object? driver2 = freezed,
    Object? jamload = freezed,
    Object? gate = freezed,
    Object? status = freezed,
    Object? tipe = freezed,
    Object? ket = freezed,
    Object? program = freezed,
    Object? cDate = freezed,
    Object? cUser = freezed,
    Object? uDate = freezed,
    Object? uUser = freezed,
    Object? tglBerangkat = freezed,
  }) {
    return _then(_value.copyWith(
      idKrChk: freezed == idKrChk
          ? _value.idKrChk
          : idKrChk // ignore: cast_nullable_to_non_nullable
              as int?,
      idSpk: freezed == idSpk
          ? _value.idSpk
          : idSpk // ignore: cast_nullable_to_non_nullable
              as int?,
      nopol: freezed == nopol
          ? _value.nopol
          : nopol // ignore: cast_nullable_to_non_nullable
              as String?,
      driver1: freezed == driver1
          ? _value.driver1
          : driver1 // ignore: cast_nullable_to_non_nullable
              as String?,
      driver2: freezed == driver2
          ? _value.driver2
          : driver2 // ignore: cast_nullable_to_non_nullable
              as String?,
      jamload: freezed == jamload
          ? _value.jamload
          : jamload // ignore: cast_nullable_to_non_nullable
              as String?,
      gate: freezed == gate
          ? _value.gate
          : gate // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      tipe: freezed == tipe
          ? _value.tipe
          : tipe // ignore: cast_nullable_to_non_nullable
              as String?,
      ket: freezed == ket
          ? _value.ket
          : ket // ignore: cast_nullable_to_non_nullable
              as String?,
      program: freezed == program
          ? _value.program
          : program // ignore: cast_nullable_to_non_nullable
              as int?,
      cDate: freezed == cDate
          ? _value.cDate
          : cDate // ignore: cast_nullable_to_non_nullable
              as String?,
      cUser: freezed == cUser
          ? _value.cUser
          : cUser // ignore: cast_nullable_to_non_nullable
              as String?,
      uDate: freezed == uDate
          ? _value.uDate
          : uDate // ignore: cast_nullable_to_non_nullable
              as String?,
      uUser: freezed == uUser
          ? _value.uUser
          : uUser // ignore: cast_nullable_to_non_nullable
              as String?,
      tglBerangkat: freezed == tglBerangkat
          ? _value.tglBerangkat
          : tglBerangkat // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HistoryCheckSheetCopyWith<$Res>
    implements $HistoryCheckSheetCopyWith<$Res> {
  factory _$$_HistoryCheckSheetCopyWith(_$_HistoryCheckSheet value,
          $Res Function(_$_HistoryCheckSheet) then) =
      __$$_HistoryCheckSheetCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id_kr_chk') int? idKrChk,
      @JsonKey(name: 'id_spk') int? idSpk,
      String? nopol,
      String? driver1,
      String? driver2,
      String? jamload,
      String? gate,
      String? status,
      String? tipe,
      String? ket,
      int? program,
      @JsonKey(name: 'c_date') String? cDate,
      @JsonKey(name: 'c_user') String? cUser,
      @JsonKey(name: 'u_date') String? uDate,
      @JsonKey(name: 'u_user') String? uUser,
      @JsonKey(name: 'tgl_berangkat') String? tglBerangkat});
}

/// @nodoc
class __$$_HistoryCheckSheetCopyWithImpl<$Res>
    extends _$HistoryCheckSheetCopyWithImpl<$Res, _$_HistoryCheckSheet>
    implements _$$_HistoryCheckSheetCopyWith<$Res> {
  __$$_HistoryCheckSheetCopyWithImpl(
      _$_HistoryCheckSheet _value, $Res Function(_$_HistoryCheckSheet) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idKrChk = freezed,
    Object? idSpk = freezed,
    Object? nopol = freezed,
    Object? driver1 = freezed,
    Object? driver2 = freezed,
    Object? jamload = freezed,
    Object? gate = freezed,
    Object? status = freezed,
    Object? tipe = freezed,
    Object? ket = freezed,
    Object? program = freezed,
    Object? cDate = freezed,
    Object? cUser = freezed,
    Object? uDate = freezed,
    Object? uUser = freezed,
    Object? tglBerangkat = freezed,
  }) {
    return _then(_$_HistoryCheckSheet(
      idKrChk: freezed == idKrChk
          ? _value.idKrChk
          : idKrChk // ignore: cast_nullable_to_non_nullable
              as int?,
      idSpk: freezed == idSpk
          ? _value.idSpk
          : idSpk // ignore: cast_nullable_to_non_nullable
              as int?,
      nopol: freezed == nopol
          ? _value.nopol
          : nopol // ignore: cast_nullable_to_non_nullable
              as String?,
      driver1: freezed == driver1
          ? _value.driver1
          : driver1 // ignore: cast_nullable_to_non_nullable
              as String?,
      driver2: freezed == driver2
          ? _value.driver2
          : driver2 // ignore: cast_nullable_to_non_nullable
              as String?,
      jamload: freezed == jamload
          ? _value.jamload
          : jamload // ignore: cast_nullable_to_non_nullable
              as String?,
      gate: freezed == gate
          ? _value.gate
          : gate // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      tipe: freezed == tipe
          ? _value.tipe
          : tipe // ignore: cast_nullable_to_non_nullable
              as String?,
      ket: freezed == ket
          ? _value.ket
          : ket // ignore: cast_nullable_to_non_nullable
              as String?,
      program: freezed == program
          ? _value.program
          : program // ignore: cast_nullable_to_non_nullable
              as int?,
      cDate: freezed == cDate
          ? _value.cDate
          : cDate // ignore: cast_nullable_to_non_nullable
              as String?,
      cUser: freezed == cUser
          ? _value.cUser
          : cUser // ignore: cast_nullable_to_non_nullable
              as String?,
      uDate: freezed == uDate
          ? _value.uDate
          : uDate // ignore: cast_nullable_to_non_nullable
              as String?,
      uUser: freezed == uUser
          ? _value.uUser
          : uUser // ignore: cast_nullable_to_non_nullable
              as String?,
      tglBerangkat: freezed == tglBerangkat
          ? _value.tglBerangkat
          : tglBerangkat // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_HistoryCheckSheet implements _HistoryCheckSheet {
  _$_HistoryCheckSheet(
      {@JsonKey(name: 'id_kr_chk') required this.idKrChk,
      @JsonKey(name: 'id_spk') required this.idSpk,
      required this.nopol,
      required this.driver1,
      required this.driver2,
      required this.jamload,
      required this.gate,
      required this.status,
      required this.tipe,
      required this.ket,
      required this.program,
      @JsonKey(name: 'c_date') required this.cDate,
      @JsonKey(name: 'c_user') required this.cUser,
      @JsonKey(name: 'u_date') required this.uDate,
      @JsonKey(name: 'u_user') required this.uUser,
      @JsonKey(name: 'tgl_berangkat') required this.tglBerangkat});

  factory _$_HistoryCheckSheet.fromJson(Map<String, dynamic> json) =>
      _$$_HistoryCheckSheetFromJson(json);

  @override
  @JsonKey(name: 'id_kr_chk')
  final int? idKrChk;
  @override
  @JsonKey(name: 'id_spk')
  final int? idSpk;
  @override
  final String? nopol;
  @override
  final String? driver1;
  @override
  final String? driver2;
  @override
  final String? jamload;
  @override
  final String? gate;
  @override
  final String? status;
  @override
  final String? tipe;
  @override
  final String? ket;
  @override
  final int? program;
  @override
  @JsonKey(name: 'c_date')
  final String? cDate;
  @override
  @JsonKey(name: 'c_user')
  final String? cUser;
  @override
  @JsonKey(name: 'u_date')
  final String? uDate;
  @override
  @JsonKey(name: 'u_user')
  final String? uUser;
  @override
  @JsonKey(name: 'tgl_berangkat')
  final String? tglBerangkat;

  @override
  String toString() {
    return 'HistoryCheckSheet(idKrChk: $idKrChk, idSpk: $idSpk, nopol: $nopol, driver1: $driver1, driver2: $driver2, jamload: $jamload, gate: $gate, status: $status, tipe: $tipe, ket: $ket, program: $program, cDate: $cDate, cUser: $cUser, uDate: $uDate, uUser: $uUser, tglBerangkat: $tglBerangkat)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HistoryCheckSheet &&
            (identical(other.idKrChk, idKrChk) || other.idKrChk == idKrChk) &&
            (identical(other.idSpk, idSpk) || other.idSpk == idSpk) &&
            (identical(other.nopol, nopol) || other.nopol == nopol) &&
            (identical(other.driver1, driver1) || other.driver1 == driver1) &&
            (identical(other.driver2, driver2) || other.driver2 == driver2) &&
            (identical(other.jamload, jamload) || other.jamload == jamload) &&
            (identical(other.gate, gate) || other.gate == gate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.tipe, tipe) || other.tipe == tipe) &&
            (identical(other.ket, ket) || other.ket == ket) &&
            (identical(other.program, program) || other.program == program) &&
            (identical(other.cDate, cDate) || other.cDate == cDate) &&
            (identical(other.cUser, cUser) || other.cUser == cUser) &&
            (identical(other.uDate, uDate) || other.uDate == uDate) &&
            (identical(other.uUser, uUser) || other.uUser == uUser) &&
            (identical(other.tglBerangkat, tglBerangkat) ||
                other.tglBerangkat == tglBerangkat));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      idKrChk,
      idSpk,
      nopol,
      driver1,
      driver2,
      jamload,
      gate,
      status,
      tipe,
      ket,
      program,
      cDate,
      cUser,
      uDate,
      uUser,
      tglBerangkat);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HistoryCheckSheetCopyWith<_$_HistoryCheckSheet> get copyWith =>
      __$$_HistoryCheckSheetCopyWithImpl<_$_HistoryCheckSheet>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HistoryCheckSheetToJson(
      this,
    );
  }
}

abstract class _HistoryCheckSheet implements HistoryCheckSheet {
  factory _HistoryCheckSheet(
      {@JsonKey(name: 'id_kr_chk') required final int? idKrChk,
      @JsonKey(name: 'id_spk') required final int? idSpk,
      required final String? nopol,
      required final String? driver1,
      required final String? driver2,
      required final String? jamload,
      required final String? gate,
      required final String? status,
      required final String? tipe,
      required final String? ket,
      required final int? program,
      @JsonKey(name: 'c_date') required final String? cDate,
      @JsonKey(name: 'c_user') required final String? cUser,
      @JsonKey(name: 'u_date') required final String? uDate,
      @JsonKey(name: 'u_user') required final String? uUser,
      @JsonKey(name: 'tgl_berangkat')
      required final String? tglBerangkat}) = _$_HistoryCheckSheet;

  factory _HistoryCheckSheet.fromJson(Map<String, dynamic> json) =
      _$_HistoryCheckSheet.fromJson;

  @override
  @JsonKey(name: 'id_kr_chk')
  int? get idKrChk;
  @override
  @JsonKey(name: 'id_spk')
  int? get idSpk;
  @override
  String? get nopol;
  @override
  String? get driver1;
  @override
  String? get driver2;
  @override
  String? get jamload;
  @override
  String? get gate;
  @override
  String? get status;
  @override
  String? get tipe;
  @override
  String? get ket;
  @override
  int? get program;
  @override
  @JsonKey(name: 'c_date')
  String? get cDate;
  @override
  @JsonKey(name: 'c_user')
  String? get cUser;
  @override
  @JsonKey(name: 'u_date')
  String? get uDate;
  @override
  @JsonKey(name: 'u_user')
  String? get uUser;
  @override
  @JsonKey(name: 'tgl_berangkat')
  String? get tglBerangkat;
  @override
  @JsonKey(ignore: true)
  _$$_HistoryCheckSheetCopyWith<_$_HistoryCheckSheet> get copyWith =>
      throw _privateConstructorUsedError;
}

HistoryCSUOk _$HistoryCSUOkFromJson(Map<String, dynamic> json) {
  return _HistoryCSUOk.fromJson(json);
}

/// @nodoc
mixin _$HistoryCSUOk {
  @JsonKey(name: 'id_cs')
  int? get idCs => throw _privateConstructorUsedError;
  @JsonKey(name: 'id_gate')
  int? get idGate => throw _privateConstructorUsedError;
  @JsonKey(name: 'id_user')
  int? get idUser => throw _privateConstructorUsedError;
  String? get frame => throw _privateConstructorUsedError;
  bool? get inout => throw _privateConstructorUsedError;
  String? get tgl => throw _privateConstructorUsedError;
  String? get ket => throw _privateConstructorUsedError;
  @JsonKey(name: 'c_date')
  String? get cDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'c_user')
  String? get cUser => throw _privateConstructorUsedError;
  @JsonKey(name: 'u_date')
  String? get uDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'u_user')
  String? get uUser => throw _privateConstructorUsedError;
  @JsonKey(name: 'no_defect')
  int? get noDefect => throw _privateConstructorUsedError;
  String? get supir1 => throw _privateConstructorUsedError;
  String? get supir2 => throw _privateConstructorUsedError;
  String? get posisi => throw _privateConstructorUsedError;
  @JsonKey(name: 'supir_sdr')
  String? get supirSdr => throw _privateConstructorUsedError;
  String? get remarks => throw _privateConstructorUsedError;
  @JsonKey(name: 'tgl_kirim_unit')
  String? get tglKirimUnit => throw _privateConstructorUsedError;
  @JsonKey(name: 'tgl_terima_unit')
  String? get tglTerimaUnit => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HistoryCSUOkCopyWith<HistoryCSUOk> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryCSUOkCopyWith<$Res> {
  factory $HistoryCSUOkCopyWith(
          HistoryCSUOk value, $Res Function(HistoryCSUOk) then) =
      _$HistoryCSUOkCopyWithImpl<$Res, HistoryCSUOk>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id_cs') int? idCs,
      @JsonKey(name: 'id_gate') int? idGate,
      @JsonKey(name: 'id_user') int? idUser,
      String? frame,
      bool? inout,
      String? tgl,
      String? ket,
      @JsonKey(name: 'c_date') String? cDate,
      @JsonKey(name: 'c_user') String? cUser,
      @JsonKey(name: 'u_date') String? uDate,
      @JsonKey(name: 'u_user') String? uUser,
      @JsonKey(name: 'no_defect') int? noDefect,
      String? supir1,
      String? supir2,
      String? posisi,
      @JsonKey(name: 'supir_sdr') String? supirSdr,
      String? remarks,
      @JsonKey(name: 'tgl_kirim_unit') String? tglKirimUnit,
      @JsonKey(name: 'tgl_terima_unit') String? tglTerimaUnit});
}

/// @nodoc
class _$HistoryCSUOkCopyWithImpl<$Res, $Val extends HistoryCSUOk>
    implements $HistoryCSUOkCopyWith<$Res> {
  _$HistoryCSUOkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idCs = freezed,
    Object? idGate = freezed,
    Object? idUser = freezed,
    Object? frame = freezed,
    Object? inout = freezed,
    Object? tgl = freezed,
    Object? ket = freezed,
    Object? cDate = freezed,
    Object? cUser = freezed,
    Object? uDate = freezed,
    Object? uUser = freezed,
    Object? noDefect = freezed,
    Object? supir1 = freezed,
    Object? supir2 = freezed,
    Object? posisi = freezed,
    Object? supirSdr = freezed,
    Object? remarks = freezed,
    Object? tglKirimUnit = freezed,
    Object? tglTerimaUnit = freezed,
  }) {
    return _then(_value.copyWith(
      idCs: freezed == idCs
          ? _value.idCs
          : idCs // ignore: cast_nullable_to_non_nullable
              as int?,
      idGate: freezed == idGate
          ? _value.idGate
          : idGate // ignore: cast_nullable_to_non_nullable
              as int?,
      idUser: freezed == idUser
          ? _value.idUser
          : idUser // ignore: cast_nullable_to_non_nullable
              as int?,
      frame: freezed == frame
          ? _value.frame
          : frame // ignore: cast_nullable_to_non_nullable
              as String?,
      inout: freezed == inout
          ? _value.inout
          : inout // ignore: cast_nullable_to_non_nullable
              as bool?,
      tgl: freezed == tgl
          ? _value.tgl
          : tgl // ignore: cast_nullable_to_non_nullable
              as String?,
      ket: freezed == ket
          ? _value.ket
          : ket // ignore: cast_nullable_to_non_nullable
              as String?,
      cDate: freezed == cDate
          ? _value.cDate
          : cDate // ignore: cast_nullable_to_non_nullable
              as String?,
      cUser: freezed == cUser
          ? _value.cUser
          : cUser // ignore: cast_nullable_to_non_nullable
              as String?,
      uDate: freezed == uDate
          ? _value.uDate
          : uDate // ignore: cast_nullable_to_non_nullable
              as String?,
      uUser: freezed == uUser
          ? _value.uUser
          : uUser // ignore: cast_nullable_to_non_nullable
              as String?,
      noDefect: freezed == noDefect
          ? _value.noDefect
          : noDefect // ignore: cast_nullable_to_non_nullable
              as int?,
      supir1: freezed == supir1
          ? _value.supir1
          : supir1 // ignore: cast_nullable_to_non_nullable
              as String?,
      supir2: freezed == supir2
          ? _value.supir2
          : supir2 // ignore: cast_nullable_to_non_nullable
              as String?,
      posisi: freezed == posisi
          ? _value.posisi
          : posisi // ignore: cast_nullable_to_non_nullable
              as String?,
      supirSdr: freezed == supirSdr
          ? _value.supirSdr
          : supirSdr // ignore: cast_nullable_to_non_nullable
              as String?,
      remarks: freezed == remarks
          ? _value.remarks
          : remarks // ignore: cast_nullable_to_non_nullable
              as String?,
      tglKirimUnit: freezed == tglKirimUnit
          ? _value.tglKirimUnit
          : tglKirimUnit // ignore: cast_nullable_to_non_nullable
              as String?,
      tglTerimaUnit: freezed == tglTerimaUnit
          ? _value.tglTerimaUnit
          : tglTerimaUnit // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HistoryCSUOkCopyWith<$Res>
    implements $HistoryCSUOkCopyWith<$Res> {
  factory _$$_HistoryCSUOkCopyWith(
          _$_HistoryCSUOk value, $Res Function(_$_HistoryCSUOk) then) =
      __$$_HistoryCSUOkCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id_cs') int? idCs,
      @JsonKey(name: 'id_gate') int? idGate,
      @JsonKey(name: 'id_user') int? idUser,
      String? frame,
      bool? inout,
      String? tgl,
      String? ket,
      @JsonKey(name: 'c_date') String? cDate,
      @JsonKey(name: 'c_user') String? cUser,
      @JsonKey(name: 'u_date') String? uDate,
      @JsonKey(name: 'u_user') String? uUser,
      @JsonKey(name: 'no_defect') int? noDefect,
      String? supir1,
      String? supir2,
      String? posisi,
      @JsonKey(name: 'supir_sdr') String? supirSdr,
      String? remarks,
      @JsonKey(name: 'tgl_kirim_unit') String? tglKirimUnit,
      @JsonKey(name: 'tgl_terima_unit') String? tglTerimaUnit});
}

/// @nodoc
class __$$_HistoryCSUOkCopyWithImpl<$Res>
    extends _$HistoryCSUOkCopyWithImpl<$Res, _$_HistoryCSUOk>
    implements _$$_HistoryCSUOkCopyWith<$Res> {
  __$$_HistoryCSUOkCopyWithImpl(
      _$_HistoryCSUOk _value, $Res Function(_$_HistoryCSUOk) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idCs = freezed,
    Object? idGate = freezed,
    Object? idUser = freezed,
    Object? frame = freezed,
    Object? inout = freezed,
    Object? tgl = freezed,
    Object? ket = freezed,
    Object? cDate = freezed,
    Object? cUser = freezed,
    Object? uDate = freezed,
    Object? uUser = freezed,
    Object? noDefect = freezed,
    Object? supir1 = freezed,
    Object? supir2 = freezed,
    Object? posisi = freezed,
    Object? supirSdr = freezed,
    Object? remarks = freezed,
    Object? tglKirimUnit = freezed,
    Object? tglTerimaUnit = freezed,
  }) {
    return _then(_$_HistoryCSUOk(
      idCs: freezed == idCs
          ? _value.idCs
          : idCs // ignore: cast_nullable_to_non_nullable
              as int?,
      idGate: freezed == idGate
          ? _value.idGate
          : idGate // ignore: cast_nullable_to_non_nullable
              as int?,
      idUser: freezed == idUser
          ? _value.idUser
          : idUser // ignore: cast_nullable_to_non_nullable
              as int?,
      frame: freezed == frame
          ? _value.frame
          : frame // ignore: cast_nullable_to_non_nullable
              as String?,
      inout: freezed == inout
          ? _value.inout
          : inout // ignore: cast_nullable_to_non_nullable
              as bool?,
      tgl: freezed == tgl
          ? _value.tgl
          : tgl // ignore: cast_nullable_to_non_nullable
              as String?,
      ket: freezed == ket
          ? _value.ket
          : ket // ignore: cast_nullable_to_non_nullable
              as String?,
      cDate: freezed == cDate
          ? _value.cDate
          : cDate // ignore: cast_nullable_to_non_nullable
              as String?,
      cUser: freezed == cUser
          ? _value.cUser
          : cUser // ignore: cast_nullable_to_non_nullable
              as String?,
      uDate: freezed == uDate
          ? _value.uDate
          : uDate // ignore: cast_nullable_to_non_nullable
              as String?,
      uUser: freezed == uUser
          ? _value.uUser
          : uUser // ignore: cast_nullable_to_non_nullable
              as String?,
      noDefect: freezed == noDefect
          ? _value.noDefect
          : noDefect // ignore: cast_nullable_to_non_nullable
              as int?,
      supir1: freezed == supir1
          ? _value.supir1
          : supir1 // ignore: cast_nullable_to_non_nullable
              as String?,
      supir2: freezed == supir2
          ? _value.supir2
          : supir2 // ignore: cast_nullable_to_non_nullable
              as String?,
      posisi: freezed == posisi
          ? _value.posisi
          : posisi // ignore: cast_nullable_to_non_nullable
              as String?,
      supirSdr: freezed == supirSdr
          ? _value.supirSdr
          : supirSdr // ignore: cast_nullable_to_non_nullable
              as String?,
      remarks: freezed == remarks
          ? _value.remarks
          : remarks // ignore: cast_nullable_to_non_nullable
              as String?,
      tglKirimUnit: freezed == tglKirimUnit
          ? _value.tglKirimUnit
          : tglKirimUnit // ignore: cast_nullable_to_non_nullable
              as String?,
      tglTerimaUnit: freezed == tglTerimaUnit
          ? _value.tglTerimaUnit
          : tglTerimaUnit // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_HistoryCSUOk implements _HistoryCSUOk {
  _$_HistoryCSUOk(
      {@JsonKey(name: 'id_cs') required this.idCs,
      @JsonKey(name: 'id_gate') required this.idGate,
      @JsonKey(name: 'id_user') required this.idUser,
      required this.frame,
      required this.inout,
      required this.tgl,
      required this.ket,
      @JsonKey(name: 'c_date') required this.cDate,
      @JsonKey(name: 'c_user') required this.cUser,
      @JsonKey(name: 'u_date') required this.uDate,
      @JsonKey(name: 'u_user') required this.uUser,
      @JsonKey(name: 'no_defect') required this.noDefect,
      required this.supir1,
      required this.supir2,
      required this.posisi,
      @JsonKey(name: 'supir_sdr') required this.supirSdr,
      required this.remarks,
      @JsonKey(name: 'tgl_kirim_unit') required this.tglKirimUnit,
      @JsonKey(name: 'tgl_terima_unit') required this.tglTerimaUnit});

  factory _$_HistoryCSUOk.fromJson(Map<String, dynamic> json) =>
      _$$_HistoryCSUOkFromJson(json);

  @override
  @JsonKey(name: 'id_cs')
  final int? idCs;
  @override
  @JsonKey(name: 'id_gate')
  final int? idGate;
  @override
  @JsonKey(name: 'id_user')
  final int? idUser;
  @override
  final String? frame;
  @override
  final bool? inout;
  @override
  final String? tgl;
  @override
  final String? ket;
  @override
  @JsonKey(name: 'c_date')
  final String? cDate;
  @override
  @JsonKey(name: 'c_user')
  final String? cUser;
  @override
  @JsonKey(name: 'u_date')
  final String? uDate;
  @override
  @JsonKey(name: 'u_user')
  final String? uUser;
  @override
  @JsonKey(name: 'no_defect')
  final int? noDefect;
  @override
  final String? supir1;
  @override
  final String? supir2;
  @override
  final String? posisi;
  @override
  @JsonKey(name: 'supir_sdr')
  final String? supirSdr;
  @override
  final String? remarks;
  @override
  @JsonKey(name: 'tgl_kirim_unit')
  final String? tglKirimUnit;
  @override
  @JsonKey(name: 'tgl_terima_unit')
  final String? tglTerimaUnit;

  @override
  String toString() {
    return 'HistoryCSUOk(idCs: $idCs, idGate: $idGate, idUser: $idUser, frame: $frame, inout: $inout, tgl: $tgl, ket: $ket, cDate: $cDate, cUser: $cUser, uDate: $uDate, uUser: $uUser, noDefect: $noDefect, supir1: $supir1, supir2: $supir2, posisi: $posisi, supirSdr: $supirSdr, remarks: $remarks, tglKirimUnit: $tglKirimUnit, tglTerimaUnit: $tglTerimaUnit)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HistoryCSUOk &&
            (identical(other.idCs, idCs) || other.idCs == idCs) &&
            (identical(other.idGate, idGate) || other.idGate == idGate) &&
            (identical(other.idUser, idUser) || other.idUser == idUser) &&
            (identical(other.frame, frame) || other.frame == frame) &&
            (identical(other.inout, inout) || other.inout == inout) &&
            (identical(other.tgl, tgl) || other.tgl == tgl) &&
            (identical(other.ket, ket) || other.ket == ket) &&
            (identical(other.cDate, cDate) || other.cDate == cDate) &&
            (identical(other.cUser, cUser) || other.cUser == cUser) &&
            (identical(other.uDate, uDate) || other.uDate == uDate) &&
            (identical(other.uUser, uUser) || other.uUser == uUser) &&
            (identical(other.noDefect, noDefect) ||
                other.noDefect == noDefect) &&
            (identical(other.supir1, supir1) || other.supir1 == supir1) &&
            (identical(other.supir2, supir2) || other.supir2 == supir2) &&
            (identical(other.posisi, posisi) || other.posisi == posisi) &&
            (identical(other.supirSdr, supirSdr) ||
                other.supirSdr == supirSdr) &&
            (identical(other.remarks, remarks) || other.remarks == remarks) &&
            (identical(other.tglKirimUnit, tglKirimUnit) ||
                other.tglKirimUnit == tglKirimUnit) &&
            (identical(other.tglTerimaUnit, tglTerimaUnit) ||
                other.tglTerimaUnit == tglTerimaUnit));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        idCs,
        idGate,
        idUser,
        frame,
        inout,
        tgl,
        ket,
        cDate,
        cUser,
        uDate,
        uUser,
        noDefect,
        supir1,
        supir2,
        posisi,
        supirSdr,
        remarks,
        tglKirimUnit,
        tglTerimaUnit
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HistoryCSUOkCopyWith<_$_HistoryCSUOk> get copyWith =>
      __$$_HistoryCSUOkCopyWithImpl<_$_HistoryCSUOk>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HistoryCSUOkToJson(
      this,
    );
  }
}

abstract class _HistoryCSUOk implements HistoryCSUOk {
  factory _HistoryCSUOk(
      {@JsonKey(name: 'id_cs') required final int? idCs,
      @JsonKey(name: 'id_gate') required final int? idGate,
      @JsonKey(name: 'id_user') required final int? idUser,
      required final String? frame,
      required final bool? inout,
      required final String? tgl,
      required final String? ket,
      @JsonKey(name: 'c_date') required final String? cDate,
      @JsonKey(name: 'c_user') required final String? cUser,
      @JsonKey(name: 'u_date') required final String? uDate,
      @JsonKey(name: 'u_user') required final String? uUser,
      @JsonKey(name: 'no_defect') required final int? noDefect,
      required final String? supir1,
      required final String? supir2,
      required final String? posisi,
      @JsonKey(name: 'supir_sdr') required final String? supirSdr,
      required final String? remarks,
      @JsonKey(name: 'tgl_kirim_unit') required final String? tglKirimUnit,
      @JsonKey(name: 'tgl_terima_unit')
      required final String? tglTerimaUnit}) = _$_HistoryCSUOk;

  factory _HistoryCSUOk.fromJson(Map<String, dynamic> json) =
      _$_HistoryCSUOk.fromJson;

  @override
  @JsonKey(name: 'id_cs')
  int? get idCs;
  @override
  @JsonKey(name: 'id_gate')
  int? get idGate;
  @override
  @JsonKey(name: 'id_user')
  int? get idUser;
  @override
  String? get frame;
  @override
  bool? get inout;
  @override
  String? get tgl;
  @override
  String? get ket;
  @override
  @JsonKey(name: 'c_date')
  String? get cDate;
  @override
  @JsonKey(name: 'c_user')
  String? get cUser;
  @override
  @JsonKey(name: 'u_date')
  String? get uDate;
  @override
  @JsonKey(name: 'u_user')
  String? get uUser;
  @override
  @JsonKey(name: 'no_defect')
  int? get noDefect;
  @override
  String? get supir1;
  @override
  String? get supir2;
  @override
  String? get posisi;
  @override
  @JsonKey(name: 'supir_sdr')
  String? get supirSdr;
  @override
  String? get remarks;
  @override
  @JsonKey(name: 'tgl_kirim_unit')
  String? get tglKirimUnit;
  @override
  @JsonKey(name: 'tgl_terima_unit')
  String? get tglTerimaUnit;
  @override
  @JsonKey(ignore: true)
  _$$_HistoryCSUOkCopyWith<_$_HistoryCSUOk> get copyWith =>
      throw _privateConstructorUsedError;
}

HistoryCSUNg _$HistoryCSUNgFromJson(Map<String, dynamic> json) {
  return _HistoryCSUNg.fromJson(json);
}

/// @nodoc
mixin _$HistoryCSUNg {
  @JsonKey(name: 'id_cs')
  int? get idCs => throw _privateConstructorUsedError;
  @JsonKey(name: 'id_item')
  int? get idItem => throw _privateConstructorUsedError;
  @JsonKey(name: 'id_jns_defect')
  int? get idJnsDefect => throw _privateConstructorUsedError;
  @JsonKey(name: 'id_p_defect')
  int? get idPDefect => throw _privateConstructorUsedError;
  @JsonKey(name: 'c_date')
  String? get cDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'c_user')
  String? get cUser => throw _privateConstructorUsedError;
  @JsonKey(name: 'u_date')
  String? get uDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'u_user')
  String? get uUser => throw _privateConstructorUsedError;
  String? get frame => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HistoryCSUNgCopyWith<HistoryCSUNg> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryCSUNgCopyWith<$Res> {
  factory $HistoryCSUNgCopyWith(
          HistoryCSUNg value, $Res Function(HistoryCSUNg) then) =
      _$HistoryCSUNgCopyWithImpl<$Res, HistoryCSUNg>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id_cs') int? idCs,
      @JsonKey(name: 'id_item') int? idItem,
      @JsonKey(name: 'id_jns_defect') int? idJnsDefect,
      @JsonKey(name: 'id_p_defect') int? idPDefect,
      @JsonKey(name: 'c_date') String? cDate,
      @JsonKey(name: 'c_user') String? cUser,
      @JsonKey(name: 'u_date') String? uDate,
      @JsonKey(name: 'u_user') String? uUser,
      String? frame});
}

/// @nodoc
class _$HistoryCSUNgCopyWithImpl<$Res, $Val extends HistoryCSUNg>
    implements $HistoryCSUNgCopyWith<$Res> {
  _$HistoryCSUNgCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idCs = freezed,
    Object? idItem = freezed,
    Object? idJnsDefect = freezed,
    Object? idPDefect = freezed,
    Object? cDate = freezed,
    Object? cUser = freezed,
    Object? uDate = freezed,
    Object? uUser = freezed,
    Object? frame = freezed,
  }) {
    return _then(_value.copyWith(
      idCs: freezed == idCs
          ? _value.idCs
          : idCs // ignore: cast_nullable_to_non_nullable
              as int?,
      idItem: freezed == idItem
          ? _value.idItem
          : idItem // ignore: cast_nullable_to_non_nullable
              as int?,
      idJnsDefect: freezed == idJnsDefect
          ? _value.idJnsDefect
          : idJnsDefect // ignore: cast_nullable_to_non_nullable
              as int?,
      idPDefect: freezed == idPDefect
          ? _value.idPDefect
          : idPDefect // ignore: cast_nullable_to_non_nullable
              as int?,
      cDate: freezed == cDate
          ? _value.cDate
          : cDate // ignore: cast_nullable_to_non_nullable
              as String?,
      cUser: freezed == cUser
          ? _value.cUser
          : cUser // ignore: cast_nullable_to_non_nullable
              as String?,
      uDate: freezed == uDate
          ? _value.uDate
          : uDate // ignore: cast_nullable_to_non_nullable
              as String?,
      uUser: freezed == uUser
          ? _value.uUser
          : uUser // ignore: cast_nullable_to_non_nullable
              as String?,
      frame: freezed == frame
          ? _value.frame
          : frame // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HistoryCSUNgCopyWith<$Res>
    implements $HistoryCSUNgCopyWith<$Res> {
  factory _$$_HistoryCSUNgCopyWith(
          _$_HistoryCSUNg value, $Res Function(_$_HistoryCSUNg) then) =
      __$$_HistoryCSUNgCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id_cs') int? idCs,
      @JsonKey(name: 'id_item') int? idItem,
      @JsonKey(name: 'id_jns_defect') int? idJnsDefect,
      @JsonKey(name: 'id_p_defect') int? idPDefect,
      @JsonKey(name: 'c_date') String? cDate,
      @JsonKey(name: 'c_user') String? cUser,
      @JsonKey(name: 'u_date') String? uDate,
      @JsonKey(name: 'u_user') String? uUser,
      String? frame});
}

/// @nodoc
class __$$_HistoryCSUNgCopyWithImpl<$Res>
    extends _$HistoryCSUNgCopyWithImpl<$Res, _$_HistoryCSUNg>
    implements _$$_HistoryCSUNgCopyWith<$Res> {
  __$$_HistoryCSUNgCopyWithImpl(
      _$_HistoryCSUNg _value, $Res Function(_$_HistoryCSUNg) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idCs = freezed,
    Object? idItem = freezed,
    Object? idJnsDefect = freezed,
    Object? idPDefect = freezed,
    Object? cDate = freezed,
    Object? cUser = freezed,
    Object? uDate = freezed,
    Object? uUser = freezed,
    Object? frame = freezed,
  }) {
    return _then(_$_HistoryCSUNg(
      idCs: freezed == idCs
          ? _value.idCs
          : idCs // ignore: cast_nullable_to_non_nullable
              as int?,
      idItem: freezed == idItem
          ? _value.idItem
          : idItem // ignore: cast_nullable_to_non_nullable
              as int?,
      idJnsDefect: freezed == idJnsDefect
          ? _value.idJnsDefect
          : idJnsDefect // ignore: cast_nullable_to_non_nullable
              as int?,
      idPDefect: freezed == idPDefect
          ? _value.idPDefect
          : idPDefect // ignore: cast_nullable_to_non_nullable
              as int?,
      cDate: freezed == cDate
          ? _value.cDate
          : cDate // ignore: cast_nullable_to_non_nullable
              as String?,
      cUser: freezed == cUser
          ? _value.cUser
          : cUser // ignore: cast_nullable_to_non_nullable
              as String?,
      uDate: freezed == uDate
          ? _value.uDate
          : uDate // ignore: cast_nullable_to_non_nullable
              as String?,
      uUser: freezed == uUser
          ? _value.uUser
          : uUser // ignore: cast_nullable_to_non_nullable
              as String?,
      frame: freezed == frame
          ? _value.frame
          : frame // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_HistoryCSUNg implements _HistoryCSUNg {
  _$_HistoryCSUNg(
      {@JsonKey(name: 'id_cs') required this.idCs,
      @JsonKey(name: 'id_item') required this.idItem,
      @JsonKey(name: 'id_jns_defect') required this.idJnsDefect,
      @JsonKey(name: 'id_p_defect') required this.idPDefect,
      @JsonKey(name: 'c_date') required this.cDate,
      @JsonKey(name: 'c_user') required this.cUser,
      @JsonKey(name: 'u_date') required this.uDate,
      @JsonKey(name: 'u_user') required this.uUser,
      required this.frame});

  factory _$_HistoryCSUNg.fromJson(Map<String, dynamic> json) =>
      _$$_HistoryCSUNgFromJson(json);

  @override
  @JsonKey(name: 'id_cs')
  final int? idCs;
  @override
  @JsonKey(name: 'id_item')
  final int? idItem;
  @override
  @JsonKey(name: 'id_jns_defect')
  final int? idJnsDefect;
  @override
  @JsonKey(name: 'id_p_defect')
  final int? idPDefect;
  @override
  @JsonKey(name: 'c_date')
  final String? cDate;
  @override
  @JsonKey(name: 'c_user')
  final String? cUser;
  @override
  @JsonKey(name: 'u_date')
  final String? uDate;
  @override
  @JsonKey(name: 'u_user')
  final String? uUser;
  @override
  final String? frame;

  @override
  String toString() {
    return 'HistoryCSUNg(idCs: $idCs, idItem: $idItem, idJnsDefect: $idJnsDefect, idPDefect: $idPDefect, cDate: $cDate, cUser: $cUser, uDate: $uDate, uUser: $uUser, frame: $frame)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HistoryCSUNg &&
            (identical(other.idCs, idCs) || other.idCs == idCs) &&
            (identical(other.idItem, idItem) || other.idItem == idItem) &&
            (identical(other.idJnsDefect, idJnsDefect) ||
                other.idJnsDefect == idJnsDefect) &&
            (identical(other.idPDefect, idPDefect) ||
                other.idPDefect == idPDefect) &&
            (identical(other.cDate, cDate) || other.cDate == cDate) &&
            (identical(other.cUser, cUser) || other.cUser == cUser) &&
            (identical(other.uDate, uDate) || other.uDate == uDate) &&
            (identical(other.uUser, uUser) || other.uUser == uUser) &&
            (identical(other.frame, frame) || other.frame == frame));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, idCs, idItem, idJnsDefect,
      idPDefect, cDate, cUser, uDate, uUser, frame);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HistoryCSUNgCopyWith<_$_HistoryCSUNg> get copyWith =>
      __$$_HistoryCSUNgCopyWithImpl<_$_HistoryCSUNg>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HistoryCSUNgToJson(
      this,
    );
  }
}

abstract class _HistoryCSUNg implements HistoryCSUNg {
  factory _HistoryCSUNg(
      {@JsonKey(name: 'id_cs') required final int? idCs,
      @JsonKey(name: 'id_item') required final int? idItem,
      @JsonKey(name: 'id_jns_defect') required final int? idJnsDefect,
      @JsonKey(name: 'id_p_defect') required final int? idPDefect,
      @JsonKey(name: 'c_date') required final String? cDate,
      @JsonKey(name: 'c_user') required final String? cUser,
      @JsonKey(name: 'u_date') required final String? uDate,
      @JsonKey(name: 'u_user') required final String? uUser,
      required final String? frame}) = _$_HistoryCSUNg;

  factory _HistoryCSUNg.fromJson(Map<String, dynamic> json) =
      _$_HistoryCSUNg.fromJson;

  @override
  @JsonKey(name: 'id_cs')
  int? get idCs;
  @override
  @JsonKey(name: 'id_item')
  int? get idItem;
  @override
  @JsonKey(name: 'id_jns_defect')
  int? get idJnsDefect;
  @override
  @JsonKey(name: 'id_p_defect')
  int? get idPDefect;
  @override
  @JsonKey(name: 'c_date')
  String? get cDate;
  @override
  @JsonKey(name: 'c_user')
  String? get cUser;
  @override
  @JsonKey(name: 'u_date')
  String? get uDate;
  @override
  @JsonKey(name: 'u_user')
  String? get uUser;
  @override
  String? get frame;
  @override
  @JsonKey(ignore: true)
  _$$_HistoryCSUNgCopyWith<_$_HistoryCSUNg> get copyWith =>
      throw _privateConstructorUsedError;
}
