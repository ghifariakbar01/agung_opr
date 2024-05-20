import 'package:agung_opr/application/check_sheet/unit/shared/csu_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../style/style.dart';

final deckList = {
  '',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  'DECK-A',
  'DECK-B',
  'DECK-C',
  'DECK-D',
  'DECK-F'
};

/// [TextEditingController] For displaying value only
///
///
class FormInsertDeck extends ConsumerWidget {
  const FormInsertDeck();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deck = ref
        .watch(updateCSUFrameNotifierProvider
            .select((value) => value.updateFrameList.deck))
        .getOrLeave('');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 0,
          child: SizedBox(
            height: 70,
            width: 65,
            child: Center(
              child: Text(
                'DECK',
                style: Themes.customColor(
                    FontWeight.bold, 14, Palette.primaryColor),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Flexible(
          flex: 1,
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border.all(color: Palette.primaryColor, width: 2),
                borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.all(4),
            child: DropdownButton<String>(
              value: deckList.firstWhere(
                (element) => element == deck,
                orElse: () => '',
              ),
              elevation: 16,
              underline: Container(),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                if (value != null)
                  ref
                      .read(updateCSUFrameNotifierProvider.notifier)
                      .changeDeck(value);
              },
              items: deckList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${value}',
                      style: Themes.customColor(
                          FontWeight.normal, 14, Colors.black),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        )
      ],
    );
  }
}
