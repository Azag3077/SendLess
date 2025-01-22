import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/dialogs.dart';
import '../../../core/extensions/num_duration.dart';
import '../../../core/routers/router.dart';
import '../../../core/utils.dart';

export 'package:flutter_riverpod/flutter_riverpod.dart';

final facialRecognitionPageProvider =
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

  void onSubmit(BuildContext context) {}
}
