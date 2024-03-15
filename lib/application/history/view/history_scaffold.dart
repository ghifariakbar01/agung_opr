import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../shared/history_providers.dart';

class HistoryScaffold extends ConsumerWidget {
  const HistoryScaffold();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(historyNotifierProvider);

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: true,
          backgroundColor: Palette.primaryColor,
          title: Text(
            'Riwayat Update',
            style: Themes.customColor(FontWeight.bold, 18, Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: history.historyList.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: Palette.primaryColor, width: 2)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date :  ${history.historyList[index].cDate}',
                        style: Themes.customColor(
                            FontWeight.bold, 12, Colors.black),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        history.historyList[index].toString(),
                        style: Themes.customColor(
                            FontWeight.w500, 12, Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
