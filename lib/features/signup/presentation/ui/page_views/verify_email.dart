import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../components/textfields.dart';
import '../../../../../core/constants/texts.dart';
import '../../../../../core/validators.dart';
import '../components/phone_number_field_prefix_button.dart';

class VerifyEmailPageView extends StatelessWidget {
  const VerifyEmailPageView({super.key});

  static final _pageText = AppTexts.signupPage.basicInformation;

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
            child: Column(
              children: <Widget>[
                const SizedBox(height: 24.0),
                SignupTextField(
                  labelText: _pageText.firstnameLabel.tr(),
                  hintText: _pageText.firstnameHint.tr(),
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  // controller: notifier.firstnameController,
                  validator: Validator.name,
                ),
                SignupTextField(
                  labelText: _pageText.legalSurnameLabel.tr(),
                  hintText: _pageText.legalSurnameHint.tr(),
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  // controller: notifier.lastnameController,
                  validator: Validator.name,
                ),
                SignupTextField(
                  labelText: _pageText.emailLabel.tr(),
                  hintText: _pageText.emailHint.tr(),
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  // controller: notifier.emailController,
                  validator: Validator.email,
                ),
                SignupTextField(
                  labelText: 'Phone Number',
                  // controller: notifier.phoneNumberController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: Validator.validatePhoneNumber,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  prefixIcon: PhoneNumberFieldPrefixButton(
                    // country: state.country,
                    // onCodeTap: () => notifier.onCodeTap(context),
                    onCodeTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
