import 'package:flutter/material.dart';

import '../../../../components/buttons.dart';
import '../../../../core/constants/assets.dart';
import '../provider.dart';

class ReceiptPage extends ConsumerWidget {
  const ReceiptPage({super.key});

  static const routeName = '/receipt';
  static final _tableKey = GlobalKey();

  Widget _buildRow({
    required BuildContext context,
    required String label,
    required String text,
  }) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(label, style: textTheme.titleSmall),
          Text(text),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(receiptPageProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Receipt')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: RepaintBoundary(
                key: _tableKey,
                child: ColoredBox(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    margin: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Theme.of(context).primaryColor),
                    ),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 24.0),
                        Image.asset(AssetImages.pngs.splash, width: 48.0),
                        Text('\$500.00', style: textTheme.displaySmall),
                        Divider(color: Theme.of(context).primaryColor),
                        _buildRow(
                          context: context,
                          label: 'Transaction Type',
                          text: 'Money sent',
                        ),
                        _buildRow(
                          context: context,
                          label: 'Sender',
                          text: 'Divine ikemma',
                        ),
                        _buildRow(
                          context: context,
                          label: 'Sender Number',
                          text: '+1 375-373-3754',
                        ),
                        _buildRow(
                          context: context,
                          label: 'Recipient Name',
                          text: 'Chisom Nweke',
                        ),
                        _buildRow(
                          context: context,
                          label: 'Recipient Bank',
                          text: 'Vio Bank',
                        ),
                        _buildRow(
                          context: context,
                          label: 'Recipient Acct No',
                          text: '038765336542',
                        ),
                        _buildRow(
                          context: context,
                          label: 'Transfer fee',
                          text: '\$10',
                        ),
                        _buildRow(
                          context: context,
                          label: 'Exchange Rate',
                          text: '1 USD = 19.7400 MXN',
                        ),
                        _buildRow(
                          context: context,
                          label: 'Transfer Date',
                          text: '2024-06-17 13:43',
                        ),
                        _buildRow(
                          context: context,
                          label: 'Transaction ID',
                          text: '386753925293591635',
                        ),
                        const SizedBox(height: 64.0),
                        Divider(
                          height: 0.0,
                          thickness: 8.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomFilledButton(
              text: 'Share',
              onPressed: () => notifier.onShare(_tableKey),
            ),
          ),
        ],
      ),
    );
  }
}
