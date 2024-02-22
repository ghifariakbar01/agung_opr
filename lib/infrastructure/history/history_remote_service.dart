import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/infrastructure/dio_extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../application/history/history.dart';
import '../exceptions.dart';

class HistoryRemoteService {
  HistoryRemoteService(this._dio, this._dioRequestNotifier);

  final Dio _dio;
  final Map<String, String> _dioRequestNotifier;

  Future<List<History>> getHistories({
    required String cUser,
  }) async {
    const String dbName = 'pool_chk_kr';

    try {
      final data = _dioRequestNotifier;

      data.addAll({
        "mode": "SELECT",
        "command": "SELECT * FROM $dbName WHERE c_user = '$cUser' " +
            " ORDER BY c_date DESC OFFSET 0 ROWS FETCH FIRST 100 ROWS ONLY ",
      });

      final response = await _dio.post('',
          data: jsonEncode(data), options: Options(contentType: 'text/plain'));

      // log('data ${jsonEncode(data)}');
      // log('response $response');

      final items = response.data?[0];

      if (items['status'] == 'Success') {
        final listExist = items['items'] != null && items['items'] is List;

        if (listExist) {
          final list = items['items'] as List<dynamic>;

          if (list.isNotEmpty) {
            try {
              List<History> histories =
                  (list).map((data) => History.fromJson(data)).toList();

              // log('LIST History: $list');

              // debugger(message: 'called');

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

  Future<Unit> insertToHistory({
    required int idUser,
    required String query,
    required String cUser,
    required String cDate,
    required String sDate,
    required String content,
  }) async {
    const String dbName = 'mst_historical_transaction_opr';

    try {
      final data = _dioRequestNotifier;

      final cleanQuery = query.replaceAll("'", '');

      data.addAll({
        "mode": "INSERT",
        "command":
            " INSERT INTO $dbName (id_user, query, content, c_user, c_date, s_date) " +
                " VALUES ($idUser, '$cleanQuery', '$content', '$cUser', '$cDate', '$sDate') ",
      });

      final response = await _dio.post('',
          data: jsonEncode(data), options: Options(contentType: 'text/plain'));

      log('data ${jsonEncode(data)}');
      log('response $response');

      final items = response.data?[0];

      if (items['status'] == 'Success') {
        return unit;
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
