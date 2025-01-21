import 'package:flutter/material.dart';

import '../../../../../components/textfields.dart';
import '../../../../../core/constants/texts.dart';
import '../../../../../core/validators.dart';

class CreatePasswordPageView extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: <Widget>[
          Text(
            _pageText.title.tr(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26.0,
            ),
          ),
          Expanded(
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
                    validator: Validator.name,
                  ),
                  SignupTextField(
                    labelText: _pageText.confirmPasswordLabel.tr(),
                    hintText: _pageText.passwordHint.tr(),
                    textInputAction: TextInputAction.next,
                    controller: password2Controller,
                    validator: Validator.name,
                  ),
                  Wrap(
                    spacing: 8.0,
                    children: <Widget>[
                      Chip(
                        label: Text(_pageText.nCharacters.tr()),
                        visualDensity: VisualDensity.compact,
                      ),
                      Chip(
                        label: Text(_pageText.aNumber.tr()),
                        visualDensity: VisualDensity.compact,
                      ),
                      Chip(
                        label: Text(_pageText.anUppercaseLetter.tr()),
                        visualDensity: VisualDensity.compact,
                      ),
                      Chip(
                        label: Text(_pageText.aLowercaseLetter.tr()),
                        visualDensity: VisualDensity.compact,
                      ),
                      Chip(
                        label: Text(_pageText.aSpecialCharacters.tr()),
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
