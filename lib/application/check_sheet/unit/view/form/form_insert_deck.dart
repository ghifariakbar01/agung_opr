import 'package:agung_opr/application/check_sheet/unit/shared/csu_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../style/style.dart';

/// [TextEditingController] For displaying value only
///
///
class FormInsertDeck extends HookConsumerWidget {
  const FormInsertDeck();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deck = ref
        .watch(updateCSUFrameNotifierProvider
            .select((value) => value.updateFrameList.deck))
        .getOrLeave('');

    final controller = useTextEditingController(text: deck);

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
                'KAPAL',
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
            padding: EdgeInsets.all(4),
            child: TextFormField(
              controller: controller,
              decoration: Themes.formStyle(
                deck.isEmpty ? 'Masukkan kapal' : '',
              ),
              onChanged: (value) {
                ref
                    .read(updateCSUFrameNotifierProvider.notifier)
                    .changeDeck(value);
              },
            ),
          ),
        )
      ],
    );
  }
}
