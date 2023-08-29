import 'dart:developer';

import 'package:agung_opr/application/check_sheet/loading/state/update_cs_ng_state.dart';
import 'package:agung_opr/application/check_sheet/shared/providers/cs_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../style/style.dart';

class CSItemOKOrNG extends ConsumerStatefulWidget {
  const CSItemOKOrNG(
    this.id,
    this.index,
    this.instruction,
  );

  final int id;
  final int index;
  final String instruction;

  @override
  ConsumerState<CSItemOKOrNG> createState() => _CSItemOKOrNGState();
}

class _CSItemOKOrNGState extends ConsumerState<CSItemOKOrNG> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(updateCSNotifierProvider.notifier)
          .changeNGId(id: widget.id, index: widget.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isNG = ref.watch(updateCSNotifierProvider
        .select((value) => value.updateCSForm.isNG[widget.index]));

    return Row(
      children: [
        Expanded(
          child: Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                '${widget.id}. ${widget.instruction}',
                style: Themes.customColor(FontWeight.normal, 14, Colors.black),
              )),
        ),
        SizedBox(
          width: 10,
        ),
        Flexible(
          flex: 0,
          child: Container(
            width: 80,
            height: 35,
            child: Row(
              children: [
                // OK Box
                InkWell(
                  onTap: () {
                    ref
                        .read(updateCSNotifierProvider.notifier)
                        .changeIsNG(isNG: false, index: widget.index);

                    ref
                        .read(updateCSNotifierProvider.notifier)
                        .changeNGStatus(status: OKorNG.OK, index: widget.index);
                  },
                  child: Ink(
                    width: 40,
                    decoration: BoxDecoration(
                        color: isNG ? Colors.white : Palette.primaryColor,
                        border:
                            Border.all(color: Palette.primaryColor, width: 1)),
                    child: Center(
                      child: Text(
                        'OK',
                        style: Themes.customColor(FontWeight.bold, 14,
                            isNG ? Palette.primaryColor : Colors.white),
                      ),
                    ),
                  ),
                ),

                // NG Box
                InkWell(
                  onTap: () {
                    ref
                        .read(updateCSNotifierProvider.notifier)
                        .changeNGId(id: widget.id, index: widget.index);

                    ref
                        .read(updateCSNotifierProvider.notifier)
                        .changeNGStatus(status: OKorNG.NG, index: widget.index);

                    ref
                        .read(updateCSNotifierProvider.notifier)
                        .changeIsNG(isNG: true, index: widget.index);

                    log('NG ID : ${widget.id} INDEX: ${widget.index}');
                  },
                  child: Ink(
                    width: 40,
                    decoration: BoxDecoration(
                        color: isNG ? Palette.red : Colors.white,
                        border: Border.all(color: Palette.red, width: 1)),
                    child: Center(
                      child: Text(
                        'NG',
                        style: Themes.customColor(FontWeight.bold, 14,
                            isNG ? Colors.white : Palette.red),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
