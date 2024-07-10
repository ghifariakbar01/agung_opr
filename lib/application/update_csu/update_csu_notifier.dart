import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../domain/local_failure.dart';
import '../../domain/value_objects_copy.dart';
import '../../infrastructure/update_csu/update_csu_repository.dart';

import '../../utils/validator.dart';
import '../check_sheet/unit/state/csu_id_query.dart';
import '../check_sheet/unit/state/csu_items/csu_items.dart';
import '../check_sheet/unit/state/csu_ng/csu_ng_result.dart';
import '../check_sheet/unit/state/csu_result.dart';
import 'state/update_csu_form_state.dart';
import 'state/update_csu_ng_state.dart';
import 'state/update_csu_state.dart';

class UpdateCSUNotifier extends StateNotifier<UpdateCSUState> {
  UpdateCSUNotifier(
    this._repository,
  ) : super(UpdateCSUState.initial());

  final UpdateCSUFrameRepository _repository;

  void changeFillInitial() {
    state = state.copyWith(
      updateFrameList: state.updateFrameList.copyWith(
        inOut: false,
        gate: Gate(''),
        deck: Deck(''),
        supirSDR: SupirSDR(''),
        tglTerima: TglTerima(''),
        tglKirim: TglKirim(''),
        keterangan: Keterangan(''),
        gateTextController: TextEditingController(),
        deckTextController: TextEditingController(),
        supirSDRTextController: TextEditingController(),
        tglTerimaTextController: TextEditingController(),
        tglKirimTextController: TextEditingController(),
        keteranganTextController: TextEditingController(),
      ),
    );
  }

  void changeFillWithValue({required CSUResult csuResult}) {
    final _tglKirim = csuResult.tglKirim == null
        ? ''
        : DateFormat('yyyy-MM-dd').format(DateTime.parse(csuResult.tglKirim!));

    final _tglTerima = csuResult.tglTerima == null
        ? ''
        : DateFormat('yyyy-MM-dd').format(DateTime.parse(csuResult.tglTerima!));

    state = state.copyWith(
      updateFrameList: state.updateFrameList.copyWith(
        inOut: csuResult.inout == false ? true : false,
        gate: Gate(csuResult.idGate.toString()),
        deck: Deck(csuResult.posisi ?? ''),
        supirSDR: SupirSDR(csuResult.supirSDR ?? ''),
        tglKirim: TglKirim(_tglKirim),
        tglTerima: TglTerima(_tglTerima),
        keterangan: Keterangan(csuResult.keterangan ?? ''),
        gateTextController:
            TextEditingController(text: csuResult.idGate.toString()),
        deckTextController: TextEditingController(text: csuResult.posisi ?? ''),
        supirSDRTextController:
            TextEditingController(text: csuResult.supirSDR ?? ''),
        tglTerimaTextController: TextEditingController(text: _tglTerima),
        tglKirimTextController: TextEditingController(text: _tglKirim),
        keteranganTextController:
            TextEditingController(text: csuResult.keterangan ?? ''),
      ),
    );
  }

  void changeFillNG({required List<CSUNGResult> csuNGResult}) {
    for (int i = 0; i < csuNGResult.length; i++) {
      final NG = csuNGResult[i];

      int index = 0;

      final List<List<int>> ranges = state.updateFrameList.idNGRanges;

      for (int i = 0; i < ranges.length; i++) {
        ranges[i].any((element) => element == NG.idItem) ? index = i : () {};
      }

      final NGList = [...state.updateFrameList.isNG];

      NGList[index] = true;

      state = state.copyWith(
        updateFrameList: state.updateFrameList.copyWith(isNG: NGList),
      );

      final NGItemsList = [
        ...state.updateFrameList.ngStates
            .mapIndexed((idx, element) => idx == index
                ? UpdateCSUNGState(
                    ket: NG.ket,
                    idItem: NG.idItem,
                    idJenis: NG.idJenis,
                    idPosisi: NG.idPosisi,
                  )
                : element)
            .toList()
      ];

      // Update the state with the new list
      state = state.copyWith(
        updateFrameList: state.updateFrameList.copyWith(ngStates: NGItemsList),
      );
    }
  }

  void processNewCSUItems({required List<CSUItems> items}) {
    final entries = items.groupListsBy((element) => element.Grup);

    final len = entries.keys.length;

    final List<List<int>> ranges = [];

    for (final en in entries.entries) {
      final _list = en.value.map((e) => e.id).toList();
      ranges.add(_list);
    }

    changeIdRanges(idNGRanges: ranges);
    changeFillEmptyList(length: len);
  }

  void changeIdRanges({required List<List<int>> idNGRanges}) {
    state = state.copyWith(
      updateFrameList: state.updateFrameList.copyWith(
        idNGRanges: idNGRanges,
      ),
    );
  }

  void changeFillEmptyList({required int length}) {
    final generateIsNG = List.generate(
      length,
      (index) => false,
    );

    state = state.copyWith(
      updateFrameList: state.updateFrameList.copyWith(isNG: generateIsNG),
    );

    final generateNGStates = List.generate(
      length,
      (index) => UpdateCSUNGState.initial(),
    );

    state = state.copyWith(
      updateFrameList:
          state.updateFrameList.copyWith(ngStates: generateNGStates),
    );
  }

  Future<void> saveQuery() async {
    Either<LocalFailure, Unit>? FOS;

    if (isValid()) {
      state = state.copyWith(
        isProcessing: true,
        FOSOUpdateCSU: none(),
        showErrorMessages: false,
      );

      final UpdateCSUFrameStateSingle updateState = state.updateFrameList;
      final List<bool> NG = state.updateFrameList.isNG;

      final isNG = NG.firstWhere(
        (element) => element == true,
        orElse: () => false,
      );

      final CSUIDQuery queryId = await _repository.getOKSavableQuery(
          idUnit: state.idUnit,
          frameName: state.frameName,
          gate: updateState.gate,
          posisi: updateState.deck,
          supirSDR: updateState.supirSDR,
          tglKirim: updateState.tglKirim,
          tglTerima: updateState.tglTerima,
          keterangan: updateState.keterangan,
          noDefect: isNG == true ? 1 : 0,
          inOut: updateState.inOut == false ? 0 : 1);

      final List<UpdateCSUNGState> queryNgs = [];

      // GET NG ITEM, JENIS, PENYEBAB
      for (int index = 0; index < NG.length; index++) {
        if (NG[index] == true) {
          final UpdateCSUNGState updateStateNotGood =
              state.updateFrameList.ngStates[index];
          queryNgs.add(updateStateNotGood);
        }
      }

      final CSUIDQuery queryIdNG = await _repository.getNGSavableQuery(
        ngStates: queryNgs,
        idUnit: state.idUnit,
        frameName: state.frameName,
      );

      final CSUIDQuery csuIdQuery = CSUIDQuery(
        query: queryIdNG.query + queryId.query,
        idUnit: state.idUnit,
      );

      FOS = await _repository.saveCSUQuery(
        queryId: csuIdQuery,
        isNG: isNG,
      );

      state = state.copyWith(
          isProcessing: false,
          showErrorMessages: false,
          FOSOUpdateCSU: optionOf(FOS));
    } else {
      state = state.copyWith(
        showErrorMessages: true,
      );
    }
  }

  void changeIsNG({required bool isNG, required int index}) {
    final list = [...state.updateFrameList.isNG]; // Create a copy of the list

    // Update the element at the given index
    list[index] = isNG;

    // Update the state with the new list
    state = state.copyWith(
        updateFrameList: state.updateFrameList.copyWith(isNG: list));
  }

  void changeNGKet({required String ket, required int index}) {
    final list = [
      ...state.updateFrameList.ngStates
    ]; // Create a copy of the list

    final elementAt = list.elementAt(index).copyWith(ket: ket);

    // Update the element at the given index
    list[index] = elementAt;

    // Update the state with the new list
    state = state.copyWith(
        updateFrameList: state.updateFrameList.copyWith(ngStates: list));
  }

  void changeNGId({required int id, required int index}) {
    final list = [
      ...state.updateFrameList.ngStates
    ]; // Create a copy of the list

    final elementAt = list.elementAt(index).copyWith(idItem: id);

    // Update the element at the given index
    list[index] = elementAt;

    // Update the state with the new list
    state = state.copyWith(
        updateFrameList: state.updateFrameList.copyWith(ngStates: list));
  }

  void changeNGJenis({required int id, required int index}) {
    final list = [
      ...state.updateFrameList.ngStates
    ]; // Create a copy of the list

    final elementAt = list.elementAt(index).copyWith(idJenis: id);

    // Update the element at the given index
    list[index] = elementAt;

    // Update the state with the new list
    state = state.copyWith(
        updateFrameList: state.updateFrameList.copyWith(ngStates: list));
  }

  void changeNGPosisi({required int id, required int index}) {
    final list = [
      ...state.updateFrameList.ngStates
    ]; // Create a copy of the list

    final elementAt = list.elementAt(index).copyWith(idPosisi: id);

    // Update the element at the given index
    list[index] = elementAt;

    // Update the state with the new list
    state = state.copyWith(
        updateFrameList: state.updateFrameList.copyWith(ngStates: list));
  }

  void changeIdUnitAndFrameName(
    int idUnit,
    String frameName,
  ) {
    state = state.copyWith(
      idUnit: idUnit,
      frameName: frameName,
      FOSOUpdateCSU: none(),
    );
  }

  void changeIdCS(int idCS) {
    state = state.copyWith(
      idCS: idCS,
      FOSOUpdateCSU: none(),
    );
  }

  void changeGate(String gateStr) {
    state = state.copyWith(
      updateFrameList: state.updateFrameList.copyWith(gate: Gate(gateStr)),
      FOSOUpdateCSU: none(),
    );
  }

  void changeDeck(String deckStr) {
    state = state.copyWith(
      updateFrameList: state.updateFrameList.copyWith(deck: Deck(deckStr)),
      FOSOUpdateCSU: none(),
    );
  }

  void changeSupir1(String supirStr) {
    state = state.copyWith(
      updateFrameList: state.updateFrameList.copyWith(supir1: Supir1(supirStr)),
      FOSOUpdateCSU: none(),
    );
  }

  void changeSupir2(String supirStr) {
    state = state.copyWith(
      updateFrameList: state.updateFrameList.copyWith(supir2: Supir2(supirStr)),
      FOSOUpdateCSU: none(),
    );
  }

  void changeSupirSDR(String supirStr) {
    state = state.copyWith(
      updateFrameList:
          state.updateFrameList.copyWith(supirSDR: SupirSDR(supirStr)),
      FOSOUpdateCSU: none(),
    );
  }

  void changeTglTerima(String tglTerimaStr) {
    state = state.copyWith(
      updateFrameList:
          state.updateFrameList.copyWith(tglTerima: TglTerima(tglTerimaStr)),
      FOSOUpdateCSU: none(),
    );
  }

  void changeTglKirim(String tglKirimStr) {
    state = state.copyWith(
      updateFrameList:
          state.updateFrameList.copyWith(tglKirim: TglKirim(tglKirimStr)),
      FOSOUpdateCSU: none(),
    );
  }

  void changeKeterangan(String keteranganStr) {
    state = state.copyWith(
      updateFrameList:
          state.updateFrameList.copyWith(keterangan: Keterangan(keteranganStr)),
      FOSOUpdateCSU: none(),
    );
  }

  bool isTappable({
    required CSUResult csuResult,
    required List<CSUResult> csuResultItems,
  }) {
    Map<bool, List<CSUResult>> listGroupByGate = csuResultItems
        .groupListsBy((element) => element.gate == csuResult.gate);

    // USE FIRST, SINCE ONLY 1 LIST
    List<CSUResult> listCSUResult = listGroupByGate.values.first;

    if (listCSUResult.length == 2) {
      final _list = listCSUResult.firstWhereOrNull(
        (element) => element.inout == true,
      );

      bool isOut = _list == null ? false : _list.inout!;

      return isOut ? true : true;
    }

    return true;
  }

  bool isValid() {
    final _state = state.updateFrameList;

    // HERE
    final values = [
      _state.gate,
      // frame.deck,
      // frame.supir1,
      // frame.supir2,
      // frame.supirSDR,
      // frame.tglTerima,
      // frame.tglKirim,
      // frame.keterangan
    ];

    return Validator.validate(values);
  }
}
