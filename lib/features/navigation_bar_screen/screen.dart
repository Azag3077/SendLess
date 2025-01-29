// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/svg.dart';
//
// import '../../constants/asset_path.dart';
// import '../../constants/color_constants.dart';
// import '../../data/enums.dart';
// import '../../utils/providers.dart';
// import '../home_screen/customer/screen.dart';
// import '../home_screen/vendor/screen.dart';
// import '../orders_screen/customer/screen.dart';
// import '../orders_screen/vendor/screen.dart';
// import '../profile/screens/customer_profile.dart';
// import '../profile/screens/vendor_profile.dart';
// import '../wallet_screen/wallet.dart';
// import 'provider.dart';
//
// class NavigationScreen extends ConsumerWidget {
//   const NavigationScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final currentPageIndex = ref.watch(navigationScreenProvider);
//     final notifier = ref.read(navigationScreenProvider.notifier);
//     final role = ref.watch(userProfileProvider)!.roleNames.first;
//
//     final screens = role == Role.customer
//         ? <Widget>[
//             const CustomerHomeScreen(),
//             const WalletScreen(),
//             const CustomerOrdersScreen(),
//             const CustomerProfileScreen(),
//           ]
//         : <Widget>[
//             const VendorHomeScreen(),
//             const WalletScreen(),
//             const VendorOrdersScreen(),
//             const VendorProfileScreen(),
//           ];
//
//     return PopScope(
//       canPop: currentPageIndex == 0,
//       onPopInvoked: (_) => notifier.updatePageIndex(0),
//       child: Scaffold(
//         body: AnimatedSwitcher(
//           duration: const Duration(milliseconds: 500),
//           transitionBuilder: (Widget child, Animation<double> animation) {
//             return FadeTransition(
//               opacity: animation,
//               child: child,
//             );
//           },
//           child: screens[currentPageIndex],
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           onTap: notifier.updatePageIndex,
//           currentIndex: currentPageIndex,
//           elevation: 12.0,
//           backgroundColor: Colors.white,
//           selectedItemColor: epicBlue,
//           showUnselectedLabels: false,
//           type: BottomNavigationBarType.fixed,
//           selectedLabelStyle: const TextStyle(height: 1.4),
//           items: <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               activeIcon: SvgPicture.asset(Work4MeSvgAssets.homeFill),
//               icon: SvgPicture.asset(Work4MeSvgAssets.homeOutline),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               activeIcon: SvgPicture.asset(Work4MeSvgAssets.walletFill),
//               icon: SvgPicture.asset(Work4MeSvgAssets.walletOutline),
//               label: 'Wallet',
//             ),
//             BottomNavigationBarItem(
//               activeIcon: SvgPicture.asset(Work4MeSvgAssets.calendarFill),
//               icon: SvgPicture.asset(Work4MeSvgAssets.calendarOutline),
//               label: 'Orders',
//             ),
//             BottomNavigationBarItem(
//               activeIcon: SvgPicture.asset(Work4MeSvgAssets.profileFill),
//               icon: SvgPicture.asset(Work4MeSvgAssets.profileOutline),
//               label: 'Profile',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
