import 'package:agung_opr/application/supir/shared/supir_providers.dart';
import 'package:agung_opr/shared/providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../style/style.dart';

class SupirSearch extends ConsumerWidget {
  const SupirSearch();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
          autofocus: false,
          decoration: Themes.searchFormStyle(
            ' Cari berdasarkan nama ',
          ),
          onTap: () => ref
              .read(supirSearchNotifierProvider.notifier)
              .changeIsSearch(true),
          onTapOutside: (_) => ref
              .read(supirSearchNotifierProvider.notifier)
              .changeIsSearch(false),
          onChanged: (search) async {
            ref
                .read(supirSearchNotifierProvider.notifier)
                .changeSearchText(search);

            if (search.isNotEmpty && search.length > 1) {
              return;
            } else {
              await ref
                  .read(supirNotifierProvider.notifier)
                  .getSupirListOFFLINE(page: 0);
            }
          },
          onFieldSubmitted: (search) => _searchSupir(search, ref, 0)),
    );
  }

  Future<void> _searchSupir(String search, WidgetRef ref, int page) async {
    await search.isNotEmpty && search.length > 1
        ? () async {
            final isOnline = ref.read(isOfflineStateProvider) == false;
            if (isOnline) {
              await ref
                  .read(supirNotifierProvider.notifier)
                  .searchSupirList(search: search);

              await ref
                  .read(supirOfflineNotifierProvider.notifier)
                  .checkAndUpdateSupirOFFLINEStatus();
            } else {
              await ref
                  .read(supirNotifierProvider.notifier)
                  .searchSupirListOFFLINE(search: search);
            }

            ref.read(supirSearchNotifierProvider.notifier).changeSearchText('');
          }()
        : await ref
            .read(supirNotifierProvider.notifier)
            .getSupirListOFFLINE(page: page);
  }
}
