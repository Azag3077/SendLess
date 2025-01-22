import 'package:flutter/material.dart';

import '../../../../components/buttons.dart';
import '../../../../core/constants/texts.dart';
import '../provider.dart';
import 'components/page_indicator.dart';
import 'page_views/basic_information.dart';
import 'page_views/create_password.dart';
import 'page_views/verify_email.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  static const routeName = '/signup';

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  static final _pageText = AppTexts.signupPage;

  final _pageController = PageController();

  final _page1FormKey = GlobalKey<FormState>();
  final _firstnameController = TextEditingController();
  final _legalSurnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  final _page2FormKey = GlobalKey<FormState>();
  final _password1Controller = TextEditingController();
  final _password2Controller = TextEditingController();

  final _pinCodeController = TextEditingController();

  late final notifier = ref.read(signupPageProvider.notifier);

  @override
  void initState() {
    notifier.initialize(
      pageController: _pageController,
      page1FormKey: _page1FormKey,
      page2FormKey: _page2FormKey,
    );

    _firstnameController.addListener(_firstnameControllerListener);
    _legalSurnameController.addListener(_legalSurnameControllerListener);
    _emailController.addListener(_emailControllerListener);
    _phoneNumberController.addListener(_phoneNumberControllerListener);
    _password1Controller.addListener(_password1Listener);
    _pinCodeController.addListener(_pinCodeControllerListener);
    super.initState();
  }

  void _firstnameControllerListener() =>
      notifier.updateFirstnameText(_firstnameController.text.trim());

  void _legalSurnameControllerListener() =>
      notifier.updateLegalSurnameText(_legalSurnameController.text.trim());

  void _emailControllerListener() =>
      notifier.updateEmailText(_emailController.text.trim());

  void _phoneNumberControllerListener() =>
      notifier.updatePhoneNumberText(_phoneNumberController.text.trim());

  void _password1Listener() =>
      notifier.updatePasswordText(_password1Controller.text.trim());

  void _pinCodeControllerListener() =>
      notifier.updatePinCodeText(_pinCodeController.text.trim());

  @override
  void dispose() {
    _pageController.dispose();

    _firstnameController.dispose();
    _legalSurnameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();

    _password1Controller.dispose();
    _password2Controller.dispose();

    _pinCodeController.dispose();

    _firstnameController.removeListener(_firstnameControllerListener);
    _legalSurnameController.removeListener(_legalSurnameControllerListener);
    _emailController.removeListener(_emailControllerListener);
    _phoneNumberController.removeListener(_phoneNumberControllerListener);
    _password1Controller.removeListener(_password1Listener);
    _pinCodeController.removeListener(_pinCodeControllerListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signupPageProvider);
    final notifier = ref.read(signupPageProvider.notifier);

    return PopScope<bool>(
      canPop: state.pageIndex == 0,
      onPopInvokedWithResult: notifier.onPopInvokedWithResult,
      child: Scaffold(
        appBar: AppBar(
          title: PageIndicator(
            length: 3,
            currentIndex: state.pageIndex,
          ),
          actions: const <Widget>[SizedBox(width: 48.0)],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: notifier.onPageChanged,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  BasicInformationPageView(
                    formKey: _page1FormKey,
                    firstnameController: _firstnameController,
                    legalSurnameController: _legalSurnameController,
                    emailController: _emailController,
                    phoneNumberController: _phoneNumberController,
                  ),
                  CreatePasswordPageView(
                    formKey: _page2FormKey,
                    password1Controller: _password1Controller,
                    password2Controller: _password2Controller,
                  ),
                  VerifyEmailPageView(
                    email: _emailController.text.trim(),
                    controller: _pinCodeController,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: CustomFilledButton(
                onPressed: () => notifier.onNext(context),
                text: state.pageIndex != 2
                    ? _pageText.next.tr()
                    : _pageText.verifyAccount.tr(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
