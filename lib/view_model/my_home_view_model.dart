import 'package:state_notifier/state_notifier.dart';

import '../state/my_home_state.dart';

class MyHomePageStateNotifier extends StateNotifier<MyHomePageState> {
  MyHomePageStateNotifier() : super(const MyHomePageState());

  void increment() {
    state = state.copyWith(state.counter + 1);
  }

  void reBuild() {
    state = const MyHomePageState();
  }
}
