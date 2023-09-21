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
  ClearDataRepository(
      {required this.csRepository,
      required this.spkRepository,
      required this.gateRepository,
      required this.frameRepository,
      required this.csItemsRepository,
      required this.csuFrameRepository,
      required this.csuItemsRepository,
      required this.customerRepository,
      required this.csuJenisPenyebabRepository});

  final CSRepository csRepository;
  final SPKRepository spkRepository;
  final GateRepository gateRepository;
  final FrameRepository frameRepository;
  final CSItemsRepository csItemsRepository;
  final CSUFrameRepository csuFrameRepository;
  final CSUItemsRepository csuItemsRepository;
  final CustomerRepository customerRepository;
  final CSUJenisPenyebabRepository csuJenisPenyebabRepository;

  // Future<bool> hasOfflineData() => getCSJenisOFFLINE()
  //     .then((credentials) => credentials.fold((_) => false, (_) => true));

  Future<Either<LocalFailure, Unit>> clearAllStorage() async {
    try {
      await spkRepository.clearSPKStorage();
      await gateRepository.clearGateStorage();
      await csRepository.clearCSJenisStorage();
      await csuFrameRepository.clearNGStorage();
      await frameRepository.clearFrameStorage();
      await csItemsRepository.clearCSItemsStorage();
      await csuFrameRepository.clearCSUResultStorage();
      await csuItemsRepository.clearCSUItemsStorage();
      await customerRepository.clearCustomerStorage();
      await csuJenisPenyebabRepository.clearJenisStorage();
      await csuJenisPenyebabRepository.clearPenyebabStorage();

      return right(unit);
    } on FormatException catch (e) {
      return left(LocalFailure.format('In clearAllStorage $e'));
    } on PlatformException {
      return left(LocalFailure.storage());
    }
  }
}
