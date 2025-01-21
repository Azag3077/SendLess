import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/texts.dart';
import 'provider.dart';

class OnboardingPage2 extends ConsumerWidget {
  const OnboardingPage2({super.key});

  static const routeName = '/onboarding2';
  static final _pageText = AppTexts.onboardingPage2;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(onboarding2PageProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: <Widget>[
              const Spacer(),
              Image.asset(AssetImages.png.money),
              Text(
                _pageText.heading.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 48.0),
              Text(
                _pageText.subheading.tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('1/1'),
                  TextButton(
                    onPressed: () => notifier.onNext(context),
                    child: Row(
                      children: <Widget>[
                        Text(_pageText.callToAction.tr()),
                        const SizedBox(width: 4.0),
                        const Icon(
                          Icons.keyboard_double_arrow_right,
                          size: 24.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
