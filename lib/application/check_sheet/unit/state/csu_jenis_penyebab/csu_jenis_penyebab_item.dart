// {
//    "id": 1,
//    "eng": "Breakage",
//    "ind": "Pecah/Patah"
// },

import 'package:freezed_annotation/freezed_annotation.dart';

part 'csu_jenis_penyebab_item.freezed.dart';

part 'csu_jenis_penyebab_item.g.dart';

@freezed
class CSUJenisPenyebabItem with _$CSUJenisPenyebabItem {
  const factory CSUJenisPenyebabItem({
    required int id,
    required String? ind,
    required String? eng,
  }) = _CSUJenisPenyebabItem;

  factory CSUJenisPenyebabItem.initial() =>
      CSUJenisPenyebabItem(id: 0, ind: 'Jenis Defect', eng: 'Defect Category');

  factory CSUJenisPenyebabItem.initialPenyebab() =>
      CSUJenisPenyebabItem(id: 0, ind: 'Penyebab Defect', eng: 'Defect Cause');

  factory CSUJenisPenyebabItem.fromJson(Map<String, Object?> json) =>
      _$CSUJenisPenyebabItemFromJson(json);
}
