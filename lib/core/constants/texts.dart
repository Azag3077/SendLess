export 'package:easy_localization/easy_localization.dart';

class AppTexts {
  static final onboardingPage = _OnboardingPage();
  static final onboardingPage2 = _OnboardingPage2();
  static final loginPage = _LoginPage();
  static final signupPage = _SignupPage();
  static final createPinPage = _CreatePinPage();
  static final facialRecognitionPage = _FacialRecognitionPage();
  static final verifyPage = _VerifyPage();
  static final virtualAccountSelectionPage = _VirtualAccountSelectionPage();
  static final dashboard = _Dashboard();
  static final homePage = _HomePage();
}

class _OnboardingPage {
  static const _ = 'onboardingPage';
  final heading = '$_.heading';
  final subheading = '$_.subheading';
  final callToAction = '$_.callToAction';
  final alreadyHaveAnAccount = '$_.alreadyHaveAnAccount';
  final login = '$_.login';
}

class _OnboardingPage2 {
  static const _ = 'onboardingPage2';
  final heading = '$_.heading';
  final subheading = '$_.subheading';
  final callToAction = '$_.callToAction';
}

class _LoginPage {
  static const _ = 'loginPage';
  final title = '$_.title';
  final enterPhoneOrEmail = '$_.enterPhoneOrEmail';
  final passwordLabel = '$_.passwordLabel';
  final passwordHint = '$_.passwordHint';
  final forgotPassword = '$_.forgotPassword';
  final login = '$_.login';
}

class _SignupPageView1 {
  static const _ = 'signupPage.basicInformationPageView';
  final title = '$_.title';
  final firstnameLabel = '$_.firstnameLabel';
  final firstnameHint = '$_.firstnameHint';
  final legalSurnameLabel = '$_.legalSurnameLabel';
  final legalSurnameHint = '$_.legalSurnameHint';
  final emailLabel = '$_.emailLabel';
  final emailHint = '$_.emailHint';
  final phoneNumber = '$_.phoneNumber';
  final genderLabel = '$_.genderLabel';
  final genderHint = '$_.genderHint';

  final next = '$_.next';
  final verifyAccount = '$_.verifyAccount';
}

class _SignupPageView2 {
  static const _ = 'signupPage.createPasswordPageView';
  final title = '$_.title';
  final passwordLabel = '$_.passwordLabel';
  final passwordHint = '$_.passwordHint';
  final confirmPasswordLabel = '$_.confirmPasswordLabel';
  final nCharacters = '$_.nCharacters';
  final anUppercaseLetter = '$_.anUppercaseLetter';
  final aLowercaseLetter = '$_.aLowercaseLetter';
  final aSpecialCharacters = '$_.aSpecialCharacters';
  final aNumber = '$_.aNumber';
  final termsAndCondition = '$_.termsAndCondition';
}

class _SignupPageView3 {
  static const _ = 'signupPage.verifyEmailPageView';
  final title = '$_.title';
  final subtitle = '$_.subtitle';
  final resendCode = '$_.resendCode';
}

class _SignupPage {
  static const _ = 'signupPage';
  final basicInformation = _SignupPageView1();
  final createPasswordPageView = _SignupPageView2();
  final verifyEmailPageView = _SignupPageView3();

  final next = '$_.next';
  final verifyAccount = '$_.verifyAccount';
}

class _CreatePinPage {
  static const _ = 'createPinPage';
  final title1 = '$_.title1';
  final title2 = '$_.title2';
  final subtitle = '$_.subtitle';
  final next = '$_.next';
  final done = '$_.done';
}

class _FacialRecognitionPage {
  static const _ = 'facialRecognitionPage';
  final title = '$_.title';
  final subtitle = '$_.subtitle';
  final submit = '$_.submit';
}

class _VerifyPage {
  static const _ = 'verifyPage';
  final title = '$_.title';
  final subtitle = '$_.subtitle';
  final idType = '$_.idType';
  final idTypeHint = '$_.idTypeHint';
  final footer = '$_.footer';
  final verifyMyAccount = '$_.verifyMyAccount';
}

class _VirtualAccountSelectionPage {
  static const _ = 'virtualAccountSelectionPage';
  final heading = '$_.heading';
  final title = '$_.title';
  final subtitle = '$_.subtitle';
  final done = '$_.done';
}

class _Dashboard {
  static const _ = 'dashboard';
  final home = '$_.home';
  final card = '$_.card';
  final bills = '$_.bills';
  final profile = '$_.profile';
}

class _HomePage {
  static const _ = 'homePage';
  final welcomeTitle = '$_.welcomeTitle';
  final addMoney = '$_.addMoney';
  final send = '$_.send';
  final convert = '$_.convert';
  final transfer = '$_.transfer';
  final cashOut = '$_.cashOut';
  final recentTransaction = '$_.recentTransaction';
  final seeAll = '$_.seeAll';
  final swiperTitle = '$_.swiperTitle';
  final swiperSubtitle = '$_.swiperSubtitle';
}
