// SELECT id_spk, spk_no, supir1_nm, supir2_nm, nopol FROM (SELECT id_spk, spk_no, supir1_nm, supir2_nm, nopol, ROW_NUMBER() OVER (PARTITION BY id_spk ORDER BY id_spk DESC) AS rn FROM opr_trs_spk WHERE dc_sta <> 1) AS ranked WHERE rn = 1 ORDER BY id_spk DESC OFFSET 0 ROWS FETCH FIRST 100 ROWS ONLY

import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/infrastructure/dio_extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../application/check_sheet/unit/state/csu_items.dart';
import '../exceptions.dart';

class UpdateCSUFrameRemoteService {
  UpdateCSUFrameRemoteService(this._dio, this._dioRequestNotifier);

  final Dio _dio;
  final Map<String, String> _dioRequestNotifier;

  // INSERT INTO $dbName (id_cs, frame, inout, id_user, c_user, u_user, tgl, c_date, u_date, id_gate, posisi, supir1, supir2, no_defect, supir_sdr, tgl_kirim_unit, tgl_terima_unit)

  // VALUES (‘$idCS’, ‘$frame’, ‘$inOut’, ‘$idUser’, ‘$cUser’, ‘$uUser’, ‘$tgl’, ‘$cDate’, ‘$uDate’, ‘$idGate’, ‘$posisi’, ‘$supir1’, ‘$supir2’, ‘$noDefect’, ‘$supirSdr’, ‘$tglKirimUnit’, $tglTerimaUnit)

  Future<Unit> insertFrameCSUByQuery({
    required String query,
  }) async {
    try {
      final data = _dioRequestNotifier;

      data.addAll({
        "mode": "INSERT",
        "command": "$query",
      });

      final response = await _dio.post('',
          data: jsonEncode(data), options: Options(contentType: 'text/plain'));

      log('data ${jsonEncode(data)}');
      log('response $response');

      final items = response.data?[0];

      if (items['status'] == 'Success') {
        // HERE
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

  Future<List<CSUItems>> getCSUItems() async {
    const String dbName = 'cs_mst_item';

    try {
      final data = _dioRequestNotifier;

      data.addAll({
        "mode": "SELECT",
        "command":
            "SELECT id_item, nama_ina, nama_eng, Grup AS grup FROM $dbName",
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
              List<CSUItems> csuList =
                  (list).map((data) => CSUItems.fromJson(data)).toList();

              log('LIST CSUItems: $list');

              return csuList;
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
