import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../components/buttons.dart';
import '../../../../components/textfields.dart';
import '../../../../core/constants/assets.dart';
import '../provider.dart';
import 'page_views/send_type.dart';

class SendPage extends ConsumerStatefulWidget {
  const SendPage({super.key});

  static const routeName = '/send';

  @override
  ConsumerState<SendPage> createState() => _SendPageState();
}

class _SendPageState extends ConsumerState<SendPage> {
  final _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(sendPageProvider);
    final notifier = ref.read(sendPageProvider.notifier);

    final textTheme = Theme.of(context).textTheme;

    return PopScope(
      canPop: state.pageIndex == 0,
      onPopInvokedWithResult: (_, __) => notifier.onBackButton(_controller),
      child: Scaffold(
        appBar: AppBar(title: const Text('Send')),
        body: Column(
          children: <Widget>[
            if (state.pageIndex < 2)
              Container(
                margin: const EdgeInsets.all(16.0),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 8.0,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFC9D0FF),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Text('Available Balance: \$1,565,520.57'),
              ),
            Expanded(
              child: PageView(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: notifier.onPageChanged,
                children: <Widget>[
                  SendTypeView(
                    onBox1: () => notifier.onType(_controller, SendType.viaApp),
                    onBox2: () =>
                        notifier.onType(_controller, SendType.viaBank),
                  ),
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Image.asset(
                            AssetImages.pngs.splash,
                            width: 96.0,
                          ),
                        ),
                        Text(
                          'User ID',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8.0),
                        SignupTextField(
                          prefixIcon: IntrinsicHeight(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 12.0,
                                  ),
                                  child: Text(
                                    '@',
                                    style: textTheme.titleLarge,
                                  ),
                                ),
                                const VerticalDivider(width: 0),
                                const SizedBox(width: 8.0),
                              ],
                            ),
                          ),
                          onChanged: notifier.updateUsername,
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey.shade200,
                                spreadRadius: 5.0,
                                blurRadius: 5.0,
                              ),
                            ],
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              children: <Widget>[
                                const SizedBox(width: 10.0),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'You send',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black45,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      Text(
                                        '0',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black45,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 120.0,
                                  height: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 24.0,
                                  ),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  child: Row(
                                    children: <Widget>[
                                      Image.asset(
                                        AssetImages.pngs.nigeriaFlag,
                                        width: 32.0,
                                      ),
                                      const SizedBox(width: 8.0),
                                      const Text(
                                        'NGN',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const CustomRow(
                          label: 'Rate',
                          value: '1 UDD = 1556.24 NGN',
                          strikeValue: true,
                        ),
                        CustomRow(
                          label: 'Bonus',
                          value: '1 UDD = 1556.39 NGN',
                          icon: AssetImages.pngs.bonus,
                        ),
                        CustomRow(
                          label: 'Frequency',
                          value: 'One Time',
                          icon: AssetImages.pngs.radio,
                        ),
                        CustomRow(
                          label: 'Wallet Balance',
                          value: 'Select',
                          icon: AssetImages.pngs.wallet,
                        ),
                        const SizedBox(
                          height: 40.0,
                          child: VerticalDivider(
                            width: 32.0,
                            thickness: 2.5,
                          ),
                        ),
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey.shade200,
                                spreadRadius: 5.0,
                                blurRadius: 5.0,
                              ),
                            ],
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              children: <Widget>[
                                const SizedBox(width: 10.0),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'You send',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black45,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      Text(
                                        '0',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black45,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 120.0,
                                  height: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 24.0,
                                  ),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  child: Row(
                                    children: <Widget>[
                                      Image.asset(
                                        AssetImages.pngs.nigeriaFlag,
                                        width: 32.0,
                                      ),
                                      const SizedBox(width: 8.0),
                                      const Text(
                                        'NGN',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      const SizedBox(height: 32.0),
                      Image.asset(AssetImages.pngs.doubleArrows),
                      const SizedBox(height: 32.0),
                      Text('20,000.00', style: textTheme.titleLarge),
                      SizedBox(
                        width: 180.0,
                        child: Text(
                          'Will be sent from your SendLess account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:
                                const Color(0xFF030D13).withValues(alpha: .3),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      Text('To', style: textTheme.titleLarge),
                      const Text('Johnny Bravo'),
                      const Text('0123456'),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomFilledButton(
                text: state.pageIndex != 2 ? 'Send' : 'Next',
                onPressed: state.username.isEmpty
                    ? null
                    : () => notifier.onActionButton(context, _controller),
              ),
            ).animate(target: state.pageIndex != 0 ? 1 : 0).fade(),
          ],
        ),
      ),
    );
  }
}

class CustomRow extends StatelessWidget {
  const CustomRow({
    super.key,
    required this.label,
    required this.value,
    this.strikeValue = false,
    this.icon,
  });

  final String label;
  final String value;
  final bool strikeValue;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 40.0,
          child: VerticalDivider(
            width: 32.0,
            thickness: 2.5,
          ),
        ),
        Row(
          children: <Widget>[
            SizedBox.square(
              dimension: 32.0,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
                child: icon == null ? null : Image.asset(icon!),
              ),
            ),
            const SizedBox(width: 8.0),
            Text(label),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  value,
                  style: TextStyle(
                    decoration: strikeValue ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
