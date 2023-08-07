import 'dart:developer';

import 'package:agung_opr/application/supir/shared/supir_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../style/style.dart';

class SupirSearch extends ConsumerWidget {
  const SupirSearch();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(supirNotifierProvider.select((value) => value.page));

    final searchInitialValue = ref
        .watch(supirSearchNotifierProvider.select((value) => value.searchText));

    log('supir searchInitialValue $searchInitialValue');

    return SizedBox(
      height: 48,
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
          autofocus: false,
          decoration: Themes.searchFormStyle(
            searchInitialValue.isEmpty
                ? 'Input ID/NAMA/NO. HP/ALAMAT/KATEGORI'
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
          onTap: () => ref
              .read(supirSearchNotifierProvider.notifier)
              .changeIsSearch(true),
          onTapOutside: (_) => ref
              .read(supirSearchNotifierProvider.notifier)
              .changeIsSearch(false),
          onChanged: (search) => search.isNotEmpty && search.length > 1
              ? () {
                  ref
                      .read(supirNotifierProvider.notifier)
                      .searchSupirListOFFLINE(search: search);

                  ref
                      .read(supirSearchNotifierProvider.notifier)
                      .changeSearchText('');
                }()
              : ref
                  .read(supirNotifierProvider.notifier)
                  .getSupirListOFFLINE(page: page)),
    );
  }
}
