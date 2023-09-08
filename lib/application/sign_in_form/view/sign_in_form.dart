import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../style/style.dart';
import '../../../shared/providers.dart';
import '../../password_expired/password_expired_state.dart';
import '../../profile/widgets/profile_label.dart';
import '../../remember_me/remember_me_state.dart';

class SignInForm extends ConsumerStatefulWidget {
  const SignInForm();

  @override
  ConsumerState<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends ConsumerState<SignInForm> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final rememberMe = prefs.getString('remember_me');

      if (rememberMe != null) {
        ref.read(signInFormNotifierProvider.notifier).changeRemember(true);

        ref.read(passwordVisibleProvider.notifier).state = false;

        final rememberMeState =
            RememberMeState.fromJson(jsonDecode(rememberMe));

        ref.read(signInFormNotifierProvider.notifier).changeAllData(
            idKaryawanStr: rememberMeState.nik,
            passwordStr: rememberMeState.password,
            userStr: rememberMeState.nama);
      }

      log('rememberMe ${rememberMe != null}');
    });
  }

  @override
  Widget build(BuildContext context) {
    final signInForm = ref.watch(signInFormNotifierProvider);

    final passwordVisible = ref.watch(passwordVisibleProvider);

    final userId = signInForm.userId.getOrLeave('');
    final password = signInForm.password.getOrLeave('');

    PasswordExpiredState passwordExpired =
        ref.watch(passwordExpiredNotifierStatusProvider);

    return Form(
      autovalidateMode: signInForm.showErrorMessages
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      child: Column(
        children: [
          passwordExpired.maybeWhen(
            expired: () => Text(
              'Password Anda Expired. Login menggunakan Password Baru.',
              style: Themes.customColor(FontWeight.bold, 14, Palette.red),
            ),
            orElse: () => Container(),
          ),
          SizedBox(
            height: 4,
          ),
          ProfileLabel(icon: Icons.person, label: 'Username'),
          SizedBox(
            height: 4,
          ),
          TextFormField(
            initialValue: signInForm.userId.getOrLeave(''),
            decoration: Themes.formStyle(userId != ''
                ? userId + ' (ketik untuk ubah teks)'
                : 'Masukkan username'),
            keyboardType: TextInputType.name,
            onChanged: (value) => ref
                .read(signInFormNotifierProvider.notifier)
                .changeUserId(value),
            validator: (_) =>
                ref.read(signInFormNotifierProvider).userId.value.fold(
                      (f) => f.maybeMap(
                        empty: (_) => 'kosong',
                        orElse: () => null,
                      ),
                      (_) => null,
                    ),
          ),
          const SizedBox(height: 16),
          ProfileLabel(icon: Icons.lock_rounded, label: 'Password'),
          SizedBox(
            height: 4,
          ),
          TextFormField(
            initialValue: signInForm.password.getOrLeave(''),
            decoration: Themes.formStyle(
              password != ''
                  ? '*password tersimpan*' + ' (ketik untuk ubah teks)'
                  : 'Masukkan password',
              icon: IconButton(
                  onPressed: () => ref
                      .read(passwordVisibleProvider.notifier)
                      .state = toggleBool(passwordVisible),
                  icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Palette.primaryColor,
                  )),
            ),
            obscureText: !passwordVisible,
            onChanged: (value) => ref
                .read(signInFormNotifierProvider.notifier)
                .changePassword(value),
            validator: (_) =>
                ref.read(signInFormNotifierProvider).password.value.fold(
                      (f) => f.maybeMap(
                        shortPassword: (_) => 'terlalu pendek',
                        orElse: () => null,
                      ),
                      (_) => null,
                    ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Checkbox(
                  key: UniqueKey(),
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: signInForm.isChecked,
                  onChanged: (_) => ref
                      .read(signInFormNotifierProvider.notifier)
                      .changeRemember(toggleBool(signInForm.isChecked))),
              SizedBox(
                width: 4,
              ),
              Text(
                'Remember Me',
                style: Themes.blue(FontWeight.normal, 14),
              )
            ],
          )
        ],
      ),
    );
  }

  bool toggleBool(bool visibility) {
    return visibility ? false : true;
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Palette.primaryColor;
  }
}
