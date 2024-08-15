import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../style/style.dart';

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 63,
      width: MediaQuery.of(context).size.width,
      color: Palette.greySecondary,
      child: TextButton(
        style: ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.zero)),
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
    );
  }
}
