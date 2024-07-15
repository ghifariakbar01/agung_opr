import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../style/style.dart';
import '../../shared/csu_providers.dart';

import 'csu_row_item.dart';
import 'csu_trips_item.dart';

final hideTripProvider = StateProvider<bool>((ref) => true);

class CSUResultInfo extends ConsumerWidget {
  const CSUResultInfo();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hideTrip = ref.watch(hideTripProvider);

    final frame = ref.watch(
      csuFrameNotifierProvider.select((value) => value.frame),
    );

    final csuResultTripList = ref.watch(
      csuFrameNotifierProvider.select((value) => value.csuTripsResultList),
    );

    return // Informasi Unit
        Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 2, color: Palette.primaryColor),
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          CSURowItem(
            label: 'SPK',
            text: frame.lastSpk ?? '-',
          ),
          CSURowItem(
            label: 'WARNA',
            text: frame.warna ?? '-',
          ),
          CSURowItem(
            label: 'CUSTOMER',
            text: frame.custnm ?? '-',
          ),

          // Trips
          if (csuResultTripList.isNotEmpty && hideTrip != true) ...[
            for (int index = 0; index < csuResultTripList.length; index++) ...[
              CSUTripsItem(
                index: index,
              )
            ],
          ],

          Row(
            children: [
              Text(
                'Sembunyikan Trip',
                style: Themes.customColor(
                    FontWeight.bold, 12, Palette.primaryColor),
              ),
              Switch(
                value: hideTrip,
                onChanged: (value) =>
                    ref.read(hideTripProvider.notifier).state = value,
                activeColor: Palette.primaryColor,
              ),
            ],
          )
        ],
      ),
    );
  }
}
