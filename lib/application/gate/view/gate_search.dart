import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../shared/providers.dart';
import '../../../style/style.dart';
import '../providers/gate_providers.dart';

class GateSearch extends ConsumerWidget {
  const GateSearch();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final search = ref
        .watch(gateSearchNotifierProvider.select((value) => value.searchText));

    final focusNode = ref
        .watch(gateSearchNotifierProvider.select((value) => value.focusNode));

    return SizedBox(
      height: 48,
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
          autofocus: false,
          focusNode: focusNode,
          decoration: Themes.searchFormStyle(
            'Input nama',
            icon: SizedBox(
              width: 55,
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        focusNode.unfocus();

                        search.isNotEmpty && search.length > 0
                            ? () async {
                                final isOnline = ref
                                        .read(isOfflineStateProvider.notifier)
                                        .state ==
                                    false;

                                ref
                                    .read(gateSearchNotifierProvider.notifier)
                                    .changeSearchText('');

                                // if (isOnline) {

                                // } else {
                                //   await ref
                                //       .read(gateNotifierProvider.notifier)
                                //       .searchGateListOFFLINE(search: search);
                                // }

                                await ref
                                    .read(gateNotifierProvider.notifier)
                                    .searchGateList(search: search);
                              }()
                            : ref
                                .read(gateNotifierProvider.notifier)
                                .getGates();
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
              await ref.read(gateNotifierProvider.notifier).getGates();
            }
          },
          onFieldSubmitted: (search) => search.isNotEmpty && search.length > 0
              ? () async {
                  final isOnline =
                      ref.read(isOfflineStateProvider.notifier).state == false;

                  ref
                      .read(gateSearchNotifierProvider.notifier)
                      .changeSearchText('');

                  // if (isOnline) {

                  // } else {
                  //   await ref
                  //       .read(gateNotifierProvider.notifier)
                  //       .searchGateListOFFLINE(search: search);
                  // }

                  await ref
                      .read(gateNotifierProvider.notifier)
                      .searchGateList(search: search);
                }()
              : ref.read(gateNotifierProvider.notifier).getGates()),
    );
  }
}
