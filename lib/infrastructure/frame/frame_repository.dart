import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/application/update_frame/frame.dart';
import 'package:agung_opr/domain/remote_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../domain/local_failure.dart';
import '../credentials_storage.dart';
import '../exceptions.dart';
import 'frame_remote_service.dart';

/// [SAVED] MODEL => [
/* 
    Map<String, List<Map<String, dynamic>>> 

    example:

   {
    "159090":[{"id_unit":715545,"frame":"DUMMY 260","engine":"","warna":"","no_reff_expor":null,"id_kend_type":0},
        {"id_unit":715546,"frame":"DUMMY 259","engine":"","warna":"","no_reff_expor":null,"id_kend_type":0},
        {"id_unit":715547,"frame":"DUMMY 258","engine":"","warna":"","no_reff_expor":null,"id_kend_type":0}],
    "159091":[{"id_unit":715542,"frame":"DUMMY 263","engine":"","warna":"","no_reff_expor":null,"id_kend_type":0},
        {"id_unit":715543,"frame":"DUMMY 262","engine":"","warna":"","no_reff_expor":null,"id_kend_type":0},
        {"id_unit":715544,"frame":"DUMMY 261","engine":"","warna":"","no_reff_expor":null,"id_kend_type":0}],
    "159041":[{"id_unit":715479,"frame":"DUMMY 324","engine":"","warna":"","no_reff_expor":null,"id_kend_type":0},
        {"id_unit":715480,"frame":"DUMMY 323","engine":"","warna":"","no_reff_expor":null,"id_kend_type":0},
        {"id_unit":715481,"frame":"DUMMY 322","engine":"","warna":"","no_reff_expor":null,"id_kend_type":0},
        {"id_unit":715482,"frame":"DUMMY 321","engine":"","warna":"","no_reff_expor":null,"id_kend_type":0},
        {"id_unit":715483,"frame":"DUMMY 320","engine":"","warna":"","no_reff_expor":null,"id_kend_type":0},
        {"id_unit":715484,"frame":"DUMMY 319","engine":"","warna":"","no_reff_expor":null,"id_kend_type":0}],
    "159075":[{"id_unit":715436,"frame":"MHFABBAA8P0405989","engine":"","warna":"","no_reff_expor":"","id_kend_type":5705},
        {"id_unit":715437,"frame":"MHKA6GJ6JPJ661096","engine":"","warna":"","no_reff_expor":"","id_kend_type":41},
        {"id_unit":715438,"frame":"MHFAA8GS2P0904325","engine":"","warna":"","no_reff_expor":"","id_kend_type":38},
        {"id_unit":715439,"frame":"MHKA6GJ6JPJ663738","engine":"","warna":"","no_reff_expor":"","id_kend_type":41}]
    }
*/
class FrameRepository {
  FrameRepository(
    this._remoteService,
    this._storage,
  );

  final FrameRemoteService _remoteService;
  final CredentialsStorage _storage;

  Future<bool> hasOfflineData() => getStorageCondition()
      .then((credentials) => credentials.fold((_) => false, (_) => true));

  Future<bool> hasOfflineDataIndex(int idSPK) =>
      getFrameListOFFLINE(idSPK: idSPK)
          .then((credentials) => credentials.fold((_) => false, (_) => true));

  Future<Either<LocalFailure, Unit>> saveFrameIndexedSPK(
      {required int idSPK, required int index, required Frame newFrame}) async {
    try {
      final saveThisMap = {
        idSPK.toString(): [newFrame]
      };

      // debugger(message: 'called');

      log('SAVE FRAME INDEXED MAP: ${saveThisMap}');

      await this
          ._GETAndADDFrameInMap(newFrame: saveThisMap, indexIdUnit: index);

      return right(unit);
    } on FormatException catch (e) {
      return left(LocalFailure.format(e.message));
    } on JsonUnsupportedObjectError {
      return left(LocalFailure.format('JsonUnsupportedObjectError'));
    } on PlatformException {
      return left(LocalFailure.storage());
    }
  }

  Future<Either<LocalFailure, Map<String, Map<String, String>>>>
      removeSPKFromMap({required String idSPK}) async {
    try {
      final savedStrings = await _storage.read();
      final isSPKOK = idSPK.isNotEmpty;
      final isStorageSaved = savedStrings != null;

      if (isSPKOK) {
        switch (isStorageSaved) {
          case true:
            () async {
              // debugger(message: 'CALLED');
              final parsedResponse =
                  jsonDecode(savedStrings!) as Map<String, dynamic>;

              final Map<String, List<Frame>> parsedMap =
                  convertMaptoListMap(map: parsedResponse);

              parsedMap.remove(idSPK);

              final newFrameMap =
                  convertListFrameToListMap(parsedMap: parsedMap);

              log('STORAGE FRAME UPDATE: ${jsonEncode(newFrameMap)}');

              await _storage.save(jsonEncode(newFrameMap));

              // debugger(message: 'called');

              log('STORAGE UPDATE FRAME DELETE: ${jsonEncode(newFrameMap)}');

              return {};
            }();
            break;
          case false:
            return left(LocalFailure.empty());
        }
      }

      return left(LocalFailure.empty());
    } on RangeError catch (e) {
      return left(LocalFailure.format(e.message));
    } on FormatException catch (e) {
      return left(LocalFailure.format(e.message));
    } on JsonUnsupportedObjectError {
      return left(LocalFailure.format('JsonUnsupportedObjectError'));
    } on PlatformException {
      return left(LocalFailure.storage());
    }
  }

  Future<Either<RemoteFailure, List<Frame>>> getFrameList(
      {required int idSPK}) async {
    try {
      final modelMapList = await _remoteService.getFrameList(idSPK: idSPK);

      await this._GETAndADDFrameInMap(newFrame: modelMapList);

      if (modelMapList["$idSPK"] != null) {
        return right(modelMapList["$idSPK"] as List<Frame>);
      } else {
        return right([]);
      }
    } on RestApiException catch (e) {
      return left(RemoteFailure.server(e.errorCode, e.message));
    } on NoConnectionException {
      return left(RemoteFailure.noConnection());
    } on FormatException catch (e) {
      return left(RemoteFailure.parse(message: e.message));
    } on JsonUnsupportedObjectError {
      return left(RemoteFailure.parse(message: 'JsonUnsupportedObjectError'));
    } on PlatformException {
      return left(RemoteFailure.storage());
    }
  }

  // SAVE MAP IN STORAGE
  Future<Unit> _GETAndADDFrameInMap(
      {required Map<String, List<Frame>> newFrame, int? indexIdUnit}) async {
    final savedStrings = await _storage.read();
    final isNewFrameOK = newFrame.values.isNotEmpty;
    final isStorageSaved = savedStrings != null;

    if (isNewFrameOK) {
      switch (isStorageSaved) {
        case true:
          () async {
            // debugger(message: 'CALLED');
            final parsed = jsonDecode(savedStrings!) as Map<String, dynamic>;

            final Map<String, List<Frame>> parsedMap =
                convertMaptoListMap(map: parsed);

            // FIRST, CHECK IF EXISTING KEY EXIST
            final key = newFrame.keys.first;
            final newValue = newFrame.values.first;

            if (parsedMap.containsKey(key) && indexIdUnit != null) {
              final oldValue = parsedMap[key] ?? [];

              final frame = newValue.first;

              // Map<String, dynamic> OF FRAMES
              final list = [...oldValue];

              list[indexIdUnit] = frame;

              // debugger(message: 'called');

              log('STORAGE FRAME UPDATE: $list');

              parsedMap.update(key, (value) => list);
            }
            // IF EXISTING KEY EXIST, BUT NOT UPDATE SPECIFIC FRAME,
            // PARAM IS FRAME AS WHOLE
            else if (parsedMap.containsKey(key) && indexIdUnit == null) {
              final frameList = newValue;

              // debugger(message: 'called');

              log('STORAGE FRAME GET: $frameList');

              parsedMap.update(key, (value) => frameList);
            }
            // IF EXISTING KEY NULL
            else {
              // debugger(message: 'called');

              parsedMap.addAll({key: newValue});
            }

            // debugger(message: 'called');

            final newFrameMap = convertListFrameToListMap(parsedMap: parsedMap);

            log('STORAGE FRAME UPDATE: ${jsonEncode(newFrameMap)}');

            await _storage.save(jsonEncode(newFrameMap));

            return unit;
          }();
          break;
        case false:
          () async {
            // debugger(message: 'called');

            final jsonFrames = convertFrameToListMap(listMap: newFrame);

            final newFrameMap = {'${newFrame.keys.first}': jsonFrames};

            log('STORAGE FRAME SAVE: ${jsonEncode(newFrameMap)}');

            await _storage.save(jsonEncode(newFrameMap));

            return unit;
          }();
      }
    } else {
      throw FormatException(
          'newFrame is Empty. In frame_repository _GETAndADDFrameInMap');
    }

    return unit;
  }

  /// DATA: LIST OF [Frame] FROM STORAGE
  ///
  /// process [idSPK] and get LIST OF [Frame]
  Future<Either<RemoteFailure, List<Frame>>> getFrameListOFFLINE(
      {required int idSPK}) async {
    try {
      final frameStorage = await _storage.read();

      // debugger(message: 'called');

      log('FRAME STORAGE: $frameStorage');

      // HAS MAP
      if (frameStorage != null) {
        // debugger(message: 'called');

        final responsMap = jsonDecode(frameStorage) as Map<String, dynamic>;

        final response = convertMaptoListMap(map: responsMap);

        // debugger(message: 'called');

        log('FRAME STORAGE RESPONSE: $response');

        final key = idSPK.toString();

        if (response.containsKey(key)) {
          // debugger(message: 'called');

          final frames = response[key] ?? [];

          return right(frames);
        } else {
          // debugger(message: 'called');

          return left(RemoteFailure.parse(message: 'LIST EMPTY'));
        }
      } else {
        // debugger(message: 'called');

        return left(RemoteFailure.parse(message: 'LIST EMPTY'));
      }
    } on RestApiException catch (e) {
      // debugger(message: 'called');

      return left(RemoteFailure.server(e.errorCode, e.message));
    } on NoConnectionException {
      // debugger(message: 'called');

      return left(RemoteFailure.noConnection());
    } on FormatException catch (error) {
      // debugger(message: 'called');

      return left(RemoteFailure.parse(message: error.message));
    }
  }

  Future<Either<LocalFailure, String?>> getStorageCondition() async {
    try {
      final storedCredentials = await _storage.read();

      if (storedCredentials == null) {
        return left(LocalFailure.empty());
      }

      // debugger(message: 'called');

      return right(storedCredentials);
    } on FormatException {
      return left(LocalFailure.format('Error while parsing'));
    } on PlatformException {
      return left(LocalFailure.storage());
    }
  }

  // CONVERT dynamic => List<Frame>
  Map<String, List<Frame>> convertMaptoListMap(
      {required Map<String, dynamic> map}) {
    final Map<String, List<Frame>> returnMap = {};

    final tempMapParam = map;

    tempMapParam.forEach((key, element) {
      final List<Frame> frameJson = [];

      // CASTING 1 => TO LIST
      final list = element as List;

      list.forEach((element) {
        frameJson.add(Frame.fromJson(element));
      });

      returnMap.addAll({key: frameJson});
    });

    return returnMap;
  }

  //  Map<String, List<Frame>> ==> Map<String, List<Map<String, dynamic>>>
  Map<String, List<Map<String, dynamic>>> convertListFrameToListMap(
      {required Map<String, List<Frame>> parsedMap}) {
    // parsedMap is Map<String, List<Frame>>
    final Map<String, List<Map<String, dynamic>>> newFrameMap = {};

    parsedMap.forEach(
      (key, value) {
        final List<Map<String, dynamic>> frameJsons = [];

        for (final frameValue in value) {
          frameJsons.add(frameValue.toJson());
        }

        newFrameMap.addAll({key: frameJsons});
      },
    );

    return newFrameMap;
  }

  List<Map<String, dynamic>> convertFrameToListMap(
      {required Map<String, List<Frame>> listMap}) {
    final List<Map<String, dynamic>> jsonFrames = [];

    // debugger(message: 'called');

    listMap.values.forEach((element) {
      final json = element as List<Frame>;

      json.forEach((element) {
        jsonFrames.add(element.toJson());
      });
    });

    return jsonFrames;
  }

  List<Frame> decodeMapToFrame(
      {required List<Map<String, dynamic>> jsonFrames}) {
    final List<Frame> frame = [];

    // debugger(message: 'called');

    jsonFrames.forEach((element) {
      frame.add(Frame.fromJson(element));
    });

    return frame;
  }
}
