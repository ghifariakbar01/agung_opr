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
    const String dbName = 'opr_trs_ti_unit_test';
    const String dbOprTrsSpk = 'opr_trs_spk_unit_test';
    const String dbSlsMst = 'sls_mst_cust';

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
            " T.no_reff_expor," +
            " T.id_kend_type," +
            " (SELECT nama FROM $dbSlsMst WHERE id_cust = T.id_cust) AS custnm" +
            " FROM" +
            " $dbName AS T" +
            " WHERE" +
            " T.id_unit IN (SELECT id_unit FROM $dbOprTrsSpk WHERE id_spk = $idSPK)"
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
}
