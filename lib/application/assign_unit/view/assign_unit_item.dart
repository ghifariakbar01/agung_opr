import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../style/style.dart';

class AssignUnitItem extends ConsumerWidget {
  const AssignUnitItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 0,
            child: Container(
                height: 35,
                width: 50,
                child: Center(
                  child: Text(
                    'Unit 1',
                    style: Themes.customColor(
                        FontWeight.bold, 14, Palette.primaryColor),
                  ),
                )),
          ),
          SizedBox(
            width: 4,
          ),
          Flexible(
            flex: 1,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    enabled: false,
                    decoration: Themes.formStyleSquared('FM19230912',
                        hintStyle: Themes.customColor(
                            FontWeight.bold, 14, Palette.red)),
                  ),
                ),

                SizedBox(
                  height: 8,
                ),

                // Second Height Part
                SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: DropdownButtonFormField<String>(
                      decoration: Themes.formStyleSquared(''),
                      value: 'Pilih Self Driver',
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                      },
                      items: ['Pilih Self Driver', '2', '3']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(14),
                      elevation: 16,
                      style:
                          Themes.customColor(FontWeight.bold, 14, Palette.grey),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
