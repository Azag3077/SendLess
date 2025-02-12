import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extensions/num_duration.dart';
import '../../signup/presentation/ui/components/country_bottom_sheet.dart';

export 'package:flutter_riverpod/flutter_riverpod.dart';

final convertPageProvider = Provider((_) => _Provider());

class _Provider {
  void onConvert(BuildContext context) {}

  Future<String?> showGenderBottomSheet(BuildContext context) async {
    // await showModalBottomSheet(
    //   context: context,
    //   builder: (_) {
    //     return CustomBottomSheet<String>(
    //       title: 'Select Bank',
    //       items: List.generate(23, (index) => 'Bank of Nigeria ${index + 1}'),
    //       onSelected: (gender) {},
    //       isLoading: false,
    //       // selected: state.gender,
    //       // buildText: (e) => e.trKey.tr(),
    //     );
    //   },
    // );

    showModalBottomSheet(
      context: context,
      clipBehavior: Clip.hardEdge,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      sheetAnimationStyle: AnimationStyle(
        duration: 700.ms,
      ),
      builder: (_) {
        return CountryBottomSheet(
          // selectedCountry: state.country,
          onSelected: (country) {},
        );
      },
    );

    return 'state.gender';
  }
}
