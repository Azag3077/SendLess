import 'package:flutter/material.dart';

import '../../../../components/buttons.dart';
import '../../../../core/constants/assets.dart';

class SuccessfulPageArg {
  const SuccessfulPageArg({
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onButtonPressed,
  });

  final String title;
  final String subtitle;
  final String buttonText;
  final ValueChanged<BuildContext> onButtonPressed;
}

class SuccessfulPage extends StatelessWidget {
  const SuccessfulPage({super.key});

  static const routeName = '/successful';

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as SuccessfulPageArg;

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.close),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 120.0),
                  Image.asset(AssetImages.pngs.success),
                  const SizedBox(height: 32.0),
                  Text(arg.title, style: textTheme.titleLarge),
                  const SizedBox(height: 8.0),
                  Text(arg.subtitle),
                ],
              ),
            ),
            CustomFilledButton(
              text: arg.buttonText,
              onPressed: () => arg.onButtonPressed(context),
            ),
            const SizedBox(height: 120.0),
          ],
        ),
      ),
    );
  }
}
