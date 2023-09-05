import 'package:agung_opr/application/gate/csu_mst_gate.dart';
import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';

class GateItem extends StatelessWidget {
  const GateItem({
    Key? key,
    required this.gate,
  }) : super(key: key);

  final CSUMSTGate gate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Palette.primaryColor, width: 2)),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ID: ${gate.id}',
                        style: Themes.customColor(
                            FontWeight.bold, 14, Palette.primaryColor),
                      ),
                      Text(
                        'NAMA: ${gate.nama ?? '-'}',
                        style: Themes.customColor(
                            FontWeight.bold, 12, Palette.primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
