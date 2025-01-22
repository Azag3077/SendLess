import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/dialogs.dart';
import '../../../core/extensions/num_duration.dart';
import '../../../core/routers/router.dart';
import '../../../core/utils.dart';
import '../../facial_recognition/presentation/ui/page.dart';

export 'package:flutter_riverpod/flutter_riverpod.dart';

final createPinPageProvider =
    AutoDisposeNotifierProvider<_Notifier, _State>(_Notifier.new);

class _State {
  _State({
    this.pageIndex = 0,
    this.code = '',
    this.disableButton = true,
  });

  final int pageIndex;
  final String code;
  final bool disableButton;

  _State copyWith({
    int? pageIndex,
    String? code,
    bool? disableButton,
  }) {
    return _State(
      pageIndex: pageIndex ?? this.pageIndex,
      code: code ?? this.code,
      disableButton: disableButton ?? this.disableButton,
    );
  }
}

class _Notifier extends AutoDisposeNotifier<_State> {
  @override
  _State build() => _State();

  void onPopInvokedWithResult(TextEditingController controller) {
    log([state.pageIndex].toString());

    state = _State();
    controller.clear();
  }

  void onChanged(String code) {
    state = state.copyWith(
      disableButton: code.length != 4,
      code: state.pageIndex == 0 ? code : null,
    );
  }

  Future<void> onNext(
      BuildContext context, TextEditingController controller) async {
    if (state.pageIndex == 0) {
      state = state.copyWith(disableButton: true, pageIndex: 1);
      controller.clear();
      return;
    }

    final code = controller.text.trim();

    if (code != state.code) return showToast('Code mismatch');

    showLoadingDialog(context);

    await Future.delayed(1.5.seconds);

    if (!context.mounted) return;
    pop(context);

    pushReplacementNamed(context, FacialRecognitionPage.routeName);
  }
}
