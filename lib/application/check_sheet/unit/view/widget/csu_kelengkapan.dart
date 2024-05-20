import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../style/style.dart';
import '../../shared/csu_providers.dart';
import '../../state/csu_items/csu_items.dart';
import 'csu_item_form.dart';

class CSUKelengkapan extends ConsumerWidget {
  const CSUKelengkapan({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<CSUItems> csuItems = ref
        .watch(csuItemsFrameNotifierProvider.select((value) => value.csuItems));

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Palette.primaryColor, width: 2)),
      padding: EdgeInsets.all(4),
      child: Column(
        children: [
          Text(
            'KELENGKAPAN',
            style:
                Themes.customColor(FontWeight.bold, 16, Palette.primaryColor),
          ),
          SizedBox(
            height: 8,
          ),
          for (int index = 0; index < csuItems.length; index++) ...[
            CheckSheetUnitItemForm(
                id: csuItems[index].id,
                index: index,
                instruction:
                    '  ${csuItems[index].id}. ${csuItems[index].ind} (${csuItems[index].eng})')
          ]
        ],
      ),
    );
  }
}
