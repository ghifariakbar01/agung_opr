import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/infrastructure/dio_extensions.dart';
import 'package:agung_opr/infrastructure/exceptions.dart';
import 'package:dio/dio.dart';

import '../../application/model/model.dart';

class ModelRemoteService {
  ModelRemoteService(this._dio, this._dioRequestNotifier);

  final Dio _dio;
  final Map<String, String> _dioRequestNotifier;

  Future<List<Model>> searchModelList(
      {required String search, required bool includeParts}) async {
    try {
      final data = _dioRequestNotifier;

      data.addAll({
        "mode": "SELECT",
        "command": "SELECT arap_mst_kend_type.id_kend_type AS id, " +
            " arap_mst_kend_merk.nama AS merk, arap_mst_kend_type.nama, arap_mst_kend_type.grossweight, " +
            "arap_mst_kend_type.measurement, arap_mst_kend_cat.nama AS category FROM arap_mst_kend_type " +
            " LEFT JOIN arap_mst_kend_merk ON arap_mst_kend_merk.id_kend_merk = arap_mst_kend_type.id_kend_merk " +
            "LEFT JOIN arap_mst_kend_cat ON arap_mst_kend_cat.id_kend_cat = arap_mst_kend_type.id_kend_cat " +
            " WHERE  ${includeParts == false ? " arap_mst_kend_type.nama NOT LIKE '%parts%' AND " : ' '} " +
            " arap_mst_kend_type.nama LIKE '%$search%'  " +
            " OR arap_mst_kend_merk.nama LIKE '%$search%' OR arap_mst_kend_type.grossweight LIKE '%$search%' " +
            " OR arap_mst_kend_type.measurement LIKE '%$search%' OR arap_mst_kend_cat.nama LIKE '%$search%' " +
            " ORDER BY arap_mst_kend_type.c_date ASC OFFSET 0 ROWS FETCH FIRST 100 ROWS ONLY ",
      });

      final response = await _dio.post('',
          data: jsonEncode(data), options: Options(contentType: 'text/plain'));

      final items = response.data?[0];

      if (items['status'] == 'Success') {
        final listExist = items['items'] != null && items['items'] is List;

        if (listExist) {
          final list = items['items'] as List<dynamic>;

          if (list.isNotEmpty) {
            try {
              List<Model> modelList =
                  (list).map((data) => Model.fromJson(data)).toList();

              // log('list $list');

              return modelList;
            } catch (e) {
              log('list error $e');

              throw FormatException('error while iterating list model');
            }
          } else {
            log('list empty');

            return [];
          }
        } else {
          log('list empty');

          return [];
        }
      } else {
        final message = items['error'] as String?;
        final errorNum = items['errornum'] as int?;

        throw RestApiException(errorNum, message);
      }
    } on DioError catch (e) {
      if (e.isNoConnectionError || e.isConnectionTimeout) {
        throw NoConnectionException();
      } else if (e.response != null) {
        final items = e.response?.data?[0];

        final message = items['error'] as String?;
        final errorNum = items['errornum'] as int?;

        throw RestApiException(errorNum, message);
      } else {
        rethrow;
      }
    }
  }

  Future<List<Model>> getModelList({required int page}) async {
    try {
      final data = _dioRequestNotifier;

      data.addAll({
        "mode": "SELECT",
        "command": " SELECT arap_mst_kend_type.id_kend_type AS id, arap_mst_kend_merk.nama AS merk, arap_mst_kend_type.nama, " +
            " arap_mst_kend_type.grossweight, arap_mst_kend_type.measurement, arap_mst_kend_cat.nama AS category FROM " +
            " arap_mst_kend_type LEFT JOIN arap_mst_kend_merk ON arap_mst_kend_merk.id_kend_merk = arap_mst_kend_type.id_kend_merk " +
            " LEFT JOIN arap_mst_kend_cat ON arap_mst_kend_cat.id_kend_cat = arap_mst_kend_type.id_kend_cat " +
            " ORDER BY arap_mst_kend_type.c_date ASC OFFSET ${page}00 ROWS FETCH FIRST 100 ROWS ONLY",
      });

      final response = await _dio.post('',
          data: jsonEncode(data), options: Options(contentType: 'text/plain'));

      final items = response.data?[0];

      if (items['status'] == 'Success') {
        final listExist = items['items'] != null && items['items'] is List;

        if (listExist) {
          final list = items['items'] as List<dynamic>;

          if (list.isNotEmpty) {
            try {
              List<Model> modelList =
                  (list).map((data) => Model.fromJson(data)).toList();

              // log('list $list');

              return modelList;
            } catch (e) {
              log('list error $e');

              throw FormatException('error while iterating list model');
            }
          } else {
            log('list empty');

            return [];
          }
        } else {
          log('list empty');

          return [];
        }
      } else {
        final message = items['error'] as String?;
        final errorNum = items['errornum'] as int?;

        throw RestApiException(errorNum, message);
      }
    } on DioError catch (e) {
      if (e.isNoConnectionError || e.isConnectionTimeout) {
        throw NoConnectionException();
      } else if (e.response != null) {
        final items = e.response?.data?[0];

        final message = items['error'] as String?;
        final errorNum = items['errornum'] as int?;

        throw RestApiException(errorNum, message);
      } else {
        rethrow;
      }
    }
  }
}
