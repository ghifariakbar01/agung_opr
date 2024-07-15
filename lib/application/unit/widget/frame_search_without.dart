import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../shared/providers.dart';
import '../../../style/style.dart';
import '../../update_frame/shared/update_frame_providers.dart';

class FrameSearchWithoutSPK extends ConsumerWidget {
  const FrameSearchWithoutSPK();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final search = ref.watch(
      frameSearchNotifierProvider.select((value) => value.searchText),
    );

    return SizedBox(
      height: 48,
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
          autofocus: false,
          decoration: Themes.searchFormStyle(
            'Cari Frame (5 Angka Belakang Saja)',
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
          onChanged: (search) async {
            ref
                .read(frameSearchNotifierProvider.notifier)
                .changeSearchText(search);

            if (search.isEmpty) {
              await _resetFrame(ref);
            } else {
              ref
                  .read(frameSearchNotifierProvider.notifier)
                  .changeIsSearch(true);
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
    ref.read(frameNotifierProvider.notifier).changeFrameList([]);

    final isOnline = ref.read(isOfflineStateProvider.notifier).state == false;

    if (isOnline) {
      await _getFrameOnline(ref);
    } else {
      await ref
          .read(frameNotifierProvider.notifier)
          .getFrameListOFFLINE(idSPK: 0);
    }
  }

  Future<void> _getFrameOnline(WidgetRef ref) async {
    await ref.read(frameNotifierProvider.notifier).getFrameListByPage(page: 0);
    await ref
        .read(frameOfflineNotifierProvider.notifier)
        .checkAndUpdateFrameOFFLINEStatusByPage(page: 0);
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
