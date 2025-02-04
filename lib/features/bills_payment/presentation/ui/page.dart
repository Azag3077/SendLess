import 'package:flutter/material.dart';

import '../../../../components/textfields.dart';
import '../../../../core/constants/assets.dart';
import '../provider.dart';
import 'components/bills_grid.dart';

class BillsPaymentPage extends ConsumerWidget {
  const BillsPaymentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cardPageProvider);
    final notifier = ref.watch(cardPageProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Bills Payment')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SignupTextField(
              labelText: '',
              hintText: 'Search any thing',
              suffixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
            Text(
              'Essential',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24.0),
            BillsGrid(
              children: <BillsContainer>[
                BillsContainer(
                  text: 'Airtime',
                  iconPath: AssetImages.svgs.send,
                  onPressed: () {},
                ),
                BillsContainer(
                  text: 'Internet',
                  iconPath: AssetImages.svgs.arrowLeftRight,
                  onPressed: () {},
                ),
                BillsContainer(
                  text: 'Tv',
                  iconPath: AssetImages.svgs.arrowUpRight,
                  onPressed: () {},
                ),
                BillsContainer(
                  text: 'Electricity',
                  iconPath: AssetImages.svgs.briefCase,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
