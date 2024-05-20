import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../style/style.dart';
import '../../../shared/providers.dart';
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
      final _resp = prefs.getString('remember_me');

      if (_resp != null) {
        final _item = jsonDecode(_resp);
        final _respState = RememberMeState.fromJson(_item);
        ref.read(passwordVisibleProvider.notifier).state = false;

        ref.read(signInFormNotifierProvider.notifier).changeAllData(
              userStr: _respState.nama,
              idKaryawanStr: _respState.nik,
              jobdeskStr: _respState.jobdesk,
              passwordStr: _respState.password,
            );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final jobdesk = [
      'Cranny',
      'Driver',
    ];

    final signInForm = ref.watch(signInFormNotifierProvider);

    final passwordVisible = ref.watch(passwordVisibleProvider);

    final userId = signInForm.userId.getOrLeave('');
    final password = signInForm.password.getOrLeave('');
    final jobdeskUser = signInForm.jobdesk.getOrLeave('Cranny');

    return Form(
      autovalidateMode: signInForm.showErrorMessages
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      child: Column(
        children: [
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
          ProfileLabel(icon: Icons.location_city_outlined, label: 'Jobdesk'),
          SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: DropdownButton<String>(
                value: jobdesk.firstWhere(
                  (element) => element == jobdeskUser,
                  orElse: () => jobdesk.first,
                ),
                elevation: 16,
                onChanged: (String? value) async {
                  if (value != null)
                    ref
                        .read(signInFormNotifierProvider.notifier)
                        .changeJobdesk(value);
                },
                items: jobdesk.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      children: [
                        Text(
                          value,
                          style: Themes.customColor(
                              FontWeight.normal, 14, Colors.black),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              )),
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
