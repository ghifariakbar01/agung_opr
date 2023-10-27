import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../shared/providers.dart';
import '../../../style/style.dart';
import '../shared/model_providers.dart';

class ModelSearch extends ConsumerWidget {
  const ModelSearch();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modeNotif = ref.watch(modelNotifierProvider);

    final page = modeNotif.page;

    final modelSearch = ref.watch(modelSearchNotifierProvider);

    final search = modelSearch.searchText;

    final focusNode = modelSearch.focusNode;

    return SizedBox(
      height: 48,
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
          autofocus: false,
          focusNode: focusNode,
          decoration: Themes.searchFormStyle(
            'Input ID/MERK/NAMA/CATEGORY/GW/MR',
            icon: SizedBox(
              width: 55,
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        focusNode.unfocus();

                        search.isNotEmpty && search.length > 1
                            ? () async {
                                final isOnline = ref
                                        .read(isOfflineStateProvider.notifier)
                                        .state ==
                                    false;

                                if (isOnline) {
                                  await ref
                                      .read(modelNotifierProvider.notifier)
                                      .searchModelList(search: search);
                                } else {
                                  await ref
                                      .read(modelNotifierProvider.notifier)
                                      .searchModelListOFFLINE(search: search);
                                }
                              }()
                            : ref
                                .read(modelNotifierProvider.notifier)
                                .getModelListOFFLINE(page: page);
                      },
                      child: Ink(child: Icon(Icons.search))),
                  Text(
                    'Cari',
                    style: Themes.greyHint(FontWeight.bold, 11),
                  )
                ],
              ),
            ),
          ),
          onTap: () => ref
              .read(modelSearchNotifierProvider.notifier)
              .changeIsSearch(true),
          onTapOutside: (_) => ref
              .read(modelSearchNotifierProvider.notifier)
              .changeIsSearch(false),
          onChanged: (value) async {
            ref
                .read(modelSearchNotifierProvider.notifier)
                .changeSearchText(value);

            if (value.isNotEmpty && value.length > 1) {
              return;
            } else {
              await ref
                  .read(modelNotifierProvider.notifier)
                  .getModelListOFFLINE(page: 0);
            }
          },
          onFieldSubmitted: (value) => value.isNotEmpty && value.length > 1
              ? () async {
                  final isOnline =
                      ref.read(isOfflineStateProvider.notifier).state == false;

                  ref
                      .read(modelSearchNotifierProvider.notifier)
                      .changeSearchText('');

                  if (isOnline) {
                    await ref
                        .read(modelNotifierProvider.notifier)
                        .searchModelList(search: value);
                  } else {
                    await ref
                        .read(modelNotifierProvider.notifier)
                        .searchModelListOFFLINE(search: value);
                  }
                }()
              : ref
                  .read(modelNotifierProvider.notifier)
                  .getModelListOFFLINE(page: page)),
    );
  }
}
