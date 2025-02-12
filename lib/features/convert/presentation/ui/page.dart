import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../components/buttons.dart';
import '../../../../components/textfields.dart';
import '../../../../core/validators.dart';
import '../provider.dart';

class ConvertPage extends ConsumerWidget {
  const ConvertPage({super.key});

  static const routeName = '/convert';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(convertPageProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Convert')),
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
                      labelText: 'Choose your currency',
                      hintText: 'Select currency',
                      validator: Validator.name,
                      onPressed: () => notifier.showGenderBottomSheet(context),
                    ),
                    SignupTextField(
                      labelText: 'Amount',
                      hintText: 'Enter amount',
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    Container(
                      margin: const EdgeInsets.all(12.0),
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.refresh, color: Colors.white),
                    ),
                    const SizedBox(height: 8.0),
                    SelectionButton<String>(
                      labelText: 'Choose your currency',
                      hintText: 'Select currency',
                      validator: Validator.name,
                      onPressed: () => notifier.showGenderBottomSheet(context),
                    ),
                  ],
                ),
              ),
            ),
            CustomFilledButton(
              text: 'Convert',
              onPressed: () => notifier.onConvert(context),
            ),
          ],
        ),
      ),
    );
  }
}
