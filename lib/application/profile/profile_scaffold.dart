import 'package:agung_opr/application/widgets/v_button.dart';
import 'package:agung_opr/shared/providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../style/style.dart';
import 'profile_view.dart';

class ProfileScaffold extends ConsumerWidget {
  const ProfileScaffold();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(userNotifierProvider, (__, state) {
      return state.failureOrSuccessOption.fold(
          () {},
          (r) => r.fold(
              (_) => {},
              (_) => ref
                  .read(authNotifierProvider.notifier)
                  .checkAndUpdateAuthStatus()));
    });

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Palette.primaryColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Palette.primaryColor.withOpacity(0.1)),
          padding: EdgeInsets.all(16),
          child: ListView(
            children: [
              const ProfileView(),
              VButton(
                  label: 'LOGOUT',
                  color: Palette.red,
                  onPressed: () =>
                      ref.read(userNotifierProvider.notifier).logout())
            ],
          ),
        ),
      ),
    );
  }
}
