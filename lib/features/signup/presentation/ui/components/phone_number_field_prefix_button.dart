import 'package:country_state_city/models/country.dart';
import 'package:flutter/material.dart';

class PhoneNumberFieldPrefixButton extends StatelessWidget {
  const PhoneNumberFieldPrefixButton({
    super.key,
    this.country,
    this.isFocused = false,
    required this.onCodeTap,
  });

  final Country? country;
  final bool isFocused;
  final VoidCallback onCodeTap;

  String? get phoneCode {
    if (country == null) return null;
    if (country!.phoneCode.startsWith('+')) {
      return country!.phoneCode;
    }
    return '+${country!.phoneCode}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: MaterialButton(
        onPressed: onCodeTap,
        minWidth: 0.0,
        elevation: 0.0,
        height: 48.0,
        color: Colors.black.withValues(alpha: .15),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.horizontal(
            start: Radius.circular(8.0),
          ),
        ),
        padding: const EdgeInsets.only(left: 8.0, right: 4.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (country != null) ...[
              Text(
                country!.flag,
                style: const TextStyle(fontSize: 18.0),
              ),
              const SizedBox(width: 4.0),
            ],
            Text(
              phoneCode ?? '',
              style: TextStyle(
                fontWeight: isFocused ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
            const Icon(
              Icons.expand_more,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
