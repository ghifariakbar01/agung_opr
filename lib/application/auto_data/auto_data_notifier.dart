import 'package:agung_opr/application/auto_data/auto_data_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AutoDataNotifier extends StateNotifier<AutoDataState> {
  AutoDataNotifier() : super(AutoDataState.initial());
}
