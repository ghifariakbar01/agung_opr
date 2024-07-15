import 'dart:developer';

import 'package:agung_opr/application/spk/shared/spk_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../shared/providers.dart';
import '../../../style/style.dart';

class SPKSearch extends ConsumerWidget {
  const SPKSearch();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final search = ref
        .watch(spkSearchNotifierProvider.select((value) => value.searchText));

    final focusNode =
        ref.watch(spkSearchNotifierProvider.select((value) => value.focusNode));

    return SizedBox(
      height: 48,
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
          autofocus: false,
          focusNode: focusNode,
          decoration: Themes.searchFormStyle(
            'Cari Nopol (Angka) / Driver',
            icon: SizedBox(
              width: 55,
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        focusNode.unfocus();
                        ref
                            .read(spkNotifierProvider.notifier)
                            .changeSPKList([]);

                        search.isNotEmpty && search.length > 1
                            ? () async {
                                final isOnline = ref
                                        .read(isOfflineStateProvider.notifier)
                                        .state ==
                                    false;

                                if (isOnline) {
                                  await ref
                                      .read(spkNotifierProvider.notifier)
                                      .searchSPKList(search: search);
                                } else {
                                  await ref
                                      .read(spkNotifierProvider.notifier)
                                      .searchSPKListOFFLINE(search: search);

                                  debugger();
                                }
                              }()
                            : ref
                                .read(spkNotifierProvider.notifier)
                                .getSPKListOFFLINE(page: 0);
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
          onTap: () =>
              ref.read(spkSearchNotifierProvider.notifier).changeIsSearch(true),
          onTapOutside: (_) => ref
              .read(spkSearchNotifierProvider.notifier)
              .changeIsSearch(false),
          onChanged: (search) async {
            ref
                .read(spkSearchNotifierProvider.notifier)
                .changeSearchText(search);

            if (search.isNotEmpty && search.length > 1) {
              return;
            } else {
              await ref
                  .read(spkNotifierProvider.notifier)
                  .getSPKListOFFLINE(page: 0);
            }
          },
          onFieldSubmitted: (search) => search.isNotEmpty && search.length > 1
              ? () async {
                  ref.read(spkNotifierProvider.notifier).changeSPKList([]);

                  final isOnline =
                      ref.read(isOfflineStateProvider.notifier).state == false;

                  if (isOnline) {
                    await ref
                        .read(spkNotifierProvider.notifier)
                        .searchSPKList(search: search);
                  } else {
                    await ref
                        .read(spkNotifierProvider.notifier)
                        .searchSPKListOFFLINE(search: search);

                    debugger();
                  }
                }()
              : () async {
                  ref.read(spkNotifierProvider.notifier).changeSPKList([]);

                  await ref
                      .read(spkNotifierProvider.notifier)
                      .getSPKListOFFLINE(page: 0);
                }),
    );
  }
}
