part of 'sign_in_form_notifier.dart';

@freezed
class SignInFormState with _$SignInFormState {
  const factory SignInFormState({
    required NoKtp noKtp,
    required UserId userId,
    required Email email,
    required IdKaryawan idKaryawan,
    required Password password,
    required Jobdesk jobdesk,
    required bool showErrorMessages,
    required bool isSubmitting,
    required bool isChecked,
    required Option<Either<AuthFailure, Unit>> failureOrSuccessOption,
  }) = _SignInFormState;

  factory SignInFormState.initial() => SignInFormState(
        noKtp: NoKtp(''),
        userId: UserId(''),
        email: Email(''),
        idKaryawan: IdKaryawan(''),
        password: Password(''),
        jobdesk: Jobdesk('Cranny'),
        showErrorMessages: false,
        isSubmitting: false,
        isChecked: false,
        failureOrSuccessOption: none(),
      );
}
