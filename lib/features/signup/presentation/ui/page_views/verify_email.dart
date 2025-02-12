import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../core/constants/texts.dart';
import '../../provider.dart';

class VerifyEmailPageView extends ConsumerWidget {
  const VerifyEmailPageView({
    super.key,
    required this.email,
    required this.controller,
  });

  final String email;
  final TextEditingController controller;

  static final _pageText = AppTexts.signupPage.verifyEmailPageView;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(signupPageProvider.notifier);

    return Column(
      children: <Widget>[
        Text(
          _pageText.title.tr(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26.0,
          ),
        ),
        const SizedBox(height: 24.0),
        Text(
          _pageText.subtitle.tr(args: [email]),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
            color: Colors.black.withValues(alpha: .89),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 48.0),
                PinCodeTextField(
                  appContext: context,
                  length: 4,
                  autoFocus: true,
                  controller: controller,
                  cursorColor: Theme.of(context).primaryColor,
                  keyboardType: TextInputType.number,
                  errorTextSpace: 0,
                  autoDisposeControllers: false,
                  mainAxisAlignment: MainAxisAlignment.center,
                  separatorBuilder: (_, __) => const SizedBox(width: 14.0),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onCompleted: (_) => notifier.onVerifyAccount(context),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    fieldWidth: 48.0,
                    fieldHeight: 56.0,
                    activeFillColor: Colors.white,
                    activeColor: Theme.of(context).primaryColor.withAlpha(150),
                    inactiveColor: Colors.grey.shade400,
                    selectedColor: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                const SizedBox(height: 24.0),
                TextButton(
                  onPressed: () => notifier.resendCode(context),
                  child: Text(
                    _pageText.resendCode.tr(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
