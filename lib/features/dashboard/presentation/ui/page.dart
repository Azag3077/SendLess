import 'package:flutter/material.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/constants/texts.dart';
import '../../../bills_payment/presentation/ui/page.dart';
import '../../../card/presentation/ui/page.dart';
import '../../../home/presentation/ui/page.dart';
import '../../../profile/presentation/ui/page.dart';
import '../provider.dart';
import 'components/navbar_item.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});

  static const routeName = '/dashboard';
  static final _pageText = AppTexts.dashboard;

  List<Widget> get _screens => <Widget>[
        const HomePage(),
        const CardPage(),
        const BillsPaymentPage(),
        const ProfilePage(),
      ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPageIndex = ref.watch(dashboardProvider);
    final notifier = ref.read(dashboardProvider.notifier);

    final screen = _screens[currentPageIndex];

    return PopScope(
      canPop: currentPageIndex == 0,
      onPopInvokedWithResult: (_, __) => notifier.updatePageIndex(0),
      child: Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: screen,
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: notifier.updatePageIndex,
          currentIndex: currentPageIndex,
          elevation: 12.0,
          backgroundColor: Colors.white,
          selectedItemColor: Theme.of(context).primaryColor,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(height: 1.4),
          items: <NavbarItem>[
            NavbarItem(
              iconPath: AssetImages.svgs.home,
              label: _pageText.home.tr(),
            ),
            NavbarItem(
              iconPath: AssetImages.svgs.card,
              label: _pageText.card.tr(),
            ),
            NavbarItem(
              iconPath: AssetImages.svgs.bill,
              label: _pageText.bills.tr(),
            ),
            NavbarItem(
              iconPath: AssetImages.svgs.profile,
              label: _pageText.profile.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
