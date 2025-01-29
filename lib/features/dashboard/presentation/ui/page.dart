import 'package:flutter/material.dart';

import '../../../../components/buttons.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/constants/texts.dart';
import '../../../home/presentation/ui/page.dart';
import '../provider.dart';
import 'components/navbar_item.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});

  static const routeName = '/dashboard';
  static final _pageText = AppTexts.virtualAccountSelectionPage;

  List<Widget> get _screens => const <Widget>[
        HomePage(),
        CardPage(),
        Scaffold(backgroundColor: Colors.blue),
        Scaffold(backgroundColor: Colors.yellow),
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
              label: 'Home',
            ),
            NavbarItem(
              iconPath: AssetImages.svgs.card,
              label: 'Card',
            ),
            NavbarItem(
              iconPath: AssetImages.svgs.bill,
              label: 'Bills',
            ),
            NavbarItem(
              iconPath: AssetImages.svgs.profile,
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class CardPage extends StatelessWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('USD Card')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              height: 216.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(
                  image: AssetImage(AssetImages.pngs.visaCard),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Emmpay card Built for Your Digital Life',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16.0),
            buildRow(
              context: context,
              iconData: Icons.language,
              title: 'Shop globally',
              subtitle: 'Use your Orbit Card for online '
                  'purchase anywhere Visa cards are accepted',
            ),
            const SizedBox(height: 8.0),
            buildRow(
              context: context,
              iconData: Icons.language,
              title: 'Budget Effectively',
              subtitle: 'Limit spending by only using '
                  'the amount uploaded to your card',
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                textStyle: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: const Text('Terms and Conditions'),
            ),
            const Spacer(),
            CustomFilledButton(
              text: 'Claim my card',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Row buildRow({
    required BuildContext context,
    required IconData iconData,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(iconData),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
