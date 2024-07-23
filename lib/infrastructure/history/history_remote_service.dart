import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/infrastructure/dio_extensions.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../../application/history/history.dart';
import '../../constants/constants.dart';
import '../exceptions.dart';

class HistoryRemoteService {
  HistoryRemoteService(this._dio, this._dioRequestNotifier);

  final Dio _dio;
  final Map<String, String> _dioRequestNotifier;

  Future<List<HistoryCheckSheet>> getHistoryCheckSheet({
    required String cUser,
    required String nopol,
    required DateTime start,
    required DateTime end,
  }) async {
    String dbName = Constants.isTesting ? 'pool_chk_kr_test' : 'pool_chk_kr';

    final startStr = DateFormat('yyyy-MM-dd').format(start);
    final endStr = DateFormat('yyyy-MM-dd').format(end);

    try {
      final data = _dioRequestNotifier;

      data.addAll({
        "mode": "SELECT",
        "command": "SELECT * FROM $dbName WHERE c_user = '$cUser' " +
            " AND nopol LIKE '%$nopol%' " +
            " AND c_date BETWEEN '$startStr' AND '$endStr' " +
            " ORDER BY c_date DESC OFFSET 0 ROWS FETCH FIRST 100 ROWS ONLY ",
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
              List<HistoryCheckSheet> histories = (list)
                  .map((data) => HistoryCheckSheet.fromJson(data))
                  .toList();

              return histories;
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

  Future<List<HistoryCSUNg>> getHistoryCSUNg({
    required String cUser,
    required DateTime start,
    required DateTime end,
  }) async {
    String dbName =
        Constants.isTesting ? 'cs_trs_cs_dtl_test' : 'cs_trs_cs_dtl';

    final startStr = DateFormat('yyyy-MM-dd').format(start);
    final endStr = DateFormat('yyyy-MM-dd').format(end);

    try {
      final data = _dioRequestNotifier;

      data.addAll({
        "mode": "SELECT",
        "command": "SELECT * FROM $dbName WHERE c_user = '$cUser' " +
            " AND c_date BETWEEN '$startStr' AND '$endStr' " +
            " ORDER BY c_date DESC OFFSET 0 ROWS FETCH FIRST 100 ROWS ONLY ",
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
              List<HistoryCSUNg> histories =
                  (list).map((data) => HistoryCSUNg.fromJson(data)).toList();

              return histories;
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

  Future<List<HistoryCSUOk>> getHistoryCSUOk({
    required String cUser,
    required DateTime start,
    required DateTime end,
  }) async {
    String dbName = Constants.isTesting ? 'cs_trs_cs_test' : 'cs_trs_cs';

    final startStr = DateFormat('yyyy-MM-dd').format(start);
    final endStr = DateFormat('yyyy-MM-dd').format(end);

    try {
      final data = _dioRequestNotifier;

      data.addAll({
        "mode": "SELECT",
        "command": "SELECT * FROM $dbName WHERE c_user = '$cUser' " +
            " AND c_date BETWEEN '$startStr' AND '$endStr' " +
            " ORDER BY c_date DESC OFFSET 0 ROWS FETCH FIRST 100 ROWS ONLY ",
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
              List<HistoryCSUOk> histories =
                  (list).map((data) => HistoryCSUOk.fromJson(data)).toList();

              return histories;
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
