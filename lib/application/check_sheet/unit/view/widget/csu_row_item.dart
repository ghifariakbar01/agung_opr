import 'package:flutter/material.dart';

import '../../../../../style/style.dart';

class CSURowItem extends StatelessWidget {
  const CSURowItem({Key? key, required this.label, required this.text})
      : super(key: key);

  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$label : ',
            style:
                Themes.customColor(FontWeight.bold, 16, Palette.primaryColor),
          ),
          Text(
            '${text}',
            style:
                Themes.customColor(FontWeight.normal, 16, Palette.primaryColor),
          ),
        ],
      ),
    );
  }
}
