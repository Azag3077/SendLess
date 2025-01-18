// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import 'constants/colors.dart';
// import 'constants/languages.dart';
// import 'routers/app_routes.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await EasyLocalization.ensureInitialized();
//
//   runApp(
//     EasyLocalization(
//       path: 'assets/translations',
//       fallbackLocale: const Locale('en', 'US'),
//       supportedLocales: languages.keys.toList(),
//       useFallbackTranslationsForEmptyResources: true,
//       child: const ProviderScope(child: MoneyTransfer()),
//     ),
//   );
// }
//
// class MoneyTransfer extends StatelessWidget {
//   const MoneyTransfer({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Papifi',
//       localizationsDelegates: context.localizationDelegates,
//       supportedLocales: context.supportedLocales,
//       locale: context.locale,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: appMaterialColor),
//         scaffoldBackgroundColor: Colors.white,
//         appBarTheme: const AppBarTheme(
//           centerTitle: true,
//           backgroundColor: Colors.white,
//           surfaceTintColor: Colors.white,
//           titleTextStyle: TextStyle(
//             fontSize: 16.0,
//             color: AppColors.textColor,
//           ),
//         ),
//         dividerTheme: const DividerThemeData(
//           color: AppColors.dividerColor,
//         ),
//         filledButtonTheme: FilledButtonThemeData(
//           style: FilledButton.styleFrom(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(6.0),
//             ),
//           ),
//         ),
//         expansionTileTheme: ExpansionTileThemeData(
//           backgroundColor: Colors.red,
//           collapsedBackgroundColor: Colors.green,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(50),
//           ),
//         ),
//         bottomSheetTheme: BottomSheetThemeData(
//           showDragHandle: true,
//           backgroundColor: Colors.white,
//           dragHandleColor: Theme.of(context).highlightColor,
//         ),
//         textTheme: TextTheme(
//           titleLarge: TextStyle(
//             fontSize: 26.0,
//             fontWeight: FontWeight.bold,
//             color: appMaterialColor.shade300,
//           ),
//           titleMedium: TextStyle(
//             fontSize: 18.0,
//             fontWeight: FontWeight.w500,
//             color: Colors.grey.shade700,
//           ),
//           bodySmall: const TextStyle(
//             fontWeight: FontWeight.w400,
//             fontSize: 12.0,
//             color: AppColors.grey,
//           ),
//         ),
//         chipTheme: ChipThemeData(
//           backgroundColor: Colors.white,
//           surfaceTintColor: Colors.blue,
//           elevation: 0,
//           side: BorderSide(
//             color: Colors.grey.shade300,
//           ),
//         ),
//       ),
//       onGenerateRoute: onGenerateRoute,
//     );
//   }
// }
