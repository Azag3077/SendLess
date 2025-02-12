import 'package:flutter/material.dart';

import '../../../../components/textfields.dart';
import '../../../../core/constants/assets.dart';
import '../provider.dart';
import 'components/bills_grid.dart';

class BillsPaymentPage extends ConsumerWidget {
  const BillsPaymentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(billsPaymentPageProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Bills Payment')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SignupTextField(
              labelText: '',
              hintText: 'Search anything',
              suffixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
            Text(
              'Essentials',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16.0),
            BillsGrid(
              children: <BillsButton>[
                BillsButton(
                  text: 'Airtime',
                  iconPath: AssetImages.svgs.call,
                  onPressed: () => notifier.onAirtime(context),
                ),
                BillsButton(
                  text: 'Internet',
                  iconPath: AssetImages.svgs.wifi,
                  onPressed: () => notifier.onInternet(context),
                ),
                BillsButton(
                  text: 'Tv',
                  iconPath: AssetImages.svgs.tv,
                  onPressed: () => notifier.onTv(context),
                ),
                BillsButton(
                  text: 'Electricity',
                  iconPath: AssetImages.svgs.bulb,
                  onPressed: () => notifier.onElectricity(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
