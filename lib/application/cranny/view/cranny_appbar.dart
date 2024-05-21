import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../style/style.dart';
import '../../routes/route_names.dart';

class CrannyAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CrannyAppBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Palette.primaryColor,
      centerTitle: true,
      elevation: 0,
      toolbarHeight: 50,
      title: Text(
        'Mobile Carrier OPR CCR',
        style: Themes.customColor(FontWeight.bold, 18, Colors.white),
      ),
      leading: InkWell(
        onTap: () => context.pushNamed(RouteNames.copyrightNameRoute),
        child: Icon(
          Icons.copyright,
          color: Colors.white,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => context.pushNamed(RouteNames.profileNameRoute),
          icon: Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),
        IconButton(
            onPressed: () => context.pushNamed(RouteNames.historyName),
            icon: Icon(
              Icons.history,
              color: Palette.yellow,
            )),
        SizedBox(
          width: 8,
        ),
      ],
    );
  }

  static final _appBar = AppBar();
  @override
  Size get preferredSize => _appBar.preferredSize;
}
