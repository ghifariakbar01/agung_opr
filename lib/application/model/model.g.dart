// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Model _$$_ModelFromJson(Map<String, dynamic> json) => _$_Model(
      id: json['id'] as int,
      merk: json['merk'] as String?,
      nama: json['nama'] as String?,
      category: json['category'] as String?,
      grossweight: (json['grossweight'] as num?)?.toDouble(),
      measurement: (json['measurement'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$_ModelToJson(_$_Model instance) => <String, dynamic>{
      'id': instance.id,
      'merk': instance.merk,
      'nama': instance.nama,
      'category': instance.category,
      'grossweight': instance.grossweight,
      'measurement': instance.measurement,
    };
