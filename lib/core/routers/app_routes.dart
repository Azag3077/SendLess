import 'package:flutter/material.dart';

import '../../features/airtime/presentation/ui/page.dart';
import '../../features/change_password/presentation/ui/page.dart';
import '../../features/change_pin/presentation/ui/page.dart';
import '../../features/convert/presentation/ui/page.dart';
import '../../features/create_pin/presentation/ui/page.dart';
import '../../features/dashboard/presentation/ui/page.dart';
import '../../features/facial_recognition/presentation/ui/page.dart';
import '../../features/login/presentation/ui/page.dart';
import '../../features/onboarding/presentation/ui.dart';
import '../../features/onboarding2/presentation/ui.dart';
import '../../features/receipt/presentation/ui/page.dart';
import '../../features/send/presentation/ui/page.dart';
import '../../features/settings/presentation/ui/page.dart';
import '../../features/signup/presentation/ui/page.dart';
import '../../features/splash_screen/presentation/ui.dart';
import '../../features/successful/presentation/ui/page.dart';
import '../../features/transfer/presentation/ui/page.dart';
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
  AirtimePage.routeName: (context) => const AirtimePage(),
  SendPage.routeName: (context) => const SendPage(),
  SuccessfulPage.routeName: (context) => const SuccessfulPage(),
  ReceiptPage.routeName: (context) => const ReceiptPage(),
  TransferPage.routeName: (context) => const TransferPage(),
  SettingsPage.routeName: (context) => const SettingsPage(),
  ChangePasswordPage.routeName: (context) => const ChangePasswordPage(),
  ChangePinPage.routeName: (context) => const ChangePinPage(),
  ConvertPage.routeName: (context) => const ConvertPage(),
};

Route<dynamic>? onGenerateRoute(RouteSettings settings) =>
    CustomPageRoute(builder: appRoutes[settings.name]!, settings: settings);

class CustomPageRoute<T> extends MaterialPageRoute<T> {
  CustomPageRoute({required super.builder, super.settings});
}
