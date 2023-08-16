import 'package:agung_opr/application/model/shared/model_providers.dart';
import 'package:agung_opr/application/model/view/model_item.dart';
import 'package:agung_opr/application/model/view/model_search.dart';
import 'package:agung_opr/application/routes/route_names.dart';
import 'package:agung_opr/application/spk/shared/spk_providers.dart';
import 'package:agung_opr/shared/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../style/style.dart';
import '../../widgets/v_appbar.dart';

final ScrollController _scrollController = ScrollController();

class ModelScaffold extends ConsumerWidget {
  const ModelScaffold();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modelProvider = ref.watch(modelNotifierProvider);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _scrollController.position.notifyListeners();
      },
    );

    _scrollController.addListener(() async {
      final nextPageTrigger = 0.9 * _scrollController.position.maxScrollExtent;

      final isMore = modelProvider.hasMore;

      final isGetting = modelProvider.isProcessing;

      final page = modelProvider.page;

      if (_scrollController.hasClients &&
          _scrollController.position.pixels > nextPageTrigger &&
          isMore &&
          !isGetting) {
        ref.read(modelNotifierProvider.notifier).changePage(page + 1);

        await ref
            .read(modelNotifierProvider.notifier)
            .getModelListOFFLINE(page: page + 1);
      }
    });

    final modelList = modelProvider.modelList;

    final isSearching = ref
        .watch(spkSearchNotifierProvider.select((value) => value.isSearching));

    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: VAppBar(
          'Model List',
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              controller: _scrollController,
              children: [
                ModelSearch(),
                for (int i = 0; i < modelList.length; i++) ...[
                  IgnorePointer(
                    ignoring: isSearching,
                    child: TextButton(
                      onPressed: () {
                        final modelId = modelList[i].id.toString();
                        context.pop(modelId);
                      },
                      style: ButtonStyle(
                          padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                      child: ModelItem(
                        model: modelList[i],
                      ),
                    ),
                  )
                ]
              ],
            )),
        // drawer: Drawer(),
        bottomNavigationBar: Container(
          height: 63,
          width: MediaQuery.of(context).size.width,
          color: Palette.greySecondary,
          child: TextButton(
            style:
                ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.zero)),
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
