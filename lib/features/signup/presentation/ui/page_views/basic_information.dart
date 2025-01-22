import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../components/buttons.dart';
import '../../../../../components/textfields.dart';
import '../../../../../core/constants/enums.dart';
import '../../../../../core/constants/texts.dart';
import '../../../../../core/validators.dart';
import '../../provider.dart';
import '../components/phone_number_field_prefix_button.dart';

class BasicInformationPageView extends ConsumerWidget {
  const BasicInformationPageView({
    super.key,
    required this.formKey,
    required this.firstnameController,
    required this.legalSurnameController,
    required this.emailController,
    required this.phoneNumberController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController firstnameController;
  final TextEditingController legalSurnameController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;

  static final _pageText = AppTexts.signupPage.basicInformation;

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
                children: <Widget>[
                  const SizedBox(height: 24.0),
                  SignupTextField(
                    labelText: _pageText.firstnameLabel.tr(),
                    hintText: _pageText.firstnameHint.tr(),
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    controller: firstnameController,
                    validator: Validator.name,
                  ),
                  SignupTextField(
                    labelText: _pageText.legalSurnameLabel.tr(),
                    hintText: _pageText.legalSurnameHint.tr(),
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    controller: legalSurnameController,
                    validator: Validator.name,
                  ),
                  SignupTextField(
                    labelText: _pageText.emailLabel.tr(),
                    hintText: _pageText.emailHint.tr(),
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    controller: emailController,
                    validator: Validator.email,
                  ),
                  SignupTextField(
                    labelText: _pageText.phoneNumber.tr(),
                    controller: phoneNumberController,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: Validator.validatePhoneNumber,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    prefixIcon: PhoneNumberFieldPrefixButton(
                      country: state.country,
                      onCodeTap: () => notifier.onCodeTap(context),
                    ),
                  ),
                  SelectionButton<Gender>(
                    labelText: _pageText.genderLabel.tr(),
                    hintText: _pageText.genderHint.tr(),
                    initialValue: state.gender,
                    textBuilder: (gender) => gender?.trKey.tr(),
                    validator: (value) => Validator.name(value?.trKey.tr()),
                    onPressed: () => notifier.showGenderBottomSheet(context),
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
