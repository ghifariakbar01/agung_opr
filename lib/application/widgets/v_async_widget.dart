import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class VAsyncValueWidget<T> extends StatelessWidget {
  const VAsyncValueWidget({required this.value, required this.data});
  final AsyncValue<T> value;
  final Widget Function(T) data;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: (e, st) => Center(child: Text(e.toString())),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}
