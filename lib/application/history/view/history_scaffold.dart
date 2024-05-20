import 'package:agung_opr/application/history/view/history_checksheet_page.dart';
import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../shared/providers.dart';
import 'history_csu_ng_page.dart';
import 'history_csu_ok_page.dart';

class HistoryScaffold extends ConsumerWidget {
  const HistoryScaffold();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobdesk =
        ref.watch(userNotifierProvider.select((value) => value.user.jobdesk));
    final _isCranny = jobdesk!.toLowerCase() == 'cranny';

    final List<Tab> _tabs = [
      Tab(
        text: 'CS',
      ),
      Tab(
        text: 'CSU OK',
      ),
      Tab(
        text: 'CSU NG',
      ),
    ];

    final List<Widget> _children = [
      HistoryCheckSheetPage(),
      HistoryCSUOkPage(),
      HistoryCSUNgPage(),
    ];

    return DefaultTabController(
      length: _isCranny ? 1 : 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: true,
          backgroundColor: Palette.primaryColor,
          title: Text(
            'Riwayat Update',
            style: Themes.customColor(FontWeight.bold, 18, Colors.white),
          ),
          bottom: TabBar(
            tabs: _isCranny
                ? [_tabs.first]
                : [
                    _tabs[1],
                    _tabs[2],
                  ],
          ),
        ),
        body: TabBarView(
          children: _isCranny
              ? [_children.first]
              : [
                  _children[1],
                  _children[2],
                ],
        ),
      ),
    );
  }
}
