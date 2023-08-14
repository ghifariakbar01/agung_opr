import 'package:agung_opr/application/auto_data/shared/auto_data_providers.dart';
import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DataUpdateLinearProgress extends ConsumerWidget {
  const DataUpdateLinearProgress();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = ref.watch(autoDataTimerNotifierProvider
        .select((value) => value.durationInSeconds));

    return SizedBox(
      height: 15,
      width: MediaQuery.of(context).size.width,
      child: LinearProgressIndicator(
        color: Palette.secondaryColor,
        value: double.parse((time / 120).toString()),
        semanticsLabel: 'Linear progress indicator',
      ),
    );
  }
}
