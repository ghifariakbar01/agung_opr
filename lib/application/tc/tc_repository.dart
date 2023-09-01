import '../../infrastructure/credentials_storage.dart';

class TCRepository {
  TCRepository(this._storage);

  final CredentialsStorage _storage;

  Future<String?> getSaved() async {
    final response = await _storage.read();

    if (response != null) {
      return response;
    } else {
      return null;
    }
  }

  Future<void> save(String visited) async {
    await _storage.save(visited);
  }
}
