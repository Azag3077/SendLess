import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../components/buttons.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/constants/texts.dart';
import '../../../home/presentation/ui/page.dart';
import '../provider.dart';
import 'components/navbar_item.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});

  static const routeName = '/dashboard';
  static final _pageText = AppTexts.dashboard;

  List<Widget> get _screens => <Widget>[
        const HomePage(),
        const CardPage(),
        BalanceScreen(),
        const Scaffold(backgroundColor: Colors.blue),
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
              height: 180.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(
                  image: AssetImage(AssetImages.pngs.visaCard),
                  // fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'SendLess card Built for Your Digital Life',
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

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            const CircleAvatar(
              radius: 30.0,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Dummy User',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Colors.black.withValues(alpha: .71),
              ),
            ),
            Text(
              '@Dummy_user',
              style: TextStyle(
                color: Colors.black.withValues(alpha: .71),
              ),
            ),
            const SizedBox(height: 24.0),
            _buildListTile(
              context: context,
              title: 'Full Name',
              subtitle: 'Dummy User',
              onPressed: () {},
              trailingIcon: Icons.edit_note,
            ),
            _buildListTile(
              context: context,
              title: 'Phone Number',
              subtitle: '08012345678',
              onPressed: () {},
              trailingIcon: Icons.edit_note,
            ),
            _buildListTile(
              context: context,
              title: 'Email',
              subtitle: 'dummyemail@test.com',
              onPressed: () {},
              trailingIcon: Icons.edit_note,
            ),
            _buildListTile(
              context: context,
              title: 'Settings',
              subtitle: 'control your notification and security settings',
              onPressed: () {},
            ),
            _buildListTile(
              context: context,
              title: 'Get help',
              subtitle: 'Get support or send feedback',
              onPressed: () {},
            ),
            _buildSocialListTile(
              text: 'Follow on Instagram',
              assetName: AssetImages.svgs.instagram,
              onPressed: () {},
            ),
            _buildSocialListTile(
              text: 'Follow on youtube',
              assetName: AssetImages.svgs.youtube,
              onPressed: () {},
            ),
            _buildSocialListTile(
              text: 'Follow on X',
              assetName: AssetImages.svgs.x,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  ListTile _buildListTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    VoidCallback? onPressed,
    IconData? trailingIcon,
  }) {
    return ListTile(
      onTap: () {},
      title: Text(title),
      subtitle: Text(subtitle),
      titleTextStyle: Theme.of(context).textTheme.titleMedium,
      subtitleTextStyle: Theme.of(context).textTheme.bodyLarge,
      trailing: trailingIcon == null ? null : Icon(trailingIcon),
    );
  }

  Widget _buildSocialListTile({
    required String text,
    required String assetName,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: <Widget>[
          ListTile(
            onTap: onPressed,
            leading: SvgPicture.asset(assetName),
            title: Text(text),
            titleTextStyle: const TextStyle(
              fontSize: 16.0,
              color: Color(0xFF5E5E5E),
              fontWeight: FontWeight.w500,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
          ),
          const Padding(
            padding: EdgeInsetsDirectional.only(start: 40.0),
            child: Divider(height: 2.0),
          ),
        ],
      ),
    );
  }
}

// class BalanceScreen extends StatefulWidget {
//   @override
//   _BalanceScreenState createState() => _BalanceScreenState();
// }
//
// class _BalanceScreenState extends State<BalanceScreen> {
//   bool _isHidden = true;
//   final String _balance = "\$5,000.00"; // Example balance
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Animated Balance")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 200,
//               padding: EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: AnimatedSwitcher(
//                   duration: Duration(milliseconds: 500),
//                   transitionBuilder: (widget, animation) {
//                     return FadeTransition(
//                       opacity: animation,
//                       child: widget,
//                     );
//                   },
//                   child: SizedBox(
//                     width: double.infinity, // Fixed width ensures alignment stays the same
//                       key: ValueKey<bool>(_isHidden),
//                     child: Text(
//                       _isHidden ? "****" : _balance,
//                       style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   _isHidden = !_isHidden;
//                 });
//               },
//               child: Text(_isHidden ? "Show Balance" : "Hide Balance"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class BalanceScreen extends StatefulWidget {
  @override
  _BalanceScreenState createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  bool _isHidden = true;
  bool _isComplete = false;

  // final String _balance = "\$5,000.00"; // Example balance
  final int _balance = 5000; // Example balance

  @override
  Widget build(BuildContext context) {
    final azag = Text(
      _isHidden ? '****' : _balance.toString(),
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Animated Balance')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // children: [
          //   Container(
          //     width: 200,
          //     padding: const EdgeInsets.all(12),
          //     decoration: BoxDecoration(
          //       color: Colors.grey[200],
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: <Widget>[
          //         Text(_balance.toString())
          //             .animate(target: _isHidden ? 0 : 1)
          //             .crossfade(
          //                 duration: 1.seconds,
          //                 alignment: Alignment.centerLeft,
          //                 builder: (_) {
          //                   return Text('D');
          //                 })
          //             .custom(builder: (_, __, ___) {
          //               print(___);
          //           return ___;
          //         }),
          //         Animate(
          //           effects: [FadeEffect(), CrossfadeEffect(builder: (BuildContext context) { return Text('Python'); })],
          //             target: _isHidden ? 1 : 0,
          //           child: Text("Hello World!").animate().fadeIn(),
          //         ),
          //         azag
          //             .animate(target: _isHidden ? 0 : 1)
          //             .custom(
          //               duration: 2.seconds,
          //               builder: (_, double value, __) {
          //                 final amount = value.clamp(0, 1200.23) * 1200.23;
          //
          //                 if (_isHidden) {
          //                   return const Text(
          //                     '****',
          //                     style: TextStyle(
          //                         fontSize: 24, fontWeight: FontWeight.bold),
          //                   );
          //                 }
          //                 return Text(
          //                   NumberFormat.currency(symbol: '\$').format(amount),
          //                   style: const TextStyle(
          //                     fontSize: 24,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 );
          //               },
          //             )
          //             .fade(end: 0.2, duration: 1.seconds)
          //             .scaleX(end: 1.1, duration: 1.seconds),
          //         if (_isHidden)
          //           const Text(
          //             '****',
          //             style:
          //                 TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          //           )
          //         else
          //           const Text(
          //             '\$0.00', // Placeholder, actual value animates
          //             style:
          //                 TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          //           )
          //               .animate()
          //               .custom(
          //                 duration: 2.seconds,
          //                 builder: (_, double value, __) {
          //                   final amount = value.clamp(0, 1200.23) * 1200.23;
          //
          //                   // if (_isHidden) {
          //                   //   return const Text(
          //                   //     '****',
          //                   //     style: TextStyle(
          //                   //         fontSize: 24, fontWeight: FontWeight.bold),
          //                   //   );
          //                   // }
          //                   return Text(
          //                     NumberFormat.currency(symbol: '\$')
          //                         .format(amount),
          //                     style: const TextStyle(
          //                       fontSize: 24,
          //                       fontWeight: FontWeight.bold,
          //                     ),
          //                   );
          //                 },
          //               )
          //               .fade(duration: 500.ms)
          //         // .slideX(begin: 0.2, end: 0),
          //       ],
          //     ),
          //   ),
          //   const SizedBox(height: 20),
          //   ElevatedButton(
          //     onPressed: () {
          //       setState(() {
          //         _isHidden = !_isHidden;
          //       });
          //     },
          //     child: Text(_isHidden ? "Show Balance" : "Hide Balance"),
          //   ),
          // ],
          children: <Widget>[
            Container(
              width: 200,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: DefaultTextStyle(
                style: const TextStyle(fontSize: 24.0, color: Colors.black),
                child: Row(children: List.generate(5, (_) => const Icon(Icons.emergency_rounded))).animate(target: _isHidden ? 1 : 0).crossfade(
                  builder: (_) {
                    return Text(
                      _balance.toString(),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => setState(() => _isHidden = !_isHidden),
              child: Text(_isHidden ? 'Show Balance' : 'Hide Balance'),
            ),
          ],
        ),
      ),
    );
  }
}
