import 'package:country_state_city/models/country.dart';

final kDefaultCountry = Country(
  name: 'Nigeria',
  isoCode: 'NG',
  phoneCode: '234',
  currency: 'NGN',
  flag: '🇳🇬',
  latitude: '10.00000000',
  longitude: '8.00000000',
);

const kDefaultSupportedCounties = ['NG', 'CA', 'US', 'GB'];

String kCountryFlag(String code) =>
    'https://flagcdn.com/w320/${code.toLowerCase()}.png';
