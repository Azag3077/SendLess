import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/routers/router.dart';
import '../../onboarding2/presentation/ui.dart';

final loginPageProvider = Provider<_Provider>((_) => _Provider());

class _Provider {
  void onLogin(BuildContext context) =>
      pushNamed(context, OnboardingPage2.routeName);

  void onForgotPassword(BuildContext context) {}
}
