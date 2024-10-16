import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/infrastructure/dio_extensions.dart';
import 'package:agung_opr/infrastructure/exceptions.dart';
import 'package:dio/dio.dart';

import '../../application/update_frame/frame.dart';
import '../../constants/constants.dart';
// import '../../utils/logging.dart';

class FrameRemoteService {
  FrameRemoteService(this._dio, this._dioRequestNotifier);

  final Dio _dio;
  final Map<String, String> _dioRequestNotifier;
  // TEST
  String dbName =
      Constants.isTesting ? 'opr_trs_ti_unit_test' : 'opr_trs_ti_unit';
  String dbOprTrsSpkUnit =
      Constants.isTesting ? 'opr_trs_spk_unit_test' : 'opr_trs_spk_unit';
  String dbOprTrsSpk = Constants.isTesting ? 'opr_trs_spk_test' : 'opr_trs_spk';
  String dbOprMstTrayek = 'opr_mst_trayek';
  String dbCustomer = 'sls_mst_cust';

  Future<Map<String, List<Frame>>> getFrameList({required int idSPK}) async {
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
            " T.spb," +
            " T.c_date," +
            " T.u_date," +
            " T.u_user," +
            "(SELECT nama FROM $dbCustomer  WHERE id_cust = T.id_cust) AS custnm" +
            " FROM " +
            " $dbName AS T" +
            " WHERE" +
            " T.id_unit IN (SELECT id_unit FROM $dbOprTrsSpkUnit WHERE id_spk = $idSPK)"
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
              List<Frame> frameList =
                  (list).map((data) => Frame.fromJson(data)).toList();

              log('frameList $frameList');

              frameMap.update('$idSPK', (value) => frameList);

              return frameMap;
            } catch (e) {
              throw FormatException('error while iterating list model');
            }
          } else {
            return frameMap;
          }
        } else {
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

  Future<Map<String, List<Frame>>> getFrameListByPage(
      {required int page}) async {
    try {
      final data = _dioRequestNotifier;

      final Map<String, List<Frame>> frameMap = {
        "0": [],
      };

      data.addAll({
        "mode": "SELECT",
        "command": " SELECT * "
            " FROM $dbName tiu "
            " WHERE id_unit IN ( "
            "    SELECT spu.id_unit "
            "    FROM $dbOprTrsSpkUnit spu "
            "    WHERE spu.id_spk IN ( "
            "        SELECT spk.id_spk "
            "        FROM $dbOprTrsSpk spk "
            "        WHERE spk.id_trayek IN ( "
            "            SELECT trayek.id_trayek "
            "            FROM $dbOprMstTrayek trayek "
            "            WHERE trayek.nama LIKE '% - merak%' "
            "        ) "
            "    ) "
            " ) "
            " ORDER BY tiu.id_unit DESC "
            " OFFSET ${page}0 ROWS FETCH NEXT 10 ROWS ONLY; "
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
              List<Frame> frameList =
                  (list).map((data) => Frame.fromJson(data)).toList();

              frameMap.update('0', (value) => frameList);

              return frameMap;
            } catch (e) {
              log('list error $e');

              throw FormatException('error while iterating list model');
            }
          } else {
            return frameMap;
          }
        } else {
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
            " T.spb," +
            " T.last_spk," +
            " T.c_date," +
            "(SELECT nama FROM $dbCustomer  WHERE id_cust = T.id_cust) AS custnm" +
            " FROM " +
            " $dbName AS T" +
            " WHERE T.id_unit LIKE '%$search%' OR T.frame LIKE '%$search%' OR T.engine LIKE '%$search% '" +
            " OR T.warna LIKE '%$search%' OR T.id_kend_type LIKE '%$search%' OR T.spb LIKE '%$search%' OR T.c_date LIKE '%$search%' " +
            " ORDER BY T.id_unit DESC OFFSET 0 ROWS FETCH FIRST 100 ROWS ONLY"
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
              List<Frame> frameList =
                  (list).map((data) => Frame.fromJson(data)).toList();

              frameMap.update('0', (value) => frameList);

              return frameMap;
            } catch (e) {
              log('list error $e');

              throw FormatException('error while iterating list model');
            }
          } else {
            return frameMap;
          }
        } else {
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

  Future<Frame> getFrameByName({required String frame}) async {
    try {
      final data = _dioRequestNotifier;

      data.addAll({
        "mode": "SELECT",
        "command": "SELECT" +
            " T.id_unit," +
            " T.frame," +
            " T.engine," +
            " T.warna," +
            " T.id_kend_type," +
            " T.last_spk," +
            " T.spb," +
            " T.c_date," +
            " (SELECT nama FROM $dbCustomer  WHERE id_cust = T.id_cust) AS custnm" +
            " FROM " +
            " $dbName AS T" +
            " WHERE T.frame = '$frame' "
                " ORDER BY T.id_unit DESC OFFSET 0 ROWS FETCH FIRST 10 ROWS ONLY"
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
              final data = list.first as Map<String, dynamic>;
              return Frame.fromJson(data);
            } catch (e) {
              throw FormatException('list empty');
            }
          } else {
            throw AssertionError('frame not found');
          }
        } else {
          throw AssertionError('list not exist');
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
