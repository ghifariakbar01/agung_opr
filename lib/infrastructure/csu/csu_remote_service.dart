import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/infrastructure/dio_extensions.dart';
import 'package:agung_opr/infrastructure/exceptions.dart';
import 'package:dio/dio.dart';

import '../../application/check_sheet/unit/state/csu_ng/csu_ng_result.dart';
import '../../application/check_sheet/unit/state/csu_result.dart';
import '../../application/check_sheet/unit/state/csu_trips/csu_trips.dart';

class CSUFrameRemoteService {
  CSUFrameRemoteService(this._dio, this._dioRequestNotifier);

  final Dio _dio;
  final Map<String, String> _dioRequestNotifier;

  Future<List<CSUResult>> getCSUByFrameName({required String frameName}) async {
    // TEST
    const String dbName = 'cs_trs_cs';
    const String dbCSDtl = 'cs_trs_cs_dtl';

    try {
      final data = _dioRequestNotifier;

      data.addAll({
        "mode": "SELECT",
        "command":
            " SELECT *, (SELECT COUNT(id_item) FROM $dbCSDtl WHERE id_cs = $dbName.id_cs) as defectAmount, "
                " (SELECT nama FROM cs_mst_gate WHERE id_gate = $dbName.id_gate) as gate "
                " FROM $dbName WHERE frame LIKE '%$frameName%' "
                " ORDER BY u_date DESC OFFSET 0 ROWS FETCH FIRST 100 ROWS ONLY",
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
              List<CSUResult> csuList =
                  (list).map((data) => CSUResult.fromJson(data)).toList();

              return csuList;
            } catch (e) {
              throw FormatException(
                  'error while iterating list getCSUByFrameName');
            }
          } else {
            return [];
          }
        } else {
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

  Future<List<CSUNGResult>> getCSUNGByIdCS({required int idCS}) async {
    const String dbName = 'cs_trs_cs_dtl';

    try {
      final data = _dioRequestNotifier;

      data.addAll({
        "mode": "SELECT",
        "command":
            "SELECT id_cs, id_item AS idItem, id_jns_defect AS idJenis, id_p_defect "
                " AS idPenyebab FROM $dbName WHERE id_cs = '$idCS'",
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
              List<CSUNGResult> csuList =
                  (list).map((data) => CSUNGResult.fromJson(data)).toList();

              return csuList;
            } catch (e) {
              throw FormatException('error while iterating list CSU NG');
            }
          } else {
            return [];
          }
        } else {
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

  Future<List<CSUTrips>> getCSUFrameTripsByName(
      {required String frameName}) async {
    const String dbSlsCostnalatis = 'sls_trs_costanalis';
    const String dbMstCust = 'sls_mst_cust';
    const String dbOprTiUnit = 'opr_trs_ti_unit';
    const String dbOprTi = 'opr_trs_ti';

    try {
      final data = _dioRequestNotifier;

      data.addAll({
        "mode": "SELECT",
        "command": " SELECT (SELECT nama FROM $dbSlsCostnalatis WHERE id_costanalis = B.id_costanalis) AS costanalis, "
            " (SELECT nama FROM $dbMstCust WHERE id_cust = B.id_cust) AS custnm FROM $dbOprTiUnit AS "
            " A INNER JOIN $dbOprTi AS B ON A.id_do = B.id_do WHERE A.frame LIKE '$frameName' "
            " ORDER BY A.id_unit DESC OFFSET 0 ROWS FETCH FIRST 100 ROWS ONLY",
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
              List<CSUTrips> csuList =
                  (list).map((data) => CSUTrips.fromJson(data)).toList();

              return csuList;
            } catch (e) {
              throw FormatException('error while iterating list model');
            }
          } else {
            return [];
          }
        } else {
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
