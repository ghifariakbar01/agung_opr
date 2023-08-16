import 'dart:developer';

import 'package:agung_opr/application/auto_data/view/data_update_query_item.dart';
import 'package:agung_opr/application/widgets/v_appbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../style/style.dart';
import '../shared/auto_data_providers.dart';
import 'data_update_query_csu_item.dart';

class DataUpdateQueryScaffold extends ConsumerWidget {
  const DataUpdateQueryScaffold();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Map<String, Map<String, String>>>
    final idSPKMapidTIUnitMapQuery = ref.watch(
        autoDataUpdateFrameNotifierProvider
            .select((value) => value.idSPKMapidTIUnitMapQuery));

    log('idSPKMapidTIUnitMapQuery ${idSPKMapidTIUnitMapQuery}}');

    final list = idSPKMapidTIUnitMapQuery.entries.toList();

    // CSU Items
    final csuIdQueries = ref.watch(autoDataUpdateFrameNotifierProvider
        .select((value) => value.csuIdQueries));

    log('csuIdQueries ${csuIdQueries}}');

    return Scaffold(
        appBar: VAppBar('Data Akan Diupdate'),
        bottomNavigationBar: Container(
          height: 63,
          width: MediaQuery.of(context).size.width,
          color: Palette.greySecondary,
          child: TextButton(
            style:
                ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.zero)),
            onPressed: () => context.pop(),
            child: Row(
              children: [
                SizedBox(
                  width: 8,
                ),
                Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 24,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'BACK',
                  style: Themes.customColor(FontWeight.bold, 14, Colors.black),
                )
              ],
            ),
          ),
        ),
        // drawer: Drawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                for (int index = 0; index < list.length; index++) ...[
                  DataUpdateQueryItem(
                    idSPK: list[index].key,
                    TIUnitMapQuery: list[index].value,
                  ),
                ],

                SizedBox(
                  height: 8,
                ),

                // CSU Items
                for (int index = 0; index < csuIdQueries.length; index++) ...[
                  DataUpdateQueryCSUItem(
                    idUnit: '${csuIdQueries[index].idUnit}',
                    query: csuIdQueries[index].query,
                  ),
                ],
              ],
            ),
          ),
        ));
  }
}
