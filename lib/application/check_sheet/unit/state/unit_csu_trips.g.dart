// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_csu_trips.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UnitCSUTrips _$$_UnitCSUTripsFromJson(Map<String, dynamic> json) =>
    _$_UnitCSUTrips(
      idUnit: json['idUnit'] as int,
      csuResult: (json['csuResult'] as List<dynamic>)
          .map((e) => CSUTrips.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_UnitCSUTripsToJson(_$_UnitCSUTrips instance) =>
    <String, dynamic>{
      'idUnit': instance.idUnit,
      'csuResult': UnitCSUTrips.listToJson(instance.csuResult),
    };
