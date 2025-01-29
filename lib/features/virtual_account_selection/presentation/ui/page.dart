import 'package:flutter/material.dart';

import '../../../../components/buttons.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/constants/texts.dart';
import '../provider.dart';

class VirtualAccountSelectionPage extends ConsumerWidget {
  const VirtualAccountSelectionPage({super.key});

  static const routeName = '/virtual_account_selection';
  static final _pageText = AppTexts.virtualAccountSelectionPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountType = ref.watch(facialRecognitionPageProvider);
    final notifier = ref.read(facialRecognitionPageProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text(_pageText.heading.tr())),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _pageText.title.tr(),
                      style: const TextStyle(
                        fontSize: 19.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF2E324B),
                      ),
                    ),
                    const SizedBox(height: 18.0),
                    Text(
                      _pageText.subtitle.tr(),
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF43475D),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    ...AccountType.values.map((type) {
                      return CheckboxButton(
                        title: type.trKey.tr(),
                        subtitle: type.hintTrKey.tr(),
                        selected: accountType == type,
                        onSelected: () => notifier.update(type),
                      );
                    }),
                  ],
                ),
              ),
            ),
            CustomFilledButton(
              text: _pageText.done.tr(),
              onPressed:
                  accountType == null ? null : () => notifier.onSubmit(context),
            ),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}
