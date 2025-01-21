import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/constants/languages.dart';
import 'core/routers/app_routes.dart';

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
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3E9850)),
        primaryColor: const Color(0xFF3E9850),
        useMaterial3: true,
        bottomSheetTheme: BottomSheetThemeData(
          showDragHandle: true,
          backgroundColor: Colors.white,
          dragHandleColor: Theme.of(context).highlightColor,
        ),
        chipTheme: ChipThemeData(
          padding: EdgeInsets.zero,
          labelStyle: const TextStyle(
            fontSize: 12.0,
            color: Colors.blueGrey,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
      onGenerateRoute: onGenerateRoute,
    );
  }
}
