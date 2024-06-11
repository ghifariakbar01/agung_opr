import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/application/check_sheet/shared/state/cs_item.dart';
import 'package:agung_opr/infrastructure/dio_extensions.dart';
import 'package:agung_opr/infrastructure/exceptions.dart';
import 'package:dio/dio.dart';

import '../../application/check_sheet/shared/state/cs_jenis.dart';
import '../../application/update_cs_disable/disable.dart';
import '../../constants/constants.dart';

class CSRemoteService {
  CSRemoteService(this._dio, this._dioRequestNotifier);

  final Dio _dio;
  final Map<String, String> _dioRequestNotifier;

  Future<UpdateCsDisable> getCsDone({required int idSPK}) async {
    final String dbName =
        Constants.isTesting ? 'pool_chk_kr_test' : 'pool_chk_kr';

    try {
      final data = _dioRequestNotifier;

      data.addAll({
        "mode": "SELECT",
        "command": "SELECT tipe FROM $dbName WHERE id_spk = $idSPK",
      });

      final response = await _dio.post(
        '',
        data: jsonEncode(data),
        options: Options(contentType: 'text/plain'),
      );

      final items = response.data?[0];

      if (items['status'] == 'Success') {
        final listExist = items['items'] != null && items['items'] is List;

        if (listExist) {
          final list = items['items'] as List<dynamic>;

          if (list.isNotEmpty) {
            try {
              bool _loading = false;
              bool _unload = false;
              bool _loadunload = false;

              for (final e in list) {
                if (e['tipe'] == 'loading') {
                  _loading = true;
                }

                if (e['tipe'] == 'unload') {
                  _unload = true;
                }

                if (e['tipe'] == 'loadunload') {
                  _loadunload = true;
                }
              }

              return UpdateCsDisable.inital().copyWith(
                loading: _loading,
                unload: _unload,
                loadunload: _loadunload,
              );
            } catch (e) {
              throw FormatException('error while iterating list getCsDone');
            }
          } else {
            return UpdateCsDisable.inital();
          }
        } else {
          return UpdateCsDisable.inital();
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
