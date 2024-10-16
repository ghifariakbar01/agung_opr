import 'package:agung_opr/application/model/shared/model_providers.dart';
import 'package:agung_opr/application/model/view/model_item.dart';
import 'package:agung_opr/application/model/view/model_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../style/style.dart';
import '../../../common/widgets/v_appbar.dart';

final ScrollController _scrollController = ScrollController();

class ModelScaffold extends ConsumerWidget {
  const ModelScaffold();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _scrollController.position.notifyListeners();
      },
    );

    final modelList = ref.watch(modelNotifierProvider).modelList;

    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: VAppBar(
          context,
          'Model List',
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  ModelSearch(),
                  for (int i = 0; i < modelList.length; i++) ...[
                    TextButton(
                      onPressed: () {
                        final modelId = modelList[i].id.toString();
                        context.pop(modelId);
                      },
                      style: ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                      child: ModelItem(
                        model: modelList[i],
                      ),
                    )
                  ]
                ],
              ),
            )),
        // drawer: Drawer(),
        bottomNavigationBar: Container(
          height: 63,
          width: MediaQuery.of(context).size.width,
          color: Palette.greySecondary,
          child: TextButton(
            style:
                ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.zero)),
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
                  style: Themes.customColor(FontWeight.bold, 14, Colors.black),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
