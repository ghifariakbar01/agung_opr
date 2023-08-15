import 'package:agung_opr/application/check_sheet/unit/shared/csu_providers.dart';
import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CSUTripsItem extends ConsumerWidget {
  const CSUTripsItem({required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trip = ref.watch(csuFrameNotifierProvider
        .select((value) => value.csuTripsResultList[index]));

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
                  'TRIP ${index + 1} : ',
                  style: Themes.customColor(
                      FontWeight.bold, 12, Palette.primaryColor),
                ),
                Flexible(
                  child: Text(
                    '${trip.costanalis ?? ''}',
                    maxLines: 10,
                    style: Themes.customColor(
                        FontWeight.normal, 12, Palette.primaryColor),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'CUSTOMER : ',
                  style: Themes.customColor(
                      FontWeight.bold, 12, Palette.primaryColor),
                ),
                Text(
                  '${trip.custnm ?? ''}',
                  style: Themes.customColor(
                      FontWeight.normal, 12, Palette.primaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
