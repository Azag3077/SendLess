import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/routers/router.dart';
import '../../change_password/presentation/ui/page.dart';
import '../../change_pin/presentation/ui/page.dart';

export 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsPageProvider = NotifierProvider<_Notifier, _State>(_Notifier.new);

class _State {
  const _State({
    this.darkMode = false,
    this.notification = false,
    this.appUpdater = false,
  });

  final bool darkMode;
  final bool notification;
  final bool appUpdater;

  _State copyWith({
    bool? darkMode,
    bool? notification,
    bool? appUpdater,
  }) {
    return _State(
      darkMode: darkMode ?? this.darkMode,
      notification: notification ?? this.notification,
      appUpdater: appUpdater ?? this.appUpdater,
    );
  }
}

class _Notifier extends Notifier<_State> {
  @override
  _State build() => const _State();

  void toggleDarkMode() => state = state.copyWith(darkMode: !state.darkMode);

  void toggleNotification() =>
      state = state.copyWith(notification: !state.notification);

  void toggleAppUpdater() =>
      state = state.copyWith(appUpdater: !state.appUpdater);

  void onChangePassword(BuildContext context) =>
      pushNamed(context, ChangePasswordPage.routeName);

  void onChangePIN(BuildContext context) =>
      pushNamed(context, ChangePinPage.routeName);

  void onAbout(BuildContext context) {}

  void onDelete(BuildContext context) {}

  void onLogout(BuildContext context) {}
}
