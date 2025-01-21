import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../components/buttons.dart';
import '../../../../core/constants/texts.dart';
import '../provider.dart';
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

  @override
  void initState() {
    final notifier = ref.read(signupPageProvider.notifier);

    notifier.initialize(
      pageController: _pageController,
      page1FormKey: _page1FormKey,
      page2FormKey: _page2FormKey,
    );
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();

    _firstnameController.dispose();
    _legalSurnameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();

    _password1Controller.dispose();
    _password2Controller.dispose();
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
          title: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ]
          ),
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
                  VerifyEmailPageView(),
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
