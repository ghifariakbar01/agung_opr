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
      const String dbName = "opr_trs_spk_test";

      data.addAll({
        "mode": "SELECT",
        "command":
            "SELECT id_spk, spk_no, supir1_nm, supir2_nm, nopol, tgl_berangkat FROM $dbName WHERE dc_sta = 1 AND tiba_sta = 0 AND kmbl_sta = 0 AND id_spk LIKE '%$search%' OR spk_no LIKE '%$search%' OR supir1_nm LIKE '%$search%' OR supir2_nm LIKE '%$search%' OR nopol LIKE '%$search%' ORDER BY spk_tgl DESC OFFSET 0 ROWS FETCH FIRST 100 ROWS ONLY",
      });

      final response = await _dio.post('',
          data: jsonEncode(data), options: Options(contentType: 'text/plain'));

      // log('data ${jsonEncode(data)}');
      log('response $response');

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
      const String dbName = "opr_trs_spk_test";

      data.addAll({
        "mode": "SELECT",
        "command":
            "SELECT id_spk, spk_no, supir1_nm, supir2_nm, nopol, tgl_berangkat FROM $dbName WHERE dc_sta = 1 AND tiba_sta = 0 AND kmbl_sta = 0 ORDER BY spk_tgl DESC OFFSET $page ROWS FETCH FIRST 10 ROWS ONLY",
      });

      final response = await _dio.post('',
          data: jsonEncode(data), options: Options(contentType: 'text/plain'));

      log('data ${jsonEncode(data)}');
      // log('response $response');

      final items = response.data?[0];

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
