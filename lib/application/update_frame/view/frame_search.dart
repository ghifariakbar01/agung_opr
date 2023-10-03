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

    final search = ref
        .watch(frameSearchNotifierProvider.select((value) => value.searchText));

    final focusNode = ref
        .watch(frameSearchNotifierProvider.select((value) => value.focusNode));

    return SizedBox(
      height: 48,
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
          autofocus: false,
          focusNode: focusNode,
          decoration: Themes.searchFormStyle(
            'Cari Frame',
            icon: SizedBox(
              width: 55,
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        search.isNotEmpty && search.length > 0
                            ? () async {
                                ref
                                    .read(frameSearchNotifierProvider.notifier)
                                    .changeIsSearch(true);

                                await ref
                                    .read(frameNotifierProvider.notifier)
                                    .searchFrameListOFFLINE(
                                        idSPK: '$idSPK', frame: search);

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
                                    .getFrameListOFFLINE(idSPK: idSPK);
                              }();
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
          onEditingComplete: () => ref
              .read(frameSearchNotifierProvider.notifier)
              .changeIsSearch(false),
          onTapOutside: (_) => ref
              .read(frameSearchNotifierProvider.notifier)
              .changeIsSearch(false),
          onChanged: (search) async {
            ref
                .read(frameSearchNotifierProvider.notifier)
                .changeSearchText(search);

            if (search.isNotEmpty && search.length > 0) {
              return;
            } else {
              ref
                  .read(frameSearchNotifierProvider.notifier)
                  .changeIsSearch(false);

              await ref
                  .read(frameNotifierProvider.notifier)
                  .getFrameListOFFLINE(idSPK: idSPK);
            }
          },
          onFieldSubmitted: (search) => search.isNotEmpty && search.length > 0
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
                      .getFrameListOFFLINE(idSPK: idSPK);
                }()),
    );
  }
}
