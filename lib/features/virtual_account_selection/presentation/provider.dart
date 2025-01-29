import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/dialogs.dart';
import '../../../core/constants/enums.dart';
import '../../../core/extensions/num_duration.dart';
import '../../../core/routers/router.dart';
import '../../dashboard/presentation/ui/page.dart';

export 'package:flutter_riverpod/flutter_riverpod.dart';

final facialRecognitionPageProvider =
    AutoDisposeNotifierProvider<_Notifier, AccountType?>(_Notifier.new);

class _Notifier extends AutoDisposeNotifier<AccountType?> {
  @override
  AccountType? build() => null;

  void update(AccountType? accountType) => state = accountType;

  Future<void> onSubmit(BuildContext context) async {
    showLoadingDialog(context);

    await Future.delayed(2.seconds);

    if (!context.mounted) return;

    pushNamedAndRemoveUntil(context, Dashboard.routeName);
  }
}
