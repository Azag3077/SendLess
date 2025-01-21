import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/routers/router.dart';
import '../../signup/presentation/ui/page.dart';

final onboarding2PageProvider = Provider<_Provider>((_) => _Provider());

class _Provider {
  void onNext(BuildContext context) => pushNamed(context, SignupPage.routeName);
}
