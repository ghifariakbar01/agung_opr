import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/infrastructure/dio_extensions.dart';
import 'package:dio/dio.dart';

import '../../application/gate/csu_mst_gate.dart';
import '../exceptions.dart';

class GateRemoteService {
  GateRemoteService(this._dio, this._dioRequestNotifier);

  final Dio _dio;
  final Map<String, String> _dioRequestNotifier;

  Future<List<CSUMSTGate>> getCSUGates() async {
    const String dbName = 'cs_mst_gate';

    try {
      final data = _dioRequestNotifier;

      data.addAll({
        "mode": "SELECT",
        "command": "SELECT id_gate AS id, nama, is_csu FROM $dbName",
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
              List<CSUMSTGate> csuMSTGate =
                  (list).map((data) => CSUMSTGate.fromJson(data)).toList();

              // log('LIST CSUMSTGate: $list');

              // debugger(message: 'called');

              return csuMSTGate;
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

  Future<List<CSUMSTGate>> searchGatesList({required String search}) async {
    const String dbName = 'cs_mst_gate';

    try {
      final data = _dioRequestNotifier;

      data.addAll({
        "mode": "SELECT",
        "command":
            "SELECT id_gate AS id, nama FROM $dbName WHERE nama LIKE '%${search}%' OR id_gate LIKE '%${search}%'",
      });

      final response = await _dio.post('',
          data: jsonEncode(data), options: Options(contentType: 'text/plain'));

      log('data ${jsonEncode(data)}');
      log('response $response');

      final items = response.data?[0];

      if (items['status'] == 'Success') {
        final listExist = items['items'] != null && items['items'] is List;

        if (listExist) {
          final list = items['items'] as List<dynamic>;

          if (list.isNotEmpty) {
            try {
              List<CSUMSTGate> csuMSTGate =
                  (list).map((data) => CSUMSTGate.fromJson(data)).toList();

              // log('LIST CSUMSTGate: $list');

              // debugger(message: 'called');

              return csuMSTGate;
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
