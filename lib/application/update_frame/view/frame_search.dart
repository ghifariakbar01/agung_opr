import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../style/style.dart';
import '../shared/update_frame_providers.dart';

class FrameSearch extends ConsumerWidget {
  const FrameSearch();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final idSPK =
        ref.read(updateFrameNotifierProvider.select((value) => value.idSPK));

    final searchInitialValue = ref
        .watch(frameSearchNotifierProvider.select((value) => value.searchText));

    log('noSPK searchInitialValue $searchInitialValue');

    return SizedBox(
      height: 48,
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
          autofocus: false,
          decoration: Themes.searchFormStyle(
            searchInitialValue.isEmpty ? 'Input Frame' : searchInitialValue,
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
          onEditingComplete: () => ref
              .read(frameSearchNotifierProvider.notifier)
              .changeIsSearch(false),
          onFieldSubmitted: (_) => ref
              .read(frameSearchNotifierProvider.notifier)
              .changeIsSearch(false),
          onTapOutside: (_) => ref
              .read(frameSearchNotifierProvider.notifier)
              .changeIsSearch(false),
          onChanged: (search) => search.isNotEmpty && search.length > 1
              ? () async {
                  ref
                      .read(frameSearchNotifierProvider.notifier)
                      .changeIsSearch(true);

                  await ref
                      .read(frameNotifierProvider.notifier)
                      .searchFrameListOFFLINE(idSPK: '$idSPK', frame: search);

                  ref
                      .read(frameSearchNotifierProvider.notifier)
                      .changeSearchText('');
                }()
              : () async {
                  ref
                      .read(frameSearchNotifierProvider.notifier)
                      .changeIsSearch(false);

                  await ref
                      .read(frameNotifierProvider.notifier)
                      .getFrameList(idSPK: idSPK);
                }()),
    );
  }
}
