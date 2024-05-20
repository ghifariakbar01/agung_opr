import 'package:agung_opr/application/supir/shared/supir_providers.dart';
import 'package:agung_opr/application/supir/view/supir_item.dart';
import 'package:agung_opr/application/supir/view/supir_search.dart';
import 'package:agung_opr/application/spk/shared/spk_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../style/style.dart';
import '../../widgets/v_appbar.dart';

final ScrollController _scrollController = ScrollController();

class SupirScaffold extends ConsumerWidget {
  const SupirScaffold();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _scrollController.position.notifyListeners();
      },
    );

    _scrollController.addListener(() async {
      final supirProviderOnScrolled = ref.read(supirNotifierProvider);
      final page = supirProviderOnScrolled.page;
      final isMore = supirProviderOnScrolled.hasMore;
      final isGetting = supirProviderOnScrolled.isProcessing;
      final nextPageTrigger = 0.9 * _scrollController.position.maxScrollExtent;

      if (_scrollController.hasClients &&
          _scrollController.position.pixels > nextPageTrigger &&
          isMore &&
          !isGetting) {
        ref.read(supirNotifierProvider.notifier).changePage(page + 1);

        await ref
            .read(supirNotifierProvider.notifier)
            .getSupirListOFFLINE(page: page + 1);
      }
    });

    final supirProvider = ref.watch(supirNotifierProvider);

    final supirList = supirProvider.supirList;

    final isSearching = ref
        .watch(spkSearchNotifierProvider.select((value) => value.isSearching));

    return KeyboardDismissOnTap(
      child: SafeArea(
        child: Scaffold(
          appBar: VAppBar(
            context,
            'Supir List',
          ),
          body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    SupirSearch(),
                    for (int i = 0; i < supirList.length; i++) ...[
                      IgnorePointer(
                        ignoring: isSearching,
                        child: TextButton(
                          onPressed: () {
                            final supirName = supirList[i].nama.toString();
                            context.pop(supirName);
                          },
                          child: SupirItem(
                            supir: supirList[i],
                          ),
                          style: ButtonStyle(
                              padding:
                                  MaterialStatePropertyAll(EdgeInsets.zero)),
                        ),
                      )
                    ]
                  ],
                ),
              )),
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
        ),
      ),
    );
  }
}
