import 'package:agung_opr/application/history/view/history_checksheet_page.dart';
import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/constants.dart';
import '../../../shared/providers.dart';
import '../shared/history_providers.dart';
import 'history_csu_ng_page.dart';
import 'history_csu_ok_page.dart';

class HistoryScaffold extends HookConsumerWidget {
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

    final searchFocus = useFocusNode();
    final isSearching = useState(false);
    final searchStr = useState('');
    final searchController = useTextEditingController();

    useEffect(() {
      if (isSearching.value) {
        searchFocus.requestFocus();
      } else {
        searchFocus.unfocus();
      }

      return () {};
    }, [isSearching.value]);

    final List<Widget> _children = [
      HistoryCheckSheetPage(
        searchStr,
        isSearching,
      ),
      HistoryCSUOkPage(),
      HistoryCSUNgPage(),
    ];

    final dateRange = useState(Constants.defaultDateTimeRange);

    return DefaultTabController(
      length: _isCranny ? 1 : 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 50,
          automaticallyImplyLeading: isSearching.value ? false : true,
          backgroundColor: Palette.primaryColor,
          title: isSearching.value
              ? Container()
              : Text(
                  'Riwayat Update',
                  style: Themes.customColor(FontWeight.bold, 18, Colors.white),
                ),
          actions: [
            if (isSearching.value) ...[
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(8),
                child: TextFormField(
                  controller: searchController,
                  focusNode: searchFocus,
                  onTapOutside: (_) => isSearching.value = false,
                  onTap: () => isSearching.value = true,
                  onFieldSubmitted: (value) async {
                    searchStr.value = value;
                    searchController.text = value;

                    return ref
                        .read(historyNotifierProvider.notifier)
                        .getHistory(
                          nopol: value,
                          dateRange: dateRange.value,
                        );
                  },
                  decoration: InputDecoration(
                    hintText: 'Input Nopol',
                    suffixIcon: IconButton(
                      onPressed: () {
                        searchStr.value = '';
                        searchController.text = '';
                      },
                      icon: Icon(Icons.disabled_by_default_outlined),
                    ),
                    contentPadding: EdgeInsets.all(12.0),
                  ),
                ),
              )
            ],
            if (isSearching.value == false) ...[
              if (_isCranny)
                IconButton(
                  onPressed: () {
                    isSearching.value
                        ? isSearching.value = false
                        : isSearching.value = true;
                  },
                  icon: Icon(Icons.search),
                ),
              IconButton(
                  onPressed: () async {
                    final range = await showDateRangePicker(
                      context: context,
                      initialDateRange: dateRange.value,
                      firstDate: DateTime.now().subtract(Duration(days: 30)),
                      lastDate: DateTime.now().add(Duration(days: 1)),
                    );

                    if (range == null) {
                      return;
                    }

                    dateRange.value = range;

                    return ref
                        .read(historyNotifierProvider.notifier)
                        .getHistory(
                          dateRange: range,
                          nopol: searchStr.value,
                        );
                  },
                  icon: Icon(
                    Icons.date_range,
                  ))
            ],
          ],
          bottom: isSearching.value
              ? PreferredSize(
                  preferredSize: Size(double.infinity, 16), child: Container())
              : TabBar(
                  tabs: _isCranny
                      ? [_tabs.first]
                      : [
                          _tabs[1],
                          _tabs[2],
                        ],
                ),
        ),
        body: InkWell(
          onTap: () {
            isSearching.value = false;
          },
          child: TabBarView(
            children: _isCranny
                ? [_children.first]
                : [
                    _children[1],
                    _children[2],
                  ],
          ),
        ),
      ),
    );
  }
}
