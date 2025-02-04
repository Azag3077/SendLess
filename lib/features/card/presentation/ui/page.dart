import 'package:flutter/material.dart';

import '../../../../components/buttons.dart';
import '../../../../core/constants/assets.dart';
import '../provider.dart';
import 'components/virtual_card_container.dart';
import 'components/virtual_card_details.dart';

class CardPage extends ConsumerWidget {
  const CardPage({super.key});

  Row _buildRow({
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cardPageProvider);
    final notifier = ref.watch(cardPageProvider.notifier);

    final ctaText = !state.activated
        ? 'Claim my card'
        : state.visibility
            ? 'Hide Details'
            : 'Show Details';

    return Scaffold(
      appBar: AppBar(title: const Text('USD Card')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            VirtualCardContainer(
              virtualCard: state.virtualCard,
              visibility: state.visibility,
            ),
            const SizedBox(height: 24.0),
            Expanded(
              child: Column(
                children: <Widget>[
                  if (!state.activated) ...[
                    Text(
                      'SendLess card Built for Your Digital Life',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 16.0),
                    _buildRow(
                      context: context,
                      iconData: Icons.language,
                      title: 'Shop globally',
                      subtitle: 'Use your Orbit Card for online '
                          'purchase anywhere Visa cards are accepted',
                    ),
                    const SizedBox(height: 8.0),
                    _buildRow(
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
                  ] else if (state.visibility) ...[
                    Text(
                      'SendLess Virtual Card',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16.0),
                    Flexible(
                      child: CardDetailsContainer(
                        virtualCard: state.virtualCard!,
                        onCopy: notifier.onCopy,
                      ),
                    )
                  ],
                ],
              ),
            ),
            CustomFilledButton(
              text: ctaText,
              onPressed: () => notifier.onCallToActionButton(context),
            ),
          ],
        ),
      ),
    );
  }
}
