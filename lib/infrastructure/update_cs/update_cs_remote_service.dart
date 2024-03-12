// SELECT id_spk, spk_no, supir1_nm, supir2_nm, nopol FROM (SELECT id_spk, spk_no, supir1_nm, supir2_nm, nopol, ROW_NUMBER() OVER (PARTITION BY id_spk ORDER BY id_spk DESC) AS rn FROM opr_trs_spk WHERE dc_sta <> 1) AS ranked WHERE rn = 1 ORDER BY id_spk DESC OFFSET 0 ROWS FETCH FIRST 100 ROWS ONLY

import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/infrastructure/dio_extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../exceptions.dart';

class UpdateCSRemoteService {
  UpdateCSRemoteService(this._dio, this._dioRequestNotifier);

  final Dio _dio;
  final Map<String, String> _dioRequestNotifier;

  Future<int> getLastPoolChkKrId() async {
    try {
      final data = _dioRequestNotifier;

      final String dbName = 'pool_chk_kr';

      data.addAll({
        "mode": "SELECT",
        "command": "SELECT ISNULL(max(id_kr_chk), 0) + 1 FROM $dbName",
      });

      final response = await _dio.post('',
          data: jsonEncode(data), options: Options(contentType: 'text/plain'));

      log('data ${jsonEncode(data)}');
      log('response getLastPoolChkKrId $response');

      final items = response.data?[0];
      final resp = items['items'] as List;

      if (resp.isNotEmpty) {
        // HERE
        return resp[0]['Column1'];
      } else {
        return 0;
      }
    } catch (_) {
      return 0;
    }
  }

  Future<Unit> insertCSBYQuery({
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
      log('response insertCSBYQuery $response');

      final items = response.data?[0];

      if (items['status'] == 'Success') {
        // HERE
        // debugger(message: 'called');

        return unit;
      } else {
        debugger(message: 'called');

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
