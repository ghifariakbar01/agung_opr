import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../style/style.dart';
import '../../shared/csu_providers.dart';
import '../csu_trips_item.dart';

class CSUResultInfo extends ConsumerWidget {
  const CSUResultInfo();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final frame =
        ref.watch(csuFrameNotifierProvider.select((value) => value.frame));

    final csuResultTripList = ref.watch(
        csuFrameNotifierProvider.select((value) => value.csuTripsResultList));

    return // Informasi Unit
        Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 2, color: Palette.primaryColor)),
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          CSURowItem(
            label: 'ID UNIT',
            text: frame.idUnit.toString(),
          ),
          CSURowItem(
            label: 'NO ENGINE',
            text: frame.engine ?? '',
          ),
          CSURowItem(
            label: 'WARNA',
            text: frame.warna ?? '',
          ),
          if (frame.idKendType != null) ...[
            CSURowItem(
              label: 'TYPE',
              text: frame.idKendType.toString(),
            ),
          ],
          CSURowItem(
            label: 'CUSTOMER',
            text: frame.custnm ?? '',
          ),

          // Trips
          for (int index = 0; index < csuResultTripList.length; index++) ...[
            CSUTripsItem(
              index: index,
            )
          ],
        ],
      ),
    );
  }
}

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
            style: Themes.customColor(FontWeight.bold, 16, Colors.black),
          ),
          Text(
            '${text}',
            style: Themes.customColor(FontWeight.normal, 16, Colors.black),
          ),
        ],
      ),
    );
  }
}
