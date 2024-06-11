import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../style/style.dart';
import '../../../shared/providers/cs_providers.dart';

class FormJam extends ConsumerStatefulWidget {
  const FormJam();

  @override
  ConsumerState<FormJam> createState() => _FormJamState();
}

class _FormJamState extends ConsumerState<FormJam> {
  @override
  Widget build(BuildContext context) {
    final jamEdit = ref.watch(updateCSNotifierProvider.select(
      (value) => value.updateCSForm.jamLoadUnloadText,
    ));

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
                'JAM LOAD',
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: IgnorePointer(
              ignoring: true,
              child: TextFormField(
                controller: jamEdit,
                decoration: Themes.formStyle(
                  'Masukkan Jam Load / Unload',
                  hintFontSize: 11,
                  icon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.access_time_filled_outlined,
                        color: Palette.primaryColor,
                      )),
                ),
                onChanged: (_) {},
                validator: (_) => ref
                    .read(updateCSNotifierProvider)
                    .updateCSForm
                    .jamLoadUnload
                    .value
                    .fold(
                      (f) => f.maybeMap(
                        shortPassword: (_) => 'terlalu pendek',
                        invalidJam: (_) => 'Jam load invalid',
                        orElse: () => null,
                      ),
                      (_) => null,
                    ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

// (value) => ref
//                     .read(updateCSNotifierProvider.notifier)
//                     .changeKeterangan(value),
