import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../style/style.dart';
import 'spk_item.dart';

class SPKSearch extends ConsumerWidget {
  const SPKSearch();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 48,
      child: IgnorePointer(
        ignoring: true,
        child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              autofocus: false,
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
    );
  }
}
