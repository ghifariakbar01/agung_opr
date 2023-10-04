// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_History _$$_HistoryFromJson(Map<String, dynamic> json) => _$_History(
      idUser: json['id_user'] as int,
      query: json['query'] as String,
      content: json['content'] as String,
      cUser: json['c_user'] as String?,
      cDate: json['c_date'] as String?,
      sDate: json['s_date'] as String?,
    );

Map<String, dynamic> _$$_HistoryToJson(_$_History instance) =>
    <String, dynamic>{
      'id_user': instance.idUser,
      'query': instance.query,
      'content': instance.content,
      'c_user': instance.cUser,
      'c_date': instance.cDate,
      's_date': instance.sDate,
    };
