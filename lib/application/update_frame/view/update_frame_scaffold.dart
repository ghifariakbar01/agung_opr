import 'package:agung_opr/application/widgets/v_appbar.dart';
import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../shared/update_frame_providers.dart';
import 'update_frame_item.dart';
import 'update_frame_item_scaffold.dart';

class UpdateFrameScaffold extends ConsumerWidget {
  const UpdateFrameScaffold();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final frameList = ref.watch(frameNotifierProvider);

    return KeyboardDismissOnTap(
      child: Scaffold(
          appBar: VAppBar('Update Frame Dummy'),
          bottomNavigationBar: Container(
            height: 63,
            width: MediaQuery.of(context).size.width,
            color: Palette.greySecondary,
            child: TextButton(
              style: ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.zero)),
              onPressed: () => context.pop(),
              child: Row(
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 24,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'BACK',
                    style:
                        Themes.customColor(FontWeight.bold, 14, Colors.black),
                  )
                ],
              ),
            ),
          ),
          drawer: Drawer(),
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (int index = 0;
                        index < frameList.frameList.length;
                        index++) ...[
                      UpdateFrameItemScaffold(
                        index,
                      ),
                    ]
                  ],
                ),
              ))),
    );
  }
}
