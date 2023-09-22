import 'package:dartz/dartz.dart';

import '../domain/remote_failure.dart';

abstract class Cache<T, Y> {
  Future<Either<RemoteFailure, List<T>>> getByKey(String key);
  Future<Unit> setByKey(String key, Y value);
}
