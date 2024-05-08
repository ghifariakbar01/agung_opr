import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'cs_cranny_column.dart';

class CSCrannyPage extends ConsumerStatefulWidget {
  const CSCrannyPage();

  @override
  ConsumerState<CSCrannyPage> createState() => _CSCrannyPageState();
}

class _CSCrannyPageState extends ConsumerState<CSCrannyPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CSCrannyColumn(),
      ],
    );
  }
}
