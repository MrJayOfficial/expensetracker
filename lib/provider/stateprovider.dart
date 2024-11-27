import 'package:flutter_riverpod/flutter_riverpod.dart';

class StateProviders extends StateNotifier<bool> {
  // bool value = false;
  StateProviders() : super(false);

  void onChanged(bool value) {
    if (value == false) {
      state = true;
    } else {
      state = false;
    }
  }
}

final prv = StateNotifierProvider<StateProviders, bool>((ref) {
  return StateProviders();
});
