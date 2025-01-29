import 'package:flutter/material.dart';

import '../../features/create_pin/presentation/ui/page.dart';
import '../../features/dashboard/presentation/ui/page.dart';
import '../../features/facial_recognition/presentation/ui/page.dart';
import '../../features/login/presentation/ui/page.dart';
import '../../features/onboarding/presentation/ui.dart';
import '../../features/onboarding2/presentation/ui.dart';
import '../../features/signup/presentation/ui/page.dart';
import '../../features/splash_screen/presentation/ui.dart';
import '../../features/verify/presentation/ui/page.dart';
import '../../features/virtual_account_selection/presentation/ui/page.dart';

export 'router.dart';

final appRoutes = <String, WidgetBuilder>{
  '/': (context) => const SplashScreen(),
  OnboardingPage.routeName: (context) => const OnboardingPage(),
  OnboardingPage2.routeName: (context) => const OnboardingPage2(),
  LoginPage.routeName: (context) => const LoginPage(),
  SignupPage.routeName: (context) => const SignupPage(),
  CreatePinPage.routeName: (context) => const CreatePinPage(),
  FacialRecognitionPage.routeName: (context) => const FacialRecognitionPage(),
  VerifyPage.routeName: (context) => const VerifyPage(),
  VirtualAccountSelectionPage.routeName: (context) =>
      const VirtualAccountSelectionPage(),
  Dashboard.routeName: (context) => const Dashboard(),
};

Route<dynamic>? onGenerateRoute(RouteSettings settings) =>
    CustomPageRoute(builder: appRoutes[settings.name]!, settings: settings);

class CustomPageRoute<T> extends MaterialPageRoute<T> {
  CustomPageRoute({required super.builder, super.settings});
}
