import 'dart:convert';

import 'package:collection/collection.dart';

import '../../application/double/double.dart';
import '../credentials_storage.dart';

class DoubleRepository {
  DoubleRepository(
    this._credentialsStorage,
  );

  final CredentialsStorage _credentialsStorage;

  Future<List<SPKDouble>> get() async {
    final _prev = await _credentialsStorage.read();

    if (_prev == null) {
      return [];
    }

    final _list =
        (jsonDecode(_prev) as List).map((e) => SPKDouble.fromJson(e)).toList();

    return _list;
  }

  Future<void> save(SPKDouble double) async {
    final _list = await get();

    final _save = find(double, _list);
    final _s = jsonEncode(_save);

    return _credentialsStorage.save(_s);
  }

  List<SPKDouble> find(
    SPKDouble double,
    List<SPKDouble> _list,
  ) {
    if (_list.isEmpty) {
      return [double];
    }

    final _el = _list.firstWhereOrNull(
      (element) => element.idSpk == double.idSpk,
    );

    if (_el == null) {
      return [..._list, double];
    }

    return [..._list.map((e) => e.idSpk == double.idSpk ? double : e)];
  }

  Future<void> removeAt(SPKDouble double) async {
    final _list = await get();

    if (_list.isEmpty) {
      return;
    }

    final _list2 = _list.where((element) => element != double).toList();
    final _save = [..._list2];
    final _s = jsonEncode(_save);

    return _credentialsStorage.save(_s);
  }

  Future<void> clear() async {
    return _credentialsStorage.clear();
  }
}
