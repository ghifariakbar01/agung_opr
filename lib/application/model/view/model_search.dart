import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../shared/providers.dart';
import '../../../style/style.dart';
import '../shared/model_providers.dart';

final includePartsProvider = StateProvider<bool>((ref) {
  return false;
});

final includePartStringProvider = StateProvider<String>((ref) {
  return "Kendaraan";
});

class ModelSearch extends ConsumerWidget {
  const ModelSearch();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final includePartsStr = ref.watch(includePartStringProvider);
    final modelSearch = ref.watch(modelSearchNotifierProvider);
    final includeParts = ref.watch(includePartsProvider);

    final modeNotif = ref.watch(modelNotifierProvider);

    final focusNode = modelSearch.focusNode;
    final search = modelSearch.searchText;
    final page = modeNotif.page;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 0,
          child: SizedBox(
            height: 48,
            child: DropdownButton<String>(
              value: includePartsStr,
              elevation: 16,
              icon: Container(),
              underline: Container(),
              onChanged: (String? value) {
                if (value != null) {
                  if (value.contains('Kendaraan')) {
                    ref.read(includePartsProvider.notifier).state = false;
                  } else {
                    ref.read(includePartsProvider.notifier).state = true;
                  }

                  ref.read(includePartStringProvider.notifier).state = value;
                }
              },
              items: ["Inc Spare Part", "Kendaraan"]
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Palette.primaryColor,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Text(
                      '${value}',
                      style: Themes.customColor(
                          FontWeight.normal, 14, Colors.black),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Flexible(
          flex: 1,
          child: SizedBox(
            height: 48,
            width: MediaQuery.of(context).size.width,
            child: TextFormField(
                autofocus: false,
                focusNode: focusNode,
                decoration: Themes.searchFormStyle(
                  'Input Nama',
                  icon: InkWell(
                      onTap: () {
                        focusNode.unfocus();

                        search.isNotEmpty && search.length > 0
                            ? () async {
                                final isOnline = ref
                                        .read(isOfflineStateProvider.notifier)
                                        .state ==
                                    false;

                                if (isOnline) {
                                  await ref
                                      .read(modelNotifierProvider.notifier)
                                      .searchModelList(
                                          search: search,
                                          includeParts: includeParts);
                                } else {
                                  await ref
                                      .read(modelNotifierProvider.notifier)
                                      .searchModelListOFFLINE(
                                          search: search,
                                          includeParts: includeParts);
                                }
                              }()
                            : ref
                                .read(modelNotifierProvider.notifier)
                                .getModelListOFFLINE(page: page);
                      },
                      child: Ink(child: Icon(Icons.search))),
                ),
                onTap: () => ref
                    .read(modelSearchNotifierProvider.notifier)
                    .changeIsSearch(true),
                onTapOutside: (_) => ref
                    .read(modelSearchNotifierProvider.notifier)
                    .changeIsSearch(false),
                onChanged: (value) async {
                  if (value.isNotEmpty) {
                    ref
                        .read(modelSearchNotifierProvider.notifier)
                        .changeSearchText(value);

                    if (value.isNotEmpty && value.length > 0) {
                      return;
                    }
                  } else {
                    await ref
                        .read(modelNotifierProvider.notifier)
                        .getModelListOFFLINE(page: 0);
                  }
                },
                onFieldSubmitted: (value) => value.isNotEmpty &&
                        value.length > 0
                    ? () async {
                        final isOnline =
                            ref.read(isOfflineStateProvider.notifier).state ==
                                false;

                        ref
                            .read(modelSearchNotifierProvider.notifier)
                            .changeSearchText('');

                        if (isOnline) {
                          await ref
                              .read(modelNotifierProvider.notifier)
                              .searchModelList(
                                  search: value, includeParts: includeParts);
                        } else {
                          await ref
                              .read(modelNotifierProvider.notifier)
                              .searchModelListOFFLINE(
                                  search: value, includeParts: includeParts);
                        }
                      }()
                    : ref
                        .read(modelNotifierProvider.notifier)
                        .getModelListOFFLINE(page: page)),
          ),
        ),
      ],
    );
  }
}
