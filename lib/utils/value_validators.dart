import 'package:dartz/dartz.dart';

import '../domain/failures.dart';

Either<ValueFailure<String>, String> validateMaxStringLength(
  String input,
  int maxLength,
) {
  if (input.length <= maxLength) {
    return right(input);
  } else {
    return left(
      ValueFailure.exceedingLength(failedValue: input, max: maxLength),
    );
  }
}

Either<ValueFailure<String>, String> validateStringNotEmpty(String input) {
  if (input.isNotEmpty) {
    return right(input);
  } else {
    return left(ValueFailure.empty(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateSingleLine(String input) {
  if (input.contains('\n')) {
    return left(ValueFailure.multiline(failedValue: input));
  } else {
    return right(input);
  }
}

Either<ValueFailure<String>, String> validateEmail(String input) {
  const emailRegex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
  if (RegExp(emailRegex).hasMatch(input)) {
    return right(input);
  } else {
    return left(ValueFailure.invalidEmail(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateIdKaryawan(String input) {
  if (input.length >= 5) {
    return right(input);
  } else {
    return left(ValueFailure.invalidIdKaryawan(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateNoHP(String input) {
  RegExp regex = RegExp(r'^(\+62|62|0)8[1-9][0-9]{6,9}$');
  if (regex.hasMatch(input)) {
    return right(input);
  } else {
    return left(ValueFailure.invalidNoHP(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateNama(String input) {
  if (input.length >= 5) {
    return right(input);
  } else {
    return left(ValueFailure.invalidName(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validatePassword(String input) {
  if (input.length >= 6) {
    return right(input);
  } else {
    return left(ValueFailure.shortPassword(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateJobdesk(String input) {
  if (input.isNotEmpty) {
    return right(input);
  } else {
    return left(ValueFailure.invalidJobdesk(failedValue: input));
  }
}

// ISENG
Either<ValueFailure<String>, String> validateJam(String input) {
  RegExp timePattern = RegExp(r'^([01]\d|2[0-3]):[0-5]\d$');
  if (timePattern.hasMatch(input)) {
    // debugger();

    return right(input);
  } else {
    // debugger();

    return left(ValueFailure.invalidJam(failedValue: input));
  }
}
