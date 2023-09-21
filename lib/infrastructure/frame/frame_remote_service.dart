// SELECT id_spk, spk_no, supir1_nm, supir2_nm, nopol FROM (SELECT id_spk, spk_no, supir1_nm, supir2_nm, nopol, ROW_NUMBER() OVER (PARTITION BY id_spk ORDER BY id_spk DESC) AS rn FROM opr_trs_spk WHERE dc_sta <> 1) AS ranked WHERE rn = 1 ORDER BY id_spk DESC OFFSET 0 ROWS FETCH FIRST 100 ROWS ONLY

import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/infrastructure/dio_extensions.dart';
import 'package:agung_opr/infrastructure/exceptions.dart';
import 'package:dio/dio.dart';

import '../../application/update_frame/frame.dart';

class FrameRemoteService {
  FrameRemoteService(this._dio, this._dioRequestNotifier);

  final Dio _dio;
  final Map<String, String> _dioRequestNotifier;

  Future<Map<String, List<Frame>>> getFrameList({required int idSPK}) async {
    // TEST
    const String dbName = 'opr_trs_ti_unit';
    const String dbOprTrsSpk = 'opr_trs_spk_unit';
    const String dbCustomer = 'sls_mst_cust';

    try {
      final data = _dioRequestNotifier;

      final Map<String, List<Frame>> frameMap = {
        "$idSPK": [],
      };

      data.addAll({
        "mode": "SELECT",
        "command": "SELECT" +
            " T.id_unit," +
            " T.frame," +
            " T.engine," +
            " T.warna," +
            " T.id_kend_type," +
            " T.no_invoice," +
            " T.c_date," +
            "(SELECT nama FROM $dbCustomer  WHERE id_cust = T.id_cust) AS custnm" +
            " FROM " +
            " $dbName AS T" +
            " WHERE" +
            " T.id_unit IN (SELECT id_unit FROM $dbOprTrsSpk WHERE id_spk = $idSPK)"
      });

      final response = await _dio.post('',
          data: jsonEncode(data), options: Options(contentType: 'text/plain'));

      log('data ${jsonEncode(data)}');
      log('response $response');

      // debugger();

      final items = response.data?[0];

      if (items['status'] == 'Success') {
        final listExist = items['items'] != null && items['items'] is List;

        if (listExist) {
          final list = items['items'] as List<dynamic>;

          if (list.isNotEmpty) {
            try {
              List<Frame> frameList =
                  (list).map((data) => Frame.fromJson(data)).toList();

              log('LIST FRAME: $list');

              frameMap.update('$idSPK', (value) => frameList);

              log('LIST MAP: $frameMap');

              return frameMap;
            } catch (e) {
              log('list error $e');

              throw FormatException('error while iterating list model');
            }
          } else {
            log('list empty');

            return frameMap;
          }
        } else {
          log('list empty');

          return frameMap;
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

  Future<Map<String, List<Frame>>> getFrameListWithoutSPK(
      {required int page}) async {
    // TEST
    const String dbName = 'opr_trs_ti_unit';
    const String dbCustomer = 'sls_mst_cust';

    try {
      final data = _dioRequestNotifier;

      final Map<String, List<Frame>> frameMap = {
        "0": [],
      };

      data.addAll({
        "mode": "SELECT",
        "command": "SELECT" +
            " T.id_unit," +
            " T.frame," +
            " T.engine," +
            " T.warna," +
            " T.id_kend_type," +
            " T.no_invoice," +
            " T.c_date," +
            "(SELECT nama FROM $dbCustomer  WHERE id_cust = T.id_cust) AS custnm" +
            " FROM " +
            " $dbName AS T" +
            " ORDER BY T.id_unit DESC OFFSET $page ROWS FETCH FIRST 100 ROWS ONLY"
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
              List<Frame> frameList =
                  (list).map((data) => Frame.fromJson(data)).toList();

              log('LIST FRAME: $list');

              frameMap.update('0', (value) => frameList);

              log('LIST MAP: $frameMap');

              return frameMap;
            } catch (e) {
              log('list error $e');

              throw FormatException('error while iterating list model');
            }
          } else {
            log('list empty');

            return frameMap;
          }
        } else {
          log('list empty');

          return frameMap;
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

  Future<Map<String, List<Frame>>> searchFrameListWithoutSPK(
      {required String search}) async {
    // TEST
    const String dbName = 'opr_trs_ti_unit';
    const String dbCustomer = 'sls_mst_cust';

    try {
      final data = _dioRequestNotifier;

      final Map<String, List<Frame>> frameMap = {
        "0": [],
      };

      data.addAll({
        "mode": "SELECT",
        "command": "SELECT" +
            " T.id_unit," +
            " T.frame," +
            " T.engine," +
            " T.warna," +
            " T.id_kend_type," +
            " T.no_invoice," +
            " T.c_date," +
            "(SELECT nama FROM $dbCustomer  WHERE id_cust = T.id_cust) AS custnm" +
            " FROM " +
            " $dbName AS T" +
            " WHERE T.id_unit LIKE '%$search%' OR T.frame LIKE '%$search%' OR T.engine LIKE '%$search% '" +
            " OR T.warna LIKE '%$search%' OR T.id_kend_type LIKE '%$search%' OR T.no_invoice LIKE '%$search%' OR T.c_date LIKE '%$search%' " +
            " ORDER BY T.id_unit DESC OFFSET 0 ROWS FETCH FIRST 100 ROWS ONLY"
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
              List<Frame> frameList =
                  (list).map((data) => Frame.fromJson(data)).toList();

              log('LIST FRAME: $list');

              frameMap.update('0', (value) => frameList);

              log('LIST MAP: $frameMap');

              return frameMap;
            } catch (e) {
              log('list error $e');

              throw FormatException('error while iterating list model');
            }
          } else {
            log('list empty');

            return frameMap;
          }
        } else {
          log('list empty');

          return frameMap;
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
