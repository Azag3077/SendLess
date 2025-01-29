import 'package:flutter/material.dart';

import '../../../../components/buttons.dart';
import '../../../../core/constants/texts.dart';
import '../provider.dart';

class FacialRecognitionPage extends ConsumerWidget {
  const FacialRecognitionPage({super.key});

  static const routeName = '/facial_recognition';
  static final _pageText = AppTexts.facialRecognitionPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(facialRecognitionPageProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text(_pageText.title.tr())),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: <Widget>[
            Text(
              _pageText.subtitle.tr(),
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 32.0),
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),
            CustomFilledButton(
              text: _pageText.submit.tr(),
              onPressed: () => notifier.onSubmit(context),
            ),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}
