import 'package:agung_opr/application/routes/route_names.dart';
import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/v_appbar.dart';
import '../../widgets/v_bottomnav.dart';
import 'spk_item.dart';

class SPKScaffold extends ConsumerWidget {
  const SPKScaffold();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: VAppBar(
          'SPK List',
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                SizedBox(
                  height: 48,
                  child: IgnorePointer(
                    ignoring: true,
                    child: TypeAheadField(
                        textFieldConfiguration: TextFieldConfiguration(
                          autofocus: true,
                          decoration: Themes.searchFormStyle(
                            'Input Nomor SPK/NOPOL/DRIVER',
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
                        ),
                        suggestionsCallback: (pattern) async {
                          return await Future.delayed(Duration.zero);
                        },
                        itemBuilder: (context, suggestion) {
                          return SPKItem(
                            nomorSpk: 'ACT/SPK-2306138410-TNS',
                            namaDriver: 'Ambun / Hendi Saputra',
                            nomorPolisi: 'B 9910 PIN',
                          );
                        },
                        onSuggestionSelected: (suggestion) {}),
                  ),
                ),
                for (int i = 0; i < 5; i++) ...[
                  TextButton(
                    onPressed: () =>
                        context.pushNamed(RouteNames.assignUnitMerakNameRoute),
                    style: ButtonStyle(
                        padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                    child: SPKItem(
                      nomorSpk: 'ACT/SPK-2306138410-TNS',
                      namaDriver: 'Ambun / Hendi Saputra',
                      nomorPolisi: 'B 9910 PIN',
                    ),
                  )
                ]
              ],
            )),
        drawer: Drawer(),
        bottomNavigationBar: VBottomNav(),
      ),
    );
  }
}
