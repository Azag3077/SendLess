import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../components/textfields.dart';
import '../../../../../core/constants/texts.dart';
import '../../../../../core/extensions/string.dart';
import '../../../../../core/validators.dart';
import '../../provider.dart';

class CreatePasswordPageView extends ConsumerWidget {
  const CreatePasswordPageView({
    super.key,
    required this.formKey,
    required this.password1Controller,
    required this.password2Controller,
  });

  static final _pageText = AppTexts.signupPage.createPasswordPageView;

  final GlobalKey<FormState> formKey;
  final TextEditingController password1Controller;
  final TextEditingController password2Controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signupPageProvider);
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
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 24.0),
                  SignupTextField(
                    labelText: _pageText.passwordLabel.tr(),
                    hintText: _pageText.passwordHint.tr(),
                    textInputAction: TextInputAction.next,
                    controller: password1Controller,
                    obscureText: state.obscureText,
                    validator: Validator.password1,
                    suffixIcon: IconButton(
                      onPressed: notifier.toggleObscureText,
                      icon: Icon(
                        state.obscureText
                            ? CupertinoIcons.eye_slash
                            : CupertinoIcons.eye,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SignupTextField(
                    labelText: _pageText.confirmPasswordLabel.tr(),
                    hintText: _pageText.passwordHint.tr(),
                    textInputAction: TextInputAction.next,
                    controller: password2Controller,
                    obscureText: state.obscureText,
                    validator: (value) => Validator.password2(
                        value, password1Controller.text.trim()),
                    suffixIcon: IconButton(
                      onPressed: notifier.toggleObscureText,
                      icon: Icon(
                        state.obscureText
                            ? CupertinoIcons.eye_slash
                            : CupertinoIcons.eye,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Wrap(
                    spacing: 8.0,
                    children: <Widget>[
                      CustomChip(
                        text: _pageText.nCharacters.tr(),
                        isSelected: state.password.length >= 8,
                      ),
                      CustomChip(
                        text: _pageText.aNumber.tr(),
                        isSelected: state.password.hasDigit,
                      ),
                      CustomChip(
                        text: _pageText.anUppercaseLetter.tr(),
                        isSelected: state.password.hasUppercase,
                      ),
                      CustomChip(
                        text: _pageText.aLowercaseLetter.tr(),
                        isSelected: state.password.hasLowercase,
                      ),
                      CustomChip(
                        text: _pageText.aSpecialCharacters.tr(),
                        isSelected: state.password.hasSpecialCharacters,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    required this.text,
    required this.isSelected,
  });

  final String text;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(text),
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
      labelStyle: TextStyle(
        fontSize: 12.0,
        color: Colors.blueGrey.shade600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor:
          isSelected ? Theme.of(context).colorScheme.primaryContainer : null,
    );
  }
}
