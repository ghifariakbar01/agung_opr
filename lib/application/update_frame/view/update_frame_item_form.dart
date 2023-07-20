import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../style/style.dart';

class UpdateFrameItemForm extends ConsumerWidget {
  const UpdateFrameItemForm(this.label);

  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 0,
          child: SizedBox(
            height: 40,
            width: 50,
            child: Center(
              child: Text(
                label,
                style: Themes.customColor(
                    FontWeight.bold, 14, Palette.primaryColor),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Flexible(
          flex: 1,
          child: SizedBox(
            height: 35,
            width: MediaQuery.of(context).size.width,
            child: TextFormField(
              decoration: Themes.formStyleSquared('Dummy123'),
            ),
          ),
        )
      ],
    );
  }
}
