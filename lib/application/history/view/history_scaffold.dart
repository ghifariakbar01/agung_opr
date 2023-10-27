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
          backgroundColor: Palette.primaryColor,
          automaticallyImplyLeading: true,
          title: Text(
            'Riwayat Update',
            style: Themes.customColor(FontWeight.bold, 18, Colors.white),
          ),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () async {
                  DateTimeRange? picked = await showDateRangePicker(
                      context: context,
                      lastDate: DateTime.now(),
                      firstDate: DateTime(2023));

                  if (picked != null) {
                    ref.read(historyNotifierProvider.notifier).getHistory(
                        startDate: picked.end, endDate: picked.start);
                  }
                },
                icon: Icon(Icons.sort))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
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
                      // Text(
                      //   'Server :  ${history.historyList[index].sDate}',
                      //   style: Themes.customColor(
                      //       FontWeight.bold, 12, Colors.black),
                      // ),
                      Text(
                        'Local :  ${history.historyList[index].cDate}',
                        style: Themes.customColor(
                            FontWeight.bold, 12, Colors.black),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        history.historyList[index].content,
                        style: Themes.customColor(
                            FontWeight.normal, 12, Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            itemCount: history.historyList.length,
          ),
        ));
  }
}
