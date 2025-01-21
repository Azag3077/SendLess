import 'package:country_state_city/models/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/bottom_sheet.dart';
import '../../../core/constants/constants.dart';
import '../../../core/constants/texts.dart';
import '../../../core/extensions/num_duration.dart';
import 'ui/components/country_bottom_sheet.dart';

final signupPageProvider = NotifierProvider<_Notifier, _State>(_Notifier.new);

class _State {
  _State({
    this.pageIndex = 0,
    this.country,
    this.gender,
  });

  final int pageIndex;
  final Country? country;
  final Gender? gender;

  _State copyWith({
    int? pageIndex,
    Country? country,
    Gender? gender,
  }) {
    return _State(
      pageIndex: pageIndex ?? this.pageIndex,
      country: country ?? this.country,
      gender: gender ?? this.gender,
    );
  }
}

class _Notifier extends Notifier<_State> {
  final _duration = 200.ms;
  final _curve = Curves.linear;
  PageController? _pageController;
  GlobalKey<FormState>? _page1FormKey;
  GlobalKey<FormState>? _page2FormKey;

  final _pageText = AppTexts.signupPage.basicInformation;

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
    }

    if (state.pageIndex == 1) {
      if (!_page1FormKey!.currentState!.validate()) return;
    }
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
          title: _pageText.genderHint.tr(),
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
}
