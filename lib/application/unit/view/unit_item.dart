import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../update_frame/frame.dart';

class UnitItem extends StatelessWidget {
  const UnitItem({Key? key, required this.frame}) : super(key: key);

  final Frame frame;

  @override
  Widget build(BuildContext context) {
    final cDate = DateFormat('dd MMM yyyy HH:mm')
        .format(DateTime.parse(frame.tglDibuat!));

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Palette.primaryColor, width: 2)),
        child: Center(
          child: Column(
            children: [
              Text(
                '${frame.frame}',
                textAlign: TextAlign.center,
                style: Themes.customColor(FontWeight.bold, 20, Palette.red),
              ),
              frame.lastSpk == null
                  ? Container()
                  : Text(
                      frame.lastSpk!,
                      textAlign: TextAlign.center,
                      style: Themes.customColor(
                        FontWeight.bold,
                        15,
                        Palette.primaryColorDarker,
                      ),
                    ),
              Text(
                'TGL DIBUAT : ${cDate}',
                textAlign: TextAlign.center,
                style: Themes.customColor(
                  FontWeight.bold,
                  15,
                  Palette.primaryColorDarker,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
