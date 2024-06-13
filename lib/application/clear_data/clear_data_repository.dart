import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../domain/local_failure.dart';
import '../../infrastructure/double_repository/double_repository.dart';
import '../../infrastructure/frame/frame_repository.dart';
import '../../infrastructure/model/model_repository.dart';
import '../../infrastructure/spk/spk_repository.dart';

class ClearDataRepository {
  ClearDataRepository({
    required this.spkRepository,
    required this.frameRepository,
    required this.modelRepository,
    required this.doubleRepository,
  });

  final SPKRepository spkRepository;
  final FrameRepository frameRepository;
  final ModelRepository modelRepository;
  final DoubleRepository doubleRepository;

  // Future<bool> hasOfflineData() => getCSJenisOFFLINE()
  //     .then((credentials) => credentials.fold((_) => false, (_) => true));

  Future<Either<LocalFailure, Unit>> clearAllStorage() async {
    try {
      await spkRepository.clearSPKStorage();
      await frameRepository.clearFrameStorage();
      await modelRepository.clearModelStorage();
      await doubleRepository.clear();

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
