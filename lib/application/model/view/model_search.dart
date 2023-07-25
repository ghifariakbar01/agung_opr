import 'dart:developer';

import 'package:agung_opr/application/model/shared/model_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../style/style.dart';

class ModelSearch extends ConsumerWidget {
  const ModelSearch();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(modelNotifierProvider.select((value) => value.page));

    final searchInitialValue = ref
        .watch(modelSearchNotifierProvider.select((value) => value.searchText));

    log('model searchInitialValue $searchInitialValue');

    return SizedBox(
      height: 48,
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
          autofocus: false,
          decoration: Themes.searchFormStyle(
            searchInitialValue.isEmpty
                ? 'Input ID/MERK/NAMA/CATEGORY/GW/MR'
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
              .read(modelSearchNotifierProvider.notifier)
              .changeIsSearch(true),
          onTapOutside: (_) => ref
              .read(modelSearchNotifierProvider.notifier)
              .changeIsSearch(false),
          onChanged: (search) => search.isNotEmpty && search.length > 1
              ? () {
                  ref
                      .read(modelNotifierProvider.notifier)
                      .searchModelListOFFLINE(search: search);

                  ref
                      .read(modelSearchNotifierProvider.notifier)
                      .changeSearchText('');
                }()
              : ref
                  .read(modelNotifierProvider.notifier)
                  .getModelListOFFLINE(page: page)),
    );
  }
}
