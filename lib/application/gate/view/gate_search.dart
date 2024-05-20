import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../style/style.dart';
import '../providers/gate_providers.dart';

class GateSearch extends ConsumerWidget {
  const GateSearch();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 48,
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
          autofocus: false,
          decoration: Themes.searchFormStyle(
            'Cari Gate',
          ),
          onTap: () => ref
              .read(gateSearchNotifierProvider.notifier)
              .changeIsSearch(true),
          onTapOutside: (_) => ref
              .read(gateSearchNotifierProvider.notifier)
              .changeIsSearch(false),
          onChanged: (search) async {
            ref
                .read(gateSearchNotifierProvider.notifier)
                .changeSearchText(search);

            if (search.isNotEmpty && search.length > 0) {
              return;
            } else {
              await ref.read(gateNotifierProvider.notifier).getGatesOFFLINE();
            }
          },
          onFieldSubmitted: (search) => search.isNotEmpty && search.length > 0
              ? () async {
                  ref
                      .read(gateSearchNotifierProvider.notifier)
                      .changeSearchText('');

                  await ref
                      .read(gateNotifierProvider.notifier)
                      .searchGateListOFFLINE(search: search);
                }()
              : ref.read(gateNotifierProvider.notifier).getGatesOFFLINE()),
    );
  }
}
