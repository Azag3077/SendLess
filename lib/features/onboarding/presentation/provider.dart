import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/routers/router.dart';
import '../../dashboard/presentation/ui/page.dart';
import '../../login/presentation/ui/page.dart';
import '../../onboarding2/presentation/ui.dart';

final onboardingPageProvider = Provider<_Provider>((_) => _Provider());

class _Provider {
  void onGetStarted(BuildContext context) =>
      pushNamed(context, OnboardingPage2.routeName);

  void onLogin(BuildContext context) {
    if (kDebugMode) {
      return pushNamedAndRemoveUntil(context, Dashboard.routeName);
    }

    pushNamed(context, LoginPage.routeName);
  }
}
