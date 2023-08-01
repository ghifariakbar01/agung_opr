import 'package:dartz/dartz.dart';

import '../../../utils/value_validators.dart';
import 'failures.dart';
import 'value_objects.dart';

class Email extends ValueObject<String> {
  factory Email(String input) {
    return Email._(
      validateStringNotEmpty(input).flatMap(validateEmail),
    );
  }

  const Email._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

class IdKaryawan extends ValueObject<String> {
  factory IdKaryawan(String input) {
    return IdKaryawan._(
      validateStringNotEmpty(input).flatMap(validateIdKaryawan),
    );
  }

  const IdKaryawan._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

class NoHP extends ValueObject<String> {
  factory NoHP(String input) {
    return NoHP._(
      validateStringNotEmpty(input).flatMap(validateNoHP),
    );
  }

  const NoHP._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

class Nama extends ValueObject<String> {
  factory Nama(String input) {
    return Nama._(
      validateStringNotEmpty(input).flatMap(validateNama),
    );
  }

  const Nama._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

class UserId extends ValueObject<String> {
  factory UserId(String input) {
    return UserId._(validateStringNotEmpty(input));
  }

  const UserId._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

class Password extends ValueObject<String> {
  factory Password(String input) {
    return Password._(
      validatePassword(input),
    );
  }

  const Password._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

class UserToken extends ValueObject<String> {
  factory UserToken(String input) {
    return UserToken._(
      validateStringNotEmpty(input),
    );
  }

  const UserToken._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

/// UPDATE [SPK], ALL ONLY VERIFY FOR [validateStringNotEmpty]
///
class IDUnit extends ValueObject<String> {
  factory IDUnit(String input) {
    return IDUnit._(validateStringNotEmpty(input));
  }

  const IDUnit._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

class FrameUnit extends ValueObject<String> {
  factory FrameUnit(String input) {
    return FrameUnit._(validateStringNotEmpty(input));
  }

  const FrameUnit._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

class EngineUnit extends ValueObject<String> {
  factory EngineUnit(String input) {
    return EngineUnit._(validateStringNotEmpty(input));
  }

  const EngineUnit._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

class WarnaUnit extends ValueObject<String> {
  factory WarnaUnit(String input) {
    return WarnaUnit._(validateStringNotEmpty(input));
  }

  const WarnaUnit._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

class NoReffEXP extends ValueObject<String> {
  factory NoReffEXP(String input) {
    return NoReffEXP._(validateStringNotEmpty(input));
  }

  const NoReffEXP._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

class SPPDC extends ValueObject<String> {
  factory SPPDC(String input) {
    return SPPDC._(validateStringNotEmpty(input));
  }

  const SPPDC._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

class IDKendType extends ValueObject<String> {
  factory IDKendType(String input) {
    return IDKendType._(validateStringNotEmpty(input));
  }

  const IDKendType._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}
