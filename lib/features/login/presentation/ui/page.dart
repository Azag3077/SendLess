import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../components/buttons.dart';
import '../../../../components/textfields.dart';
import '../../../../core/constants/texts.dart';
import '../../../../core/validators.dart';
import '../provider.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  static const routeName = '/login';
  static final _pageText = AppTexts.loginPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(loginPageProvider);

    return Scaffold(
      appBar: AppBar(title: Text(_pageText.title.tr())),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 24.0),
                    SignupTextField(
                      labelText: _pageText.enterPhoneOrEmail.tr(),
                      hintText: _pageText.enterPhoneOrEmail.tr(),
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      // controller: notifier.firstnameController,
                      validator: Validator.name,
                    ),
                    SignupTextField(
                      labelText: _pageText.passwordLabel.tr(),
                      hintText: _pageText.passwordHint.tr(),
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      // controller: notifier.lastnameController,
                      validator: Validator.name,
                    ),
                    TextButton(
                      onPressed: () => notifier.onForgotPassword(context),
                      child: Text(_pageText.forgotPassword.tr()),
                    ),
                  ],
                ),
              ),
            ),
            CustomFilledButton(
              text: _pageText.login.tr(),
              onPressed: () => notifier.onLogin(context),
            ),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}
