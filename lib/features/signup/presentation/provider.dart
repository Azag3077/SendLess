import 'package:country_state_city/models/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/bottom_sheet.dart';
import '../../../components/dialogs.dart';
import '../../../core/constants/constants.dart';
import '../../../core/constants/enums.dart';
import '../../../core/constants/texts.dart';
import '../../../core/extensions/num_duration.dart';
import '../../../core/routers/router.dart';
import '../../../core/utils.dart';
import '../../create_pin/presentation/ui/page.dart';
import 'ui/components/country_bottom_sheet.dart';

export 'package:flutter_riverpod/flutter_riverpod.dart';

final signupPageProvider =
    AutoDisposeNotifierProvider<_Notifier, _State>(_Notifier.new);

class _State {
  _State({
    this.pageIndex = 0,
    this.country,
    this.gender,
    this.obscureText = true,
    this.firstname = '',
    this.legalSurname = '',
    this.email = '',
    this.phoneNumber = '',
    this.password = '',
    this.pinCode = '',
  });

  final int pageIndex;
  final Country? country;
  final Gender? gender;
  final bool obscureText;
  final String firstname;
  final String legalSurname;
  final String email;
  final String phoneNumber;
  final String password;
  final String pinCode;

  _State copyWith({
    int? pageIndex,
    Country? country,
    Gender? gender,
    bool? obscureText,
    String? firstname,
    String? legalSurname,
    String? email,
    String? phoneNumber,
    String? password,
    String? pinCode,
  }) {
    return _State(
      pageIndex: pageIndex ?? this.pageIndex,
      country: country ?? this.country,
      gender: gender ?? this.gender,
      obscureText: obscureText ?? this.obscureText,
      firstname: firstname ?? this.firstname,
      legalSurname: legalSurname ?? this.legalSurname,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      pinCode: pinCode ?? this.pinCode,
    );
  }
}

class _Notifier extends AutoDisposeNotifier<_State> {
  final _duration = 200.ms;
  final _curve = Curves.linear;
  PageController? _pageController;
  GlobalKey<FormState>? _page1FormKey;
  GlobalKey<FormState>? _page2FormKey;

  final _pageText = AppTexts.signupPage;

  @override
  _State build() => _State(country: kDefaultCountry);

  void initialize({
    required PageController pageController,
    required GlobalKey<FormState> page1FormKey,
    required GlobalKey<FormState> page2FormKey,
  }) {
    _pageController = pageController;
    _page1FormKey = page1FormKey;
    _page2FormKey = page2FormKey;
  }

  void onPopInvokedWithResult(bool didPop, bool? result) =>
      _pageController?.previousPage(duration: _duration, curve: _curve);

  void onPageChanged(int index) => state = state.copyWith(pageIndex: index);

  void onNext(BuildContext context) {
    if ((state.pageIndex == 0 && _page1FormKey!.currentState!.validate()) ||
        (state.pageIndex == 1 && _page2FormKey!.currentState!.validate())) {
      _pageController?.nextPage(duration: _duration, curve: _curve);
      return;
    }

    if (state.pinCode.length != 4) {
      return showToast(
        _pageText.verifyEmailPageView.subtitle.tr(args: [state.email]),
      );
    }

    onVerifyAccount(context);
  }

  void onCodeTap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      clipBehavior: Clip.hardEdge,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      sheetAnimationStyle: AnimationStyle(
        duration: 700.milliseconds,
      ),
      builder: (_) {
        return CountryBottomSheet(
          selectedCountry: state.country,
          onSelected: (country) => state = state.copyWith(country: country),
        );
      },
    );
  }

  Future<Gender?> showGenderBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (_) {
        return CustomBottomSheet<Gender>(
          title: _pageText.basicInformation.genderHint.tr(),
          items: Gender.values,
          onSelected: (gender) => state = state.copyWith(gender: gender),
          isLoading: false,
          selected: state.gender,
          buildText: (e) => e.trKey.tr(),
        );
      },
    );

    return state.gender;
  }

  void toggleObscureText() =>
      state = state.copyWith(obscureText: !state.obscureText);

  void updatePasswordText(String password) =>
      state = state.copyWith(password: password);

  void updateFirstnameText(String text) =>
      state = state.copyWith(firstname: text);

  void updateLegalSurnameText(String text) =>
      state = state.copyWith(legalSurname: text);

  void updateEmailText(String text) => state = state.copyWith(email: text);

  void updatePhoneNumberText(String text) =>
      state = state.copyWith(phoneNumber: text);

  void updatePinCodeText(String text) => state = state.copyWith(pinCode: text);

  void resendCode(BuildContext context) {}

  Future<void> onVerifyAccount(BuildContext context) async {
    showLoadingDialog(context);

    await Future.delayed(1.5.seconds);

    if (!context.mounted) return;
    pop(context);

    // TODO: API Integration point.
    // Make request to the API and check if response is successful.
    if (true == false) return showToast('Error occurred');

    // pushReplacementNamed(context, CreatePinPage.routeName);
    pushNamed(context, CreatePinPage.routeName);
  }
}
