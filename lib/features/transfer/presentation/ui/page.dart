import 'package:flutter/material.dart';

import '../../../../components/buttons.dart';
import '../../../../components/textfields.dart';
import '../../../../core/validators.dart';
import '../provider.dart';

class TransferPage extends ConsumerWidget {
  const TransferPage({super.key});

  static const routeName = '/transfer';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(transferPageProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Transfer')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
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
                    const SizedBox(height: 16.0),
                    SelectionButton<String>(
                      labelText: 'Select Bank',
                      hintText: 'Please select a bank',
                      // initialValue: '',
                      // textBuilder: (value) => value,
                      validator: Validator.name,
                      onPressed: () => notifier.showGenderBottomSheet(context),
                    ),
                    const SignupTextField(
                      labelText: 'Account Number',
                      hintText: 'Enter account number',
                    ),
                    const SignupTextField(
                      labelText: 'Account Name',
                      hintText: 'Enter account name',
                    ),
                    const SignupTextField(
                      labelText: 'Amount',
                      hintText: 'Enter amount',
                    ),
                    const SignupTextField(
                      labelText: 'Description (optional)',
                      hintText: 'Enter description',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Fee:', style: textTheme.titleMedium),
                        const Text('NGN0.00'),
                      ],
                    )
                  ],
                ),
              ),
            ),
            CustomFilledButton(
              text: 'Next',
              onPressed: () => notifier.onNext(context),
            ),
          ],
        ),
      ),
    );
  }
}
