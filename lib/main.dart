import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/splash_screen/presentation/ui.dart';
import 'core/constants/languages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      supportedLocales: kLanguages.keys.toList(),
      useFallbackTranslationsForEmptyResources: true,
      child: const ProviderScope(child: EmmPay()),
    ),
  );
}

class EmmPay extends StatelessWidget {
  const EmmPay({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EmmPay',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
