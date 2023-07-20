import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../application/auth/auth_notifier.dart';
import '../../application/user/user_model.dart';
import '../../shared/providers.dart';
import '../../style/style.dart';
import '../routes/route_names.dart';
import '../widgets/v_button.dart';
import '../widgets/v_dialogs.dart';
import 'profile_view.dart';

class ProfileScaffold extends ConsumerWidget {
  const ProfileScaffold();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userNotifierProvider.select((value) => value.user));

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
            ],
          ),
        ),
      ),
    );
  }
}
