export 'package:easy_localization/easy_localization.dart';

enum Gender {
  male,
  female;

  String get trKey => 'genderEnum.$name';
}

enum IDTypes {
  standardNINSlip,
  premiumNINSlip,
  nationalIDCard,
  nationalPassport,
  driversLicense;

  String get trKey => 'verifyPage.idTypes.$name';

  String get hintTrKey => 'verifyPage.idTypes.$name.hint';
}

enum AccountTypes {
  savingsAccount,
  checkingAccount,
  businessAccount,
  studentAccount;

  String get trKey => 'virtualAccountSelectionPage.accountTypes.$name.name';

  String get hintTrKey => 'virtualAccountSelectionPage.accountTypes.$name.hint';
}
