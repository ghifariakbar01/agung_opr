import 'package:agung_opr/application/check_sheet/unit/shared/csu_providers.dart';

import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state/csu_trips/csu_trips.dart';

class CSUTripsItem extends ConsumerWidget {
  const CSUTripsItem({required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref
        .watch(csuFrameNotifierProvider.select((value) => value.isProcessing));

    final CSUTrips trip = ref.watch(csuFrameNotifierProvider.select((value) =>
        value.csuTripsResultList.isEmpty ||
                value.csuTripsResultList.length < index
            ? CSUTrips.initial()
            : value.csuTripsResultList[index]));

    if (isLoading) return Container();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 1,
              color: Palette.primaryColor,
            )),
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '${index + 1} : ',
                  style: Themes.customColor(
                      FontWeight.bold, 12, Palette.primaryColor),
                ),
                Flexible(
                  child: Text(
                    '${trip.costanalis ?? ''}',
                    maxLines: 10,
                    style: Themes.customColor(
                        FontWeight.w500, 12, Palette.primaryColor),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Cust : ',
                  style: Themes.customColor(
                      FontWeight.bold, 12, Palette.primaryColor),
                ),
                Text(
                  '${trip.custnm ?? ''}',
                  style: Themes.customColor(
                      FontWeight.w500, 12, Palette.primaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
