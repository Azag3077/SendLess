import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/dialogs.dart';
import '../../../core/extensions/num_duration.dart';
import '../../../core/routers/app_routes.dart';
import '../../settings/presentation/ui/page.dart';

export 'package:flutter_riverpod/flutter_riverpod.dart';

final changePasswordPageProvider =
    AutoDisposeNotifierProvider<_Notifier, _State>(_Notifier.new);

class _State {
  const _State({
    this.obscureText1 = true,
    this.obscureText2 = true,
    this.fieldText1 = '',
    this.fieldText2 = '',
    this.fieldText3 = '',
  });

  final bool obscureText1;
  final bool obscureText2;
  final String fieldText1;
  final String fieldText2;
  final String fieldText3;

  _State copyWith({
    bool? obscureText1,
    bool? obscureText2,
    String? fieldText1,
    String? fieldText2,
    String? fieldText3,
  }) {
    return _State(
      obscureText1: obscureText1 ?? this.obscureText1,
      obscureText2: obscureText2 ?? this.obscureText2,
      fieldText1: fieldText1 ?? this.fieldText1,
      fieldText2: fieldText2 ?? this.fieldText2,
      fieldText3: fieldText3 ?? this.fieldText3,
    );
  }
}

class _Notifier extends AutoDisposeNotifier<_State> {
  @override
  _State build() => const _State();

  void toggleObscureText1() =>
      state = state.copyWith(obscureText1: !state.obscureText1);

  void toggleObscureText2() =>
      state = state.copyWith(obscureText2: !state.obscureText2);

  void updateFieldText1(String value) =>
      state = state.copyWith(fieldText1: value);

  void updateFieldText2(String value) =>
      state = state.copyWith(fieldText2: value);

  void updateFieldText3(String value) =>
      state = state.copyWith(fieldText3: value);

  void onForgotPassword(BuildContext context) {}

  Future<void> onChangePassword(
      BuildContext context, GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) return;

    showLoadingDialog(context);

    await Future.delayed(2.seconds);

    if (!context.mounted) return;

    popUntil(context, SettingsPage.routeName);
  }
}
