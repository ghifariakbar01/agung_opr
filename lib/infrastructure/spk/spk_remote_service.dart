import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/infrastructure/dio_extensions.dart';
import 'package:agung_opr/infrastructure/exceptions.dart';
import 'package:dio/dio.dart';

import '../../application/spk/spk.dart';

class SPKRemoteService {
  SPKRemoteService(this._dio, this._dioRequestNotifier);

  final Dio _dio;
  final Map<String, String> _dioRequestNotifier;

  Future<List<SPK>> searchSPKList({required String search}) async {
    try {
      final data = _dioRequestNotifier;
      // TEST
      const String dbName = "opr_trs_spk";
      const String dbTrayekName = "opr_mst_trayek";

      data.addAll({
        "mode": "SELECT",
        "command": "SELECT " +
            " spk.id_spk," +
            " spk.id_trayek," +
            " spk.spk_no," +
            "   spk.supir1_nm," +
            "   spk.supir2_nm," +
            "   spk.nopol," +
            "   spk.tgl_berangkat," +
            "   spk.u_user, " +
            "   spk.u_date, " +
            "   spk.is_edit, " +
            "   spk.ket, " +
            " trayek.nama AS trayek_nama" +
            " FROM " +
            " $dbName AS spk " +
            " JOIN " +
            " $dbTrayekName AS trayek " +
            " ON " +
            " spk.id_trayek = trayek.id_trayek " +
            " WHERE " +
            " spk.dc_sta = 1 " +
            " AND spk.tiba_sta = 0 " +
            " AND spk.kmbl_sta = 0 " +
            " AND id_spk LIKE '%$search%' OR spk_no LIKE '%$search%' OR supir1_nm LIKE '%$search%' OR supir2_nm LIKE '%$search%' OR nopol LIKE '%$search%' " +
            " AND spk.spk_tgl >= DATEADD(DAY, -5, GETDATE()) " +
            " ORDER BY " +
            " spk.spk_tgl DESC " +
            " OFFSET " +
            " 0 ROWS " +
            " FETCH FIRST " +
            " 100 ROWS ONLY"
      });

      final response = await _dio.post('',
          data: jsonEncode(data), options: Options(contentType: 'text/plain'));

      // log('data spk ${jsonEncode(data)}');
      log('response spk $response');

      final items = response.data?[0];

      if (items['status'] == 'Success') {
        final listExist = items['items'] != null && items['items'] is List;

        if (listExist) {
          final list = items['items'] as List<dynamic>;

          if (list.isNotEmpty) {
            try {
              List<SPK> spkList =
                  (list).map((data) => SPK.fromJson(data)).toList();

              // log('list 30 Aug $list');

              return spkList;
            } catch (e) {
              log('list error $e');

              throw FormatException('error while iterating list');
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

  Future<List<SPK>> getSPKList({required int page}) async {
    try {
      final data = _dioRequestNotifier;
      // TEST
      const String dbName = "opr_trs_spk";
      const String dbTrayekName = "opr_mst_trayek";

      data.addAll({
        "mode": "SELECT",
        "command": "SELECT " +
            "spk.id_spk," +
            "spk.id_trayek," +
            "spk.spk_no," +
            "   spk.supir1_nm," +
            "   spk.supir2_nm," +
            "   spk.nopol," +
            "   spk.tgl_berangkat," +
            "   spk.u_user, " +
            "   spk.u_date, " +
            "   spk.is_edit, " +
            " trayek.nama AS trayek_nama" +
            " FROM " +
            " $dbName AS spk " +
            " JOIN " +
            " $dbTrayekName AS trayek " +
            " ON " +
            " spk.id_trayek = trayek.id_trayek " +
            " WHERE " +
            " spk.dc_sta = 1 " +
            " AND spk.tiba_sta = 0 " +
            " AND spk.kmbl_sta = 0 " +
            " AND spk.spk_tgl >= DATEADD(DAY, -5, GETDATE()) " +
            " ORDER BY " +
            " spk.spk_tgl DESC " +
            " OFFSET " +
            " ${page}0 ROWS " +
            " FETCH FIRST " +
            " 10 ROWS ONLY"
      });

      final response = await _dio.post('',
          data: jsonEncode(data), options: Options(contentType: 'text/plain'));

      log('data spk ${jsonEncode(data)}');
      // log('response $response');

      final items = response.data?[0];

      log('item spk ${jsonEncode(data)}');

      if (items['status'] == 'Success') {
        final listExist = items['items'] != null && items['items'] is List;

        if (listExist) {
          final list = items['items'] as List<dynamic>;

          if (list.isNotEmpty) {
            try {
              List<SPK> spkList =
                  (list).map((data) => SPK.fromJson(data)).toList();

              // log('list $list');

              return spkList;
            } catch (e) {
              log('list error $e');

              throw FormatException('error while iterating list');
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
