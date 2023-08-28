// SELECT id_spk, spk_no, supir1_nm, supir2_nm, nopol FROM (SELECT id_spk, spk_no, supir1_nm, supir2_nm, nopol, ROW_NUMBER() OVER (PARTITION BY id_spk ORDER BY id_spk DESC) AS rn FROM opr_trs_spk WHERE dc_sta <> 1) AS ranked WHERE rn = 1 ORDER BY id_spk DESC OFFSET 0 ROWS FETCH FIRST 100 ROWS ONLY

import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/application/check_sheet/shared/state/cs_item.dart';
import 'package:agung_opr/infrastructure/dio_extensions.dart';
import 'package:agung_opr/infrastructure/exceptions.dart';
import 'package:dio/dio.dart';

import '../../application/check_sheet/shared/state/cs_jenis.dart';
import '../../application/check_sheet/shared/state/cs_result.dart';

class CSRemoteService {
  CSRemoteService(this._dio, this._dioRequestNotifier);

  final Dio _dio;
  final Map<String, String> _dioRequestNotifier;

  Future<List<CSResult>> getCSByIDSPK({required int idSPK}) async {
    const String dbName = 'pool_kr_list';

    try {
      final data = _dioRequestNotifier;

      data.addAll({
        "mode": "SELECT",
        "command": "SELECT id_list AS id, nama FROM $dbName",
      });

      final response = await _dio.post('',
          data: jsonEncode(data), options: Options(contentType: 'text/plain'));

      log('data ${jsonEncode(data)}');
      log('response getCSJenis $response');

      final items = response.data?[0];

      if (items['status'] == 'Success') {
        final listExist = items['items'] != null && items['items'] is List;

        if (listExist) {
          final list = items['items'] as List<dynamic>;

          if (list.isNotEmpty) {
            try {
              List<CSResult> csList =
                  (list).map((data) => CSResult.fromJson(data)).toList();

              log('LIST CS JENIS: $csList');

              return csList;
            } catch (e) {
              log('list error $e');

              throw FormatException('error while iterating list getCSJenis');
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

  Future<List<CSJenis>> getCSJenis() async {
    const String dbName = 'pool_kr_list';

    try {
      final data = _dioRequestNotifier;

      data.addAll({
        "mode": "SELECT",
        "command": "SELECT id_list AS id, nama FROM $dbName",
      });

      final response = await _dio.post('',
          data: jsonEncode(data), options: Options(contentType: 'text/plain'));

      log('data ${jsonEncode(data)}');
      log('response getCSJenis $response');

      final items = response.data?[0];

      if (items['status'] == 'Success') {
        final listExist = items['items'] != null && items['items'] is List;

        if (listExist) {
          final list = items['items'] as List<dynamic>;

          if (list.isNotEmpty) {
            try {
              List<CSJenis> csList =
                  (list).map((data) => CSJenis.fromJson(data)).toList();

              log('LIST CS JENIS: $csList');

              return csList;
            } catch (e) {
              log('list error $e');

              throw FormatException('error while iterating list getCSJenis');
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

  Future<List<CSItem>> getCSItems() async {
    const String dbName = 'pool_kr_list_dtl';

    try {
      final data = _dioRequestNotifier;

      data.addAll({
        "mode": "SELECT",
        "command":
            "SELECT id_list_dtl as id, id_list as idList, description, wewenang FROM $dbName",
      });

      final response = await _dio.post('',
          data: jsonEncode(data), options: Options(contentType: 'text/plain'));

      log('data ${jsonEncode(data)}');
      log('response getCSItems $response');

      final items = response.data?[0];

      if (items['status'] == 'Success') {
        final listExist = items['items'] != null && items['items'] is List;

        if (listExist) {
          final list = items['items'] as List<dynamic>;

          if (list.isNotEmpty) {
            try {
              List<CSItem> items =
                  (list).map((data) => CSItem.fromJson(data)).toList();

              log('LIST CS ITEMS: $items');

              return items;
            } catch (e) {
              log('list error $e');

              throw FormatException('error while iterating list getCSItems');
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
