import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/buttons.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/texts.dart';
import 'provider.dart';

class OnboardingPage extends ConsumerWidget {
  const OnboardingPage({super.key});

  static const routeName = '/onboarding';
  static final _pageText = AppTexts.onboardingPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(onboardingPageProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.bottomCenter,
            image: AssetImage(AssetImages.pngs.onboarding),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _pageText.heading.tr(),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 26.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              _pageText.subheading.tr(),
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            CustomFilledButton(
              text: _pageText.callToAction.tr(),
              onPressed: () => notifier.onGetStarted(context),
            ),
            const SizedBox(height: 8.0),
            Center(
              child: TextButton(
                onPressed: () => notifier.onLogin(context),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: _pageText.alreadyHaveAnAccount.tr(),
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    children: <InlineSpan>[
                      WidgetSpan(
                        child: IntrinsicWidth(
                          child: Column(
                            children: <Widget>[
                              Text(
                                _pageText.login.tr(),
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).primaryColor,
                                  height: 1.0,
                                ),
                              ),
                              Divider(
                                color: Theme.of(context).primaryColor,
                                height: 2.0,
                                thickness: 2.0,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
