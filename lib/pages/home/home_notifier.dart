import 'dart:async';

import 'package:attendance_management/services/auth_service.dart';
import 'package:attendance_management/states/app_state.dart';
import 'package:attendance_management/states/home_state.dart';
import 'package:state_notifier/state_notifier.dart';

class HomeNotifier extends StateNotifier<HomeState> with LocatorMixin {
  HomeNotifier() : super(HomeState(datetime: DateTime.now()));

  Timer _timer;

  StreamSubscription _subscription;

  AuthService get _auth => read();

  @override
  void initState() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      _onChangeTimer,
    );
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    if (_subscription != null) {
      _subscription.cancel();
      _subscription = null;
    }
    super.dispose();
  }

  void _onInitialize(AppState appState) {
    state = state.copyWith(
      user: appState.userState,
    );
  }

  void _onChangeTimer(Timer timer) {
    final now = DateTime.now();
  }

  void _onChangeUser(AppState appState) {
    state = state.copyWith(
      user: appState.userState,
    );
  }

  Future<void> signOut() async {
    _auth.signOut();
  }
}
