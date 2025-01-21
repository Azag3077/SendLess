import 'package:flutter/material.dart';

import '../../features/login/presentation/ui/page.dart';
import '../../features/signup/presentation/ui/page.dart';
import '../../features/onboarding/presentation/ui.dart';
import '../../features/onboarding2/presentation/ui.dart';
import '../../features/splash_screen/presentation/ui.dart';

export 'router.dart';

final appRoutes = <String, WidgetBuilder>{
  '/': (context) => const SplashScreen(),
  OnboardingPage.routeName: (context) => const OnboardingPage(),
  OnboardingPage2.routeName: (context) => const OnboardingPage2(),
  LoginPage.routeName: (context) => const LoginPage(),
  SignupPage.routeName: (context) => const SignupPage(),
};

Route<dynamic>? onGenerateRoute(RouteSettings settings) =>
    CustomPageRoute(builder: appRoutes[settings.name]!, settings: settings);

class CustomPageRoute<T> extends MaterialPageRoute<T> {
  CustomPageRoute({required super.builder, super.settings});

  // @override
  // Duration get transitionDuration => 800.milliseconds;
}
