import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../components/textfields.dart';
import '../../../../../core/validators.dart';
import '../../../../components/buttons.dart';
import '../../../../core/constants/texts.dart';
import '../../../../core/extensions/string.dart';
import '../provider.dart';

class ChangePasswordPage extends ConsumerWidget {
  const ChangePasswordPage({super.key});

  static const routeName = '/change-password';
  static final _pageText = AppTexts.signupPage.createPasswordPageView;
  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(changePasswordPageProvider);
    final notifier = ref.read(changePasswordPageProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Change Password')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 24.0),
              SignupTextField(
                labelText: 'Old Password',
                hintText: 'Input Old Password',
                textInputAction: TextInputAction.next,
                onChanged: notifier.updateFieldText1,
                obscureText: state.obscureText1,
                validator: Validator.validateLoginPassword,
                suffixIcon: IconButton(
                  onPressed: notifier.toggleObscureText1,
                  icon: Icon(
                    state.obscureText1
                        ? CupertinoIcons.eye_slash
                        : CupertinoIcons.eye,
                    color: Colors.grey,
                  ),
                ),
              ),
              SignupTextField(
                labelText: 'New Password',
                hintText: 'Input New Password',
                textInputAction: TextInputAction.next,
                onChanged: notifier.updateFieldText2,
                obscureText: state.obscureText2,
                validator: Validator.password1,
                suffixIcon: IconButton(
                  onPressed: notifier.toggleObscureText2,
                  icon: Icon(
                    state.obscureText2
                        ? CupertinoIcons.eye_slash
                        : CupertinoIcons.eye,
                    color: Colors.grey,
                  ),
                ),
              ),
              SignupTextField(
                labelText: 'Confirm Password',
                hintText: 'Confirm New Password',
                textInputAction: TextInputAction.next,
                onChanged: notifier.updateFieldText3,
                obscureText: state.obscureText2,
                validator: (value) =>
                    Validator.password2(value, state.fieldText2),
                suffixIcon: IconButton(
                  onPressed: notifier.toggleObscureText2,
                  icon: Icon(
                    state.obscureText2
                        ? CupertinoIcons.eye_slash
                        : CupertinoIcons.eye,
                    color: Colors.grey,
                  ),
                ),
                margin: EdgeInsets.zero,
              ),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: () => notifier.onForgotPassword(context),
                  child: const Text('Forgot Password?'),
                ),
              ),
              const SizedBox(height: 8.0),
              Wrap(
                spacing: 8.0,
                children: <Widget>[
                  CustomChip(
                    text: _pageText.nCharacters.tr(),
                    isSelected: state.fieldText2.length >= 8,
                  ),
                  CustomChip(
                    text: _pageText.aNumber.tr(),
                    isSelected: state.fieldText2.hasDigit,
                  ),
                  CustomChip(
                    text: _pageText.anUppercaseLetter.tr(),
                    isSelected: state.fieldText2.hasUppercase,
                  ),
                  CustomChip(
                    text: _pageText.aLowercaseLetter.tr(),
                    isSelected: state.fieldText2.hasLowercase,
                  ),
                  CustomChip(
                    text: _pageText.aSpecialCharacters.tr(),
                    isSelected: state.fieldText2.hasSpecialCharacters,
                  ),
                ],
              ),
              const SizedBox(height: 48.0),
              CustomFilledButton(
                text: 'Change Password',
                onPressed: () => notifier.onChangePassword(context, _formKey),
              ),
            ],
          ),
        ),
      ),
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
