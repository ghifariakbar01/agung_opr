import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../domain/local_failure.dart';
import '../../infrastructure/cs/cs_items_repository.dart';
import '../../infrastructure/cs/cs_repository.dart';
import '../../infrastructure/csu/csu_items_repository.dart';
import '../../infrastructure/csu/csu_jenis_penyebab_repository.dart';
import '../../infrastructure/csu/csu_repository.dart';
import '../../infrastructure/customer/customer_repository.dart';
import '../../infrastructure/frame/frame_repository.dart';
import '../../infrastructure/gate/gate_repository.dart';
import '../../infrastructure/spk/spk_repository.dart';

/// [SAVED] MODEL =>
///
/// [
///   [CSJenis]
///
/// ]

class ClearDataRepository {
  ClearDataRepository({
    required this.spkRepository,
    required this.frameRepository,
  });

  final SPKRepository spkRepository;
  final FrameRepository frameRepository;

  // Future<bool> hasOfflineData() => getCSJenisOFFLINE()
  //     .then((credentials) => credentials.fold((_) => false, (_) => true));

  Future<Either<LocalFailure, Unit>> clearAllStorage() async {
    try {
      await spkRepository.clearSPKStorage();
      await frameRepository.clearFrameStorage();

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
