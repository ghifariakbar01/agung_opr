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

class CustomerId extends ValueObject<String> {
  factory CustomerId(String input) {
    return CustomerId._(validateStringNotEmpty(input));
  }

  const CustomerId._(this.value);

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

/// UPDATE [CSU], ALL ONLY VERIFY FOR [validateStringNotEmpty]
///
class Gate extends ValueObject<String> {
  factory Gate(String input) {
    return Gate._(validateStringNotEmpty(input));
  }

  const Gate._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

class Deck extends ValueObject<String> {
  factory Deck(String input) {
    return Deck._(validateStringNotEmpty(input));
  }

  const Deck._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

class Supir1 extends ValueObject<String> {
  factory Supir1(String input) {
    return Supir1._(validateStringNotEmpty(input));
  }

  const Supir1._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

class Supir2 extends ValueObject<String> {
  factory Supir2(String input) {
    return Supir2._(validateStringNotEmpty(input));
  }

  const Supir2._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

class SupirSDR extends ValueObject<String> {
  factory SupirSDR(String input) {
    return SupirSDR._(validateStringNotEmpty(input));
  }

  const SupirSDR._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

class TglTerima extends ValueObject<String> {
  factory TglTerima(String input) {
    return TglTerima._(validateStringNotEmpty(input));
  }

  const TglTerima._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

class TglKirim extends ValueObject<String> {
  factory TglKirim(String input) {
    return TglKirim._(validateStringNotEmpty(input));
  }

  const TglKirim._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

/// UPDATE [CS], ALL, BUT [JamLoad] ONLY VERIFY FOR [validateStringNotEmpty]
///
class IdKRChk extends ValueObject<String> {
  factory IdKRChk(String input) {
    return IdKRChk._(validateStringNotEmpty(input));
  }

  const IdKRChk._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

class IdSPK extends ValueObject<String> {
  factory IdSPK(String input) {
    return IdSPK._(validateStringNotEmpty(input));
  }

  const IdSPK._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

class Nopol extends ValueObject<String> {
  factory Nopol(String input) {
    return Nopol._(validateStringNotEmpty(input));
  }

  const Nopol._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

class JamLoad extends ValueObject<String> {
  factory JamLoad(String input) {
    return JamLoad._(validateJam(input));
  }

  const JamLoad._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

class Status extends ValueObject<String> {
  factory Status(String input) {
    return Status._(validateStringNotEmpty(input));
  }

  const Status._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

class Tipe extends ValueObject<String> {
  factory Tipe(String input) {
    return Tipe._(validateStringNotEmpty(input));
  }

  const Tipe._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}
