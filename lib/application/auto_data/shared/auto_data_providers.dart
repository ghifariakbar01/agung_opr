import 'package:agung_opr/application/auto_data/auto_data_notifier.dart';
import 'package:agung_opr/application/auto_data/auto_data_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final autoDataNotifierProvider =
    StateNotifierProvider<AutoDataNotifier, AutoDataState>(
        (ref) => AutoDataNotifier());
