import 'package:flutter/material.dart';

import '../../provider.dart';

class CardDetailsContainer extends StatelessWidget {
  const CardDetailsContainer({
    super.key,
    required this.virtualCard,
    required this.onCopy,
  });

  final VirtualCard virtualCard;
  final Function(String text, String value) onCopy;

  Widget _buildChild({
    required BuildContext context,
    required String title,
    required String subtitle,
    bool useDivider = true,
  }) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(title),
          titleTextStyle:
              Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10.0),
          subtitle: Text(subtitle),
          trailing: IconButton(
            onPressed: () => onCopy(title, subtitle),
            style: IconButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            icon: Icon(
              Icons.copy,
              size: 18.0,
              color: Colors.blueGrey.shade400,
            ),
          ),
          contentPadding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
        ),
        if (useDivider) Divider(height: 0, color: Colors.grey.shade300),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1.4,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildChild(
              context: context,
              title: 'Card Name',
              subtitle: virtualCard.name,
            ),
            _buildChild(
              context: context,
              title: 'Card Number',
              subtitle: virtualCard.number.toString(),
            ),
            _buildChild(
              context: context,
              title: 'Expiry Date',
              subtitle: virtualCard.expiryDate.toString(),
            ),
            _buildChild(
              context: context,
              title: 'CVV',
              subtitle: virtualCard.cvv.toString(),
              useDivider: false,
            ),
          ],
        ),
      ),
    );
  }
}
