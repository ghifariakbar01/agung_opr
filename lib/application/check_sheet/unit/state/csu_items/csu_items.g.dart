// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'csu_items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CSUItems _$$_CSUItemsFromJson(Map<String, dynamic> json) => _$_CSUItems(
      id: json['id_item'] as int,
      NoUrut: json['NoUrut'] as int,
      ind: json['nama_ina'] as String?,
      eng: json['nama_eng'] as String?,
      Grup: json['Grup'] as String?,
    );

Map<String, dynamic> _$$_CSUItemsToJson(_$_CSUItems instance) =>
    <String, dynamic>{
      'id_item': instance.id,
      'NoUrut': instance.NoUrut,
      'nama_ina': instance.ind,
      'nama_eng': instance.eng,
      'Grup': instance.Grup,
    };
