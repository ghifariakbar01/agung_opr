import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../style/style.dart';
import '../../widgets/v_appbar.dart';
import '../shared/customer_providers.dart';
import 'customer_item.dart';
import 'customer_search.dart';

class CustomerScaffold extends ConsumerWidget {
  const CustomerScaffold();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customerProvider = ref.watch(customerNotifierProvider);

    final customerList = customerProvider.customerList;

    final isSearching = ref.watch(
        customerSearchNotifierProvider.select((value) => value.isSearching));

    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: VAppBar(
          'Customer List',
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                CustomerSearch(),
                for (int i = 0; i < customerList.length; i++) ...[
                  IgnorePointer(
                    ignoring: isSearching,
                    child: TextButton(
                      onPressed: () => ref
                          .read(customerNotifierProvider.notifier)
                          .insertCustomer(customer: customerList[i]),
                      style: ButtonStyle(
                          padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                      child: CustomerItem(
                        customer: customerList[i],
                      ),
                    ),
                  )
                ]
              ],
            )),
        // drawer: Drawer(),
        bottomNavigationBar: Container(
          height: 63,
          width: MediaQuery.of(context).size.width,
          color: Palette.greySecondary,
          child: TextButton(
            style:
                ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.zero)),
            onPressed: () => context.pop(),
            child: Row(
              children: [
                SizedBox(
                  width: 8,
                ),
                Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 24,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'BACK',
                  style: Themes.customColor(FontWeight.bold, 14, Colors.black),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
