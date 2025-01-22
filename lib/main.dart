import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/constants/languages.dart';
import 'core/routers/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    ProviderScope(
      child: EasyLocalization(
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        supportedLocales: kLanguages.keys.toList(),
        useFallbackTranslationsForEmptyResources: true,
        child: const EmmPay(),
      ),
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
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 26.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          showDragHandle: true,
          backgroundColor: Colors.white,
          dragHandleColor: Theme.of(context).highlightColor,
        ),
        chipTheme: ChipThemeData(
          padding: EdgeInsets.zero,
          labelStyle: TextStyle(
            fontSize: 12.0,
            color: Colors.blueGrey.shade600,
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
