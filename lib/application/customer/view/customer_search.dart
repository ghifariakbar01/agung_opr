import 'dart:developer';

import 'package:agung_opr/application/customer/shared/customer_providers.dart';
import 'package:agung_opr/shared/providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../style/style.dart';

class CustomerSearch extends ConsumerWidget {
  const CustomerSearch();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page =
        ref.watch(customerNotifierProvider.select((value) => value.page));

    final searchInitialValue = ref.watch(
        customerSearchNotifierProvider.select((value) => value.searchText));

    log('customer searchInitialValue $searchInitialValue');

    return SizedBox(
      height: 48,
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
          autofocus: false,
          decoration: Themes.searchFormStyle(
            searchInitialValue.isEmpty ? 'Input ID/NAMA' : searchInitialValue,
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
              .read(customerSearchNotifierProvider.notifier)
              .changeIsSearch(true),
          onTapOutside: (_) => ref
              .read(customerSearchNotifierProvider.notifier)
              .changeIsSearch(false),
          onChanged: (search) => search.isNotEmpty && search.length > 1
              ? () async {
                  final isOnline =
                      ref.read(isOfflineProvider.notifier).state == false;

                  ref
                      .read(customerSearchNotifierProvider.notifier)
                      .changeSearchText(search);

                  if (isOnline) {
                    await ref
                        .read(customerNotifierProvider.notifier)
                        .searchCustomerList(search: search);
                  } else {
                    await ref
                        .read(customerNotifierProvider.notifier)
                        .searchCustomerListOFFLINE(search: search);
                  }
                }()
              : ref
                  .read(customerNotifierProvider.notifier)
                  .getCustomerListOFFLINE(page: page)),
    );
  }
}
