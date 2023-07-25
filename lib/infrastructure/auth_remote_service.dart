import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/infrastructure/dio_extensions.dart';
import 'package:dio/dio.dart';

import '../application/user/user_model.dart';
import 'auth_response.dart';
import 'exceptions.dart';

class AuthRemoteService {
  AuthRemoteService(this._dio, this._dioRequestNotifier);

  final Dio _dio;
  final Map<String, String> _dioRequestNotifier;

  Future<void> signOut() async {
    try {
      await _dio.get<dynamic>('logout');
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

  Future<AuthResponse> signIn({
    required String userId,
    required String password,
  }) async {
    try {
      final data = _dioRequestNotifier;

      data.addAll({
        "username": "$userId",
        "password": "$password",
        "mode": "SELECT",
        "command":
            "SELECT *, (select nama from mst_dept where id_dept = A.id_dept) as dept, (select nama from mst_comp where id_comp = A.id_comp) as comp, (select nama from mst_jabatan where id_jbt = A.id_jbt) as jbt FROM mst_user A WHERE nama = '$userId'",
      });

      log('data ${jsonEncode(data)}');

      final response = await _dio.post('',
          data: jsonEncode(data), options: Options(contentType: 'text/plain'));

      final items = response.data?[0];

      if (items['status'] == 'Success') {
        final userExist = items['items'] != null && items['items'] is List;

        if (userExist) {
          final list = items['items'] as List;

          if (list.isNotEmpty) {
            try {
              final listSelected = list[0];

              final UserModelWithPassword user = UserModelWithPassword(
                idUser: listSelected['id_user'] ?? '',
                idKary: listSelected['IdKary'] ?? '',
                company: listSelected['comp'] ?? '',
                deptList: listSelected['dept'] ?? '',
                email2: listSelected['email2'] ?? '',
                email: listSelected['email'] ?? '',
                fullname: listSelected['fullname'] ?? '',
                imeiHp: listSelected['imei_hp'] ?? '',
                jabatan: listSelected['jbt'] ?? '',
                ktp: listSelected['ktp'] ?? '',
                nama: listSelected['nama'] ?? '',
                noTelp1: listSelected['no_telp1'] ?? '',
                noTelp2: listSelected['no_telp2'] ?? '',
                photo: listSelected['picture'],
                password: password,
              );

              return AuthResponse.withUser(user);
            } catch (_) {
              return AuthResponse.failure(
                errorCode: 00,
                message: 'Error parsing',
              );
            }
          } else {
            return AuthResponse.failure(
              errorCode: 00,
              message: 'User not found',
            );
          }
        } else {
          return AuthResponse.failure(
            errorCode: items['errornum'] as int?,
            message: items['error'] as String?,
          );
        }
      } else {
        final message = items['error'] as String?;
        return AuthResponse.failure(
          errorCode: items['errornum'],
          message: message,
        );
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
