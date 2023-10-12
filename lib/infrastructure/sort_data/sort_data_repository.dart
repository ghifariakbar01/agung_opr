import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../application/check_sheet/shared/state/cs_id_query.dart';
import '../../application/spk/spk.dart';
import '../../domain/remote_failure.dart';
import '../exceptions.dart';
import '../frame/frame_repository.dart';
import '../spk/spk_repository.dart';

class SortDataRepository {
  final SPKRepository _spkRepository;
  final FrameRepository _frameRepository;

  SortDataRepository(this._spkRepository, this._frameRepository);

  Future<Either<RemoteFailure, Unit>> sortDataSPK() async {
    try {
      final List<SPK> listSPK = await _spkRepository
          .getSPKListOFFLINE(page: 0)
          .then((value) => value.fold((l) => [], (r) => r));

      if (listSPK.isNotEmpty) {
        for (int i = 0; i < listSPK.length; i++) {
          log('GETTING FRAME INDEX $i');
          await _frameRepository.getFrameList(idSPK: listSPK[i].idSpk);
        }

        return right(unit);
      }

      return left(RemoteFailure.server(0, 'spk empty sortDataSPK'));
    } on RestApiException catch (e) {
      debugger(message: 'called');

      return left(RemoteFailure.server(e.errorCode, e.message));
    } on NoConnectionException {
      debugger(message: 'called');

      return left(RemoteFailure.noConnection());
    } on RangeError catch (e) {
      debugger(message: 'called');
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
