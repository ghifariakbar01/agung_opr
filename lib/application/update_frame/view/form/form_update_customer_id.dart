// import 'package:agung_opr/application/customer/customer.dart';
// import 'package:agung_opr/application/customer/shared/customer_providers.dart';
// import 'package:agung_opr/application/routes/route_names.dart';
// import 'package:agung_opr/application/update_frame/shared/update_frame_providers.dart';
// import 'package:agung_opr/domain/value_objects_copy.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// import '../../../../style/style.dart';

// class FormUpdateCustomerId extends ConsumerWidget {
//   const FormUpdateCustomerId({required this.index});

//   final int index;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final frame = ref.watch(updateFrameNotifierProvider);

//     final customerId = ref.watch(updateFrameNotifierProvider.select((value) =>
//         value.updateFrameList.length < index
//             ? CustomerId('')
//             : value.updateFrameList[index].customerId));

//     final customerIdStr = customerId.getOrLeave('');

//     final customerList = ref
//         .watch(customerNotifierProvider.select((value) => value.customerList));

//     final customerSelected = customerList.firstWhere(
//       (element) => element.id.toString() == customerIdStr,
//       orElse: () => Customer.initial(),
//     );

//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Flexible(
//           flex: 0,
//           child: SizedBox(
//             height: 70,
//             width: 50,
//             child: Center(
//               child: Text(
//                 'Tujuan Akhir',
//                 style: Themes.customColor(
//                     FontWeight.bold, 13, Palette.primaryColor),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//         ),
//         SizedBox(
//           width: 8,
//         ),
//         Flexible(
//           flex: 1,
//           child: SizedBox(
//             height: 65,
//             width: MediaQuery.of(context).size.width,
//             child: TextButton(
//               onPressed: () async {
//                 final String? id =
//                     await context.pushNamed(RouteNames.customerNameRoute);

//                 if (id != null) {
//                   ref
//                       .read(updateFrameNotifierProvider.notifier)
//                       .changeCustomerId(customerIdStr: id, index: index);

//                   frame.customerTextController[index].text = id;
//                 }
//               },
//               style: ButtonStyle(
//                   padding: WidgetStatePropertyAll(EdgeInsets.zero)),
//               child: IgnorePointer(
//                 ignoring: true,
//                 child: TextFormField(
//                   controller: frame.customerTextController[index],
//                   decoration: Themes.formStyle(customerIdStr != ''
//                       ? customerIdStr + ' (ketik untuk ubah teks)'
//                       : 'Masukkan tujuan'),
//                   keyboardType: TextInputType.name,
//                   onChanged: (value) => ref
//                       .read(updateFrameNotifierProvider.notifier)
//                       .changeCustomerId(customerIdStr: value, index: index),
//                   validator: (_) => ref
//                       .read(updateFrameNotifierProvider)
//                       .updateFrameList[index]
//                       .customerId
//                       .value
//                       .fold(
//                         (f) => f.maybeMap(
//                           empty: (_) => 'kosong',
//                           orElse: () => null,
//                         ),
//                         (_) => null,
//                       ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         SizedBox(
//           width: 8,
//         ),
//         Flexible(
//           flex: 1,
//           child: Text(
//             '${customerSelected.nama ?? ''}',
//             style:
//                 Themes.customColor(FontWeight.normal, 12, Palette.primaryColor),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ],
//     );
//   }
// }
