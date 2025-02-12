import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../components/buttons.dart';
import '../../../../components/textfields.dart';
import '../../../../core/validators.dart';
import '../provider.dart';

class ChangePinPage extends ConsumerWidget {
  const ChangePinPage({super.key});

  static const routeName = '/change-pin';
  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(changePinPageProvider);
    final notifier = ref.read(changePinPageProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Change Pin')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 24.0),
              SignupTextField(
                labelText: 'Old Pin',
                hintText: 'Input Old Pin',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: notifier.updateFieldText1,
                obscureText: state.obscureText1,
                validator: Validator.validatePin1,
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
                labelText: 'New Pin',
                hintText: 'Input New Pin',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: notifier.updateFieldText2,
                obscureText: state.obscureText2,
                validator: Validator.validatePin1,
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
                labelText: 'Confirm Pin',
                hintText: 'Confirm New Pin',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: notifier.updateFieldText3,
                obscureText: state.obscureText2,
                validator: (value) => Validator.validatePins(
                    [state.fieldText3, state.fieldText2]),
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
                  onPressed: () => notifier.onForgotPin(context),
                  child: const Text('Forgot Pin?'),
                ),
              ),
              const SizedBox(height: 8.0),
              const SizedBox(height: 48.0),
              CustomFilledButton(
                text: 'Change Pin',
                onPressed: () => notifier.onChangePin(context, _formKey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
