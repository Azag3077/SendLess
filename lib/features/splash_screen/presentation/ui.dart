import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/assets.dart';
import '../../../core/routers/router.dart';
import '../../onboarding/presentation/ui.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), _navigateToNextScreen);
  }

  void _navigateToNextScreen() {
    if (!mounted) return;

    pushReplacementNamed(context, OnboardingPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF7EE),
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Center(child: Image.asset(AssetImages.pngs.splash)),
    );
  }
}
