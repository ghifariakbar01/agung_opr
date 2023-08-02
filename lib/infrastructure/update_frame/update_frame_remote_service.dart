import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/application/update_frame/frame.dart';
import 'package:agung_opr/infrastructure/dio_extensions.dart';
import 'package:agung_opr/infrastructure/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class UpdateFrameRemoteService {
  UpdateFrameRemoteService(this._dio, this._dioRequestNotifier);

  final Dio _dio;
  final Map<String, String> _dioRequestNotifier;

  Future<Unit> updateFrameByQuery({
    required String query,
  }) async {
    try {
      final data = _dioRequestNotifier;

      data.addAll({
        "mode": "UPDATE",
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

  Future<Frame> updateFrame({
    required int idUnit,
    required int idKendType,
    required String frame,
    required String engine,
    required String warna,
    required String noReffExp,
  }) async {
    const String dbName = 'opr_trs_ti_unit_test';

    try {
      final data = _dioRequestNotifier;

      data.addAll({
        "mode": "UPDATE",
        "command":
            "UPDATE $dbName SET frame = '$frame', engine = '$engine', warna = '$warna', no_reff_expor = '$noReffExp', id_kend_type = '$idKendType' WHERE id_unit = $idUnit",
      });

      final response = await _dio.post('',
          data: jsonEncode(data), options: Options(contentType: 'text/plain'));

      log('data ${jsonEncode(data)}');
      log('response $response');

      final items = response.data?[0];

      if (items['status'] == 'Success') {
        // HERE
        final response = Frame(
            idUnit: idUnit,
            frame: frame,
            engine: engine,
            warna: warna,
            idKendType: idKendType,
            noReffExp: noReffExp);

        return response;
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
