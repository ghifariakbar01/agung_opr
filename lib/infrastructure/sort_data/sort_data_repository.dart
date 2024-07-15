import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../application/spk/spk.dart';
import '../../domain/remote_failure.dart';
import '../exceptions.dart';
import '../frame/frame_repository.dart';
import '../spk/spk_repository.dart';

class SortDataRepository {
  final SPKRepository _spkRepository;
  final FrameRepository _frameRepository;

  SortDataRepository(this._spkRepository, this._frameRepository);

  // this function get list of saved spk (previously opened by user)
  // then get newly updated frame list on that spk
  Future<Either<RemoteFailure, Unit>> sortDataFrameInSPK() async {
    try {
      final List<SPK> listSPK = await _spkRepository
          .getSPKListOFFLINE(page: 0)
          .then((value) => value.fold(
                (_) => [],
                (r) => r,
              ));

      if (listSPK.isNotEmpty) {
        for (int i = 0; i < listSPK.length; i++) {
          await _frameRepository.getFrameList(
            idSPK: listSPK[i].idSpk,
          );
        }
      }

      return right(unit);
    } on RestApiException catch (e) {
      return left(RemoteFailure.server(e.errorCode, e.message));
    } on NoConnectionException {
      return left(RemoteFailure.noConnection());
    } on RangeError catch (e) {
      return left(RemoteFailure.parse(message: e.message));
    } on FormatException catch (e) {
      return left(RemoteFailure.parse(message: e.message));
    } on JsonUnsupportedObjectError {
      return left(RemoteFailure.parse(message: 'JsonUnsupportedObjectError'));
    } on PlatformException {
      return left(RemoteFailure.storage());
    }
  }
}
