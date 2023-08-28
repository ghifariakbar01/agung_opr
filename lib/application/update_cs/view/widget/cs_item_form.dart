import 'dart:developer';

import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../check_sheet/shared/providers/cs_providers.dart';
import 'cs_item_ok_or_ng.dart';

class CSItemForm extends ConsumerWidget {
  const CSItemForm({
    required this.id,
    required this.index,
    required this.instruction,
  });

  // ADD id, in case id != index
  final int id;
  final int index;
  final String instruction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ngState = ref.watch(updateCSNotifierProvider
        .select((value) => value.updateCSForm.ngStates[index]));

    final isNG = ref.watch(updateCSNotifierProvider
        .select((value) => value.updateCSForm.isNG[index]));

    final keteranganStr = ngState.keterangan.getOrLeave('');

    return Column(
      children: [
        // First Height Part
        CSItemOKOrNG(
          id,
          index,
          instruction,
        ),

        SizedBox(
          height: 4,
        ),

        // JENIS NG
        Visibility(
          visible: isNG,
          child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                initialValue: keteranganStr,
                decoration: Themes.formStyle(
                  'Masukkan keterangan',
                  icon: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: Icon(
                        Icons.note,
                        color: Palette.primaryColor,
                      )),
                ),
                onChanged: (value) => ref
                    .read(updateCSNotifierProvider.notifier)
                    .changeNGKeterangan(keteranganStr: value, index: index),
                validator: (_) => ngState.keterangan.value.fold(
                  (f) => f.maybeMap(
                    shortPassword: (_) => 'terlalu pendek',
                    orElse: () => null,
                  ),
                  (_) => null,
                ),
              )),
        ),

        SizedBox(
          height: 4,
        ),
      ],
    );
  }
}
