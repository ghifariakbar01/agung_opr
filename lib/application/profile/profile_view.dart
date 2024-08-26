import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../shared/providers.dart';
import 'widgets/profile_avatar.dart';
import 'widgets/profile_item.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProvider = ref.watch(userNotifierProvider);

    return Column(
      children: [
        ProfileAvatarItem(),
        ProfileItem(
          text: userProvider.user.idKary ?? '',
          icon: Icons.person,
          label: 'NIK',
        ),
        ProfileItem(
          text: userProvider.user.fullname ?? '',
          icon: Icons.person,
          label: 'Full name',
        ),
        SizedBox(
          height: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileItem(
              text: userProvider.user.ktp ?? '',
              icon: Icons.person,
              label: 'No KTP',
            ),
            SizedBox(
              height: 8,
            ),
            ProfileItem(
              text: userProvider.user.noTelp2 ?? '',
              icon: Icons.numbers,
              label: 'No HP',
            ),
            ProfileItem(
              text: userProvider.user.jobdesk ?? '',
              icon: Icons.location_city_sharp,
              label: 'Jobdesk',
            ),
            SizedBox(
              height: 8,
            ),
            if (userProvider.user.password != null) ...[
              SizedBox(
                height: 8,
              ),
            ]
          ],
        )
      ],
    );
  }
}
