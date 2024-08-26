import 'package:flutter/cupertino.dart';

import '../../../../constants/assets.dart';

class AppLogo extends StatelessWidget {
  const AppLogo();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(height: 139, child: Image.asset(Assets.iconLogo)),
    );
  }
}
