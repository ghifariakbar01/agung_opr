import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/infrastructure/dio_extensions.dart';
import 'package:agung_opr/infrastructure/exceptions.dart';
import 'package:dio/dio.dart';

import '../../application/spk/spk.dart';
import '../../constants/constants.dart';

class SPKRemoteService {
  SPKRemoteService(this._dio, this._dioRequestNotifier);

  final Dio _dio;
  final Map<String, String> _dioRequestNotifier;

  // TEST
  String dbName = Constants.isTesting ? "opr_trs_spk_test" : "opr_trs_spk";
  String dbNamePoolChk =
      Constants.isTesting ? "pool_chk_kr_test" : "pool_chk_kr";
  String dbTrayekName = "opr_mst_trayek";

  Future<List<SPK>> searchSPKList({required String search}) async {
    try {
      final data = _dioRequestNotifier;

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
            "           ( "
                "  SELECT TOP 1  "
                "    c_date  "
                "  FROM  "
                "    pool_chk_kr  "
                "  WHERE  "
                "    id_spk = spk.id_spk "
                "  ORDER BY  "
                "    c_date DESC "
                ") AS c_date_cs,  "
                " trayek.nama AS trayek_nama" +
            " FROM " +
            " $dbName AS spk " +
            " JOIN " +
            " $dbTrayekName AS trayek " +
            " ON " +
            " spk.id_trayek = trayek.id_trayek " +
            " WHERE " +
            " spk.bs_sta = 1 " +
            " AND spk.tiba_sta = 0 " +
            " AND spk.kmbl_sta = 0 " +
            " AND supir1_nm LIKE '%$search%' OR supir2_nm LIKE '%$search%' OR nopol LIKE '%$search%' " +
            " AND spk.spk_tgl >= DATEADD(DAY, -15, GETDATE()) " +
            " ORDER BY "
                " spk.spk_tgl DESC "
                " OFFSET "
                " 0 ROWS "
                " FETCH FIRST "
                " 10 ROWS ONLY"
      });

      final response = await _dio.post(
        '',
        data: jsonEncode(data),
        options: Options(contentType: 'text/plain'),
      );

      final items = response.data?[0];

      log("${items['items']}");

      if (items['status'] == 'Success') {
        final listExist = items['items'] != null && items['items'] is List;

        if (listExist) {
          final list = items['items'] as List<dynamic>;

          if (list.isNotEmpty) {
            try {
              return list.map((data) => SPK.fromJson(data)).toList();
            } catch (e) {
              throw FormatException('error while iterating list');
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

  Future<List<SPK>> getSPKList({required int page}) async {
    try {
      final data = _dioRequestNotifier;

      const testing = " spk.bs_sta = 1 " +
          " AND spk.tiba_sta = 0 " +
          " AND spk.kmbl_sta = 0 AND ";

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
            "           ( "
                "  SELECT TOP 1  "
                "    c_date  "
                "  FROM  "
                "    $dbNamePoolChk  "
                "  WHERE  "
                "    id_spk = spk.id_spk "
                "  ORDER BY  "
                "    c_date DESC "
                ") AS c_date_cs,  "
                " trayek.nama AS trayek_nama " +
            " FROM " +
            " $dbName AS spk " +
            " JOIN " +
            " $dbTrayekName AS trayek " +
            " ON    " +
            " spk.id_trayek = trayek.id_trayek "
                " WHERE     " +
            " ${Constants.isTesting ? "" : testing} " +
            "  spk.spk_tgl >= DATEADD(DAY, -15, GETDATE()) " +
            " ORDER BY " +
            " spk.spk_tgl DESC " +
            " OFFSET " +
            " ${page}0 ROWS " +
            " FETCH FIRST " +
            " 10 ROWS ONLY"
      });

      log(data['command']!);

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
              return list.map((e) => SPK.fromJson(e)).toList();
            } catch (e) {
              throw FormatException('error while iterating list');
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

  Future<SPK> getSPKById({required int idSpk}) async {
    try {
      final data = _dioRequestNotifier;

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
            "           ( "
                "  SELECT TOP 1  "
                "    c_date  "
                "  FROM  "
                "    $dbNamePoolChk  "
                "  WHERE  "
                "    id_spk = spk.id_spk "
                "  ORDER BY  "
                "    c_date DESC "
                ") AS c_date_cs,  "
                " trayek.nama AS trayek_nama" +
            " FROM " +
            " $dbName AS spk " +
            " JOIN " +
            " $dbTrayekName AS trayek " +
            " ON " +
            " spk.id_trayek = trayek.id_trayek " +
            " WHERE " +
            " spk.id_spk = $idSpk "
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
              final _data = list.first;
              return SPK.fromJson(_data);
            } catch (e) {
              throw FormatException('error while iterating list');
            }
          } else {
            throw AssertionError('spk not found');
          }
        } else {
          throw AssertionError('list empty');
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
