import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../shared/providers.dart';
import '../../../style/style.dart';
import '../../update_frame/shared/update_frame_providers.dart';

class FrameSearchWithoutSPK extends ConsumerWidget {
  const FrameSearchWithoutSPK();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                      onTap: () async {
                        search.isNotEmpty && search.length > 1
                            ? await _searchFrame(ref, search)
                            : await _resetFrame(ref);
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

            if (search.isEmpty) {
              ref
                  .read(frameSearchNotifierProvider.notifier)
                  .changeIsSearch(false);

              await ref
                  .read(frameNotifierProvider.notifier)
                  .getFrameListOFFLINE(idSPK: 0);
            }
          },
          onFieldSubmitted: (search) async =>
              search.isNotEmpty && search.length > 1
                  ? await _searchFrame(ref, search)
                  : await _resetFrame(ref)),
    );
  }

  Future<void> _resetFrame(WidgetRef ref) async {
    ref.read(frameSearchNotifierProvider.notifier).changeIsSearch(false);

    await ref
        .read(frameNotifierProvider.notifier)
        .getFrameListOFFLINE(idSPK: 0);
  }

  Future<void> _searchFrame(WidgetRef ref, String search) async {
    ref.read(frameSearchNotifierProvider.notifier).changeIsSearch(true);

    final isOnline = ref.read(isOfflineStateProvider.notifier).state == false;

    if (isOnline) {
      await ref
          .read(frameNotifierProvider.notifier)
          .searchFrameListWithoutSPK(frame: search);
    } else {
      await ref
          .read(frameNotifierProvider.notifier)
          .searchFrameListOFFLINE(idSPK: '0', frame: search);
    }

    ref.read(frameSearchNotifierProvider.notifier).changeSearchText('');
  }
}
