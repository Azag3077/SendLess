import 'package:flutter/material.dart';

import '../../../../../core/constants/assets.dart';

class SendTypeView extends StatelessWidget {
  const SendTypeView({
    super.key,
    required this.onBox1,
    required this.onBox2,
  });

  final VoidCallback onBox1;
  final VoidCallback onBox2;

  Widget _buildContainerButton({
    required BuildContext context,
    required String title,
    required String subtitle,
    bool showImage = true,
    required VoidCallback onPressed,
  }) {
    final bgColor = showImage ? Colors.white : Theme.of(context).primaryColor;
    final fgColor = showImage ? Colors.black : Colors.white;

    return Container(
      height: 200.0,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.0),
        border: showImage
            ? Border.all(
                color: Theme.of(context).primaryColor,
                width: 2.0,
              )
            : null,
        image: DecorationImage(
          image: AssetImage(AssetImages.pngs.rectangle),
          alignment: Alignment.topRight,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 5.0,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: MaterialButton(
        onPressed: onPressed,
        padding: const EdgeInsets.all(24.0),
        elevation: 0.0,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: fgColor),
              ),
              const SizedBox(height: 8.0),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: fgColor),
              ),
              if (showImage) ...[
                const SizedBox(height: 8.0),
                Image.asset(
                  AssetImages.pngs.splash,
                  width: 48.0,
                  height: 48.0,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          _buildContainerButton(
            context: context,
            title: 'Send to SendLess wallet',
            subtitle: 'Send Money to any Swift Wallet account',
            onPressed: onBox1,
          ),
          const SizedBox(height: 24.0),
          _buildContainerButton(
            context: context,
            title: 'Send to via bank transfer',
            subtitle: 'use bank transfer to send '
                'money to a previous or new recipient',
            showImage: false,
            onPressed: onBox2,
          ),
        ],
      ),
    );
  }
}
