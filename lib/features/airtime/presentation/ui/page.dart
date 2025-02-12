import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../components/buttons.dart';
import '../../../../components/textfields.dart';
import '../../../../core/constants/assets.dart';
import '../../../bills_payment/presentation/ui/components/bills_grid.dart';
import '../provider.dart';

class AirtimePage extends ConsumerWidget {
  const AirtimePage({super.key});

  static const routeName = '/airtime';

  List<String> get _amounts =>
      ['50', '100', '200', '300', '500', '1000', '2000', '5000', '10000'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(airtimePageProvider);
    final notifier = ref.watch(airtimePageProvider.notifier);

    final disabled = state.amount.isEmpty ||
        state.network == null ||
        state.phoneNumber.isEmpty;

    return Scaffold(
      appBar: AppBar(title: const Text('Airtime')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Essentials',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12.0),
                    BillsGrid(
                      children: <BillsButton>[
                        BillsButton(
                          text: Network.mtn.name,
                          iconPath: AssetImages.pngs.mtn,
                          selected: state.network == Network.mtn,
                          onPressed: () => notifier.onNetwork(Network.mtn),
                        ),
                        BillsButton(
                          text: Network.airtel.name,
                          iconPath: AssetImages.pngs.airtel,
                          selected: state.network == Network.airtel,
                          onPressed: () => notifier.onNetwork(Network.airtel),
                        ),
                        BillsButton(
                          text: Network.glo.name,
                          iconPath: AssetImages.pngs.glo,
                          selected: state.network == Network.glo,
                          onPressed: () => notifier.onNetwork(Network.glo),
                        ),
                        BillsButton(
                          text: Network.nineMobile.name,
                          iconPath: AssetImages.pngs.nineMobile,
                          selected: state.network == Network.nineMobile,
                          onPressed: () =>
                              notifier.onNetwork(Network.nineMobile),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    SignupTextField(
                      labelText: 'Phone number',
                      hintText: 'Enter phone number',
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: notifier.updatePhoneNumber,
                      prefixIcon: const Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: 8.0,
                          end: 4.0,
                        ),
                        child: Icon(
                          Icons.phone_android,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Text(
                      'Select Amount',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Wrap(
                      spacing: 8.0,
                      children: _amounts.map((value) {
                        return ActionChip(
                          onPressed: () => notifier.onSelectAmount(value),
                          label: Text('₦$value'),
                          backgroundColor: state.amount == value.toString()
                              ? Theme.of(context).colorScheme.primaryContainer
                              : Colors.white,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12.0),
                    SignupTextField(
                      labelText: 'Custom Amount',
                      hintText: 'Enter amount',
                      onChanged: (value) => notifier.onSelectAmount(value),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      prefixIcon: const Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: 14.0,
                          end: 6.0,
                        ),
                        child: Text(
                          '₦',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CustomFilledButton(
              text: 'Confirm',
              onPressed: disabled ? null : () => notifier.onConfirm(context),
            ),
          ],
        ),
      ),
    );
  }
}
