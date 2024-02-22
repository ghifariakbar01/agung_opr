import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../domain/local_failure.dart';
import '../../infrastructure/frame/frame_repository.dart';
import '../../infrastructure/spk/spk_repository.dart';

/// [SAVED] MODEL =>
///
/// [
///   [CSJenis]
///
/// ]

class ClearDataEssentialRepository {
  ClearDataEssentialRepository({
    required this.spkRepository,
    required this.frameRepository,
  });

  final SPKRepository spkRepository;
  final FrameRepository frameRepository;
  // final CSRepository csRepository;
  // final GateRepository gateRepository;
  // final CSItemsRepository csItemsRepository;
  // final CSUFrameRepository csuFrameRepository;
  // final CSUItemsRepository csuItemsRepository;
  // final CustomerRepository customerRepository;
  // final CSUJenisPenyebabRepository csuJenisPenyebabRepository;

  // Future<bool> hasOfflineData() => getCSJenisOFFLINE()
  //     .then((credentials) => credentials.fold((_) => false, (_) => true));

  Future<Either<LocalFailure, Unit>> clearAllStorage(
      {required int idSPK}) async {
    try {
      await spkRepository.clearSPKStorageById(idSPK: idSPK);
      await frameRepository.removeSPKFromMap(idSPK: idSPK.toString());

      // await csuFrameRepository.clearNGStorage();
      // await csRepository.clearCSJenisStorage();
      // await csItemsRepository.clearCSItemsStorage();
      // await csuFrameRepository.clearCSUResultStorage();
      // await csuItemsRepository.clearCSUItemsStorage();
      // await customerRepository.clearCustomerStorage();
      // await csuJenisPenyebabRepository.clearJenisStorage();
      // await csuJenisPenyebabRepository.clearPenyebabStorage();
      // await gateRepository.clearGateStorage();

      return right(unit);
    } on FormatException catch (e) {
      return left(LocalFailure.format('In clearAllStorage $e'));
    } on PlatformException {
      return left(LocalFailure.storage());
    }
  }
}
