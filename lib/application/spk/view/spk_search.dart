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
    final page = ref.watch(spkNotifierProvider.select((value) => value.page));

    final searchInitialValue = ref
        .watch(spkSearchNotifierProvider.select((value) => value.searchText));

    log('noSPK searchInitialValue $searchInitialValue');

    return SizedBox(
      height: 48,
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
          autofocus: false,
          decoration: Themes.searchFormStyle(
            searchInitialValue.isEmpty
                ? 'Input Nomor SPK/NOPOL/DRIVER'
                : searchInitialValue,
            icon: SizedBox(
              width: 55,
              child: Row(
                children: [
                  Icon(Icons.search),
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
          onChanged: (search) => search.isNotEmpty && search.length > 1
              ? () async {
                  final isOnline =
                      ref.read(isOfflineStateProvider.notifier).state == false;

                  ref
                      .read(spkSearchNotifierProvider.notifier)
                      .changeSearchText('');

                  if (isOnline) {
                    await ref
                        .read(spkNotifierProvider.notifier)
                        .searchSPKList(search: search);
                  } else {
                    await ref
                        .read(spkNotifierProvider.notifier)
                        .searchSPKListOFFLINE(search: search);
                  }
                }()
              : ref
                  .read(spkNotifierProvider.notifier)
                  .getSPKListOFFLINE(page: page)),
    );
  }
}
