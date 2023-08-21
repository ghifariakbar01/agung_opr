import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';

import '../customer.dart';

class CustomerItem extends StatelessWidget {
  const CustomerItem({
    Key? key,
    required this.customer,
  }) : super(key: key);

  final Customer customer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Palette.primaryColor, width: 2)),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ID: ${customer.id}',
                        style: Themes.customColor(
                            FontWeight.bold, 14, Palette.primaryColor),
                      ),
                      Text(
                        'NAMA: ${customer.title ?? ''} ${customer.nama}',
                        style: Themes.customColor(
                            FontWeight.bold, 12, Palette.primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
