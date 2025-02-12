import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/routers/app_routes.dart';
import '../../airtime/presentation/ui/page.dart';

export 'package:flutter_riverpod/flutter_riverpod.dart';

final billsPaymentPageProvider = Provider((_) => _Provider());

class _Provider {
  void onAirtime(BuildContext context) =>
      pushNamed(context, AirtimePage.routeName);

  void onInternet(BuildContext context) =>
      pushNamed(context, AirtimePage.routeName);

  void onTv(BuildContext context) => pushNamed(context, AirtimePage.routeName);

  void onElectricity(BuildContext context) =>
      pushNamed(context, AirtimePage.routeName);
}
