import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../components/dialogs.dart';
import '../../../core/extensions/num_duration.dart';
import '../../../core/routers/router.dart';
import '../../create_pin/presentation/ui/components/keyboard.dart';
import '../../dashboard/presentation/ui/page.dart';
import '../../receipt/presentation/ui/page.dart';
import '../../successful/presentation/ui/page.dart';

export 'package:flutter_riverpod/flutter_riverpod.dart';

final sendPageProvider =
    AutoDisposeNotifierProvider<_Notifier, _State>(_Notifier.new);

enum SendType { viaApp, viaBank }

class _State {
  const _State({
    this.pageIndex = 0,
    this.type,
    this.username = '',
  });

  final SendType? type;
  final String username;
  final int pageIndex;

  _State copyWith({
    SendType? type,
    String? username,
    int? pageIndex,
  }) {
    return _State(
      type: type ?? this.type,
      username: username ?? this.username,
      pageIndex: pageIndex ?? this.pageIndex,
    );
  }
}

class _Notifier extends AutoDisposeNotifier<_State> {
  final _duration = 200.ms;
  final _curve = Curves.linear;

  @override
  _State build() => const _State();

  void onBackButton(PageController controller) =>
      controller.previousPage(duration: _duration, curve: _curve);

  void onPageChanged(int index) => state = state.copyWith(pageIndex: index);

  void onType(PageController controller, SendType type) {
    state = state.copyWith(type: type);
    controller.nextPage(duration: _duration, curve: _curve);
  }

  void updateUsername(String value) => state = state.copyWith(username: value);

  void onActionButton(BuildContext context, PageController controller) {
    if (state.pageIndex != 3) {
      controller.nextPage(duration: _duration, curve: _curve);
      return;
    }

    final pinController = TextEditingController();

    Future<void> onComplete(String value) async {
      pop(context);
      showLoadingDialog(context);

      Future.delayed(200.ms, pinController.dispose);

      await Future.delayed(1.5.seconds);

      if (!context.mounted) return;
      pushNamedAndRemoveUntil(
        context,
        SuccessfulPage.routeName,
        until: Dashboard.routeName,
        arguments: SuccessfulPageArg(
          title: 'Success!!!',
          subtitle: 'Your payment has been successfully',
          buttonText: 'Share Receipt',
          onButtonPressed: (context) =>
              pushReplacementNamed(context, ReceiptPage.routeName),
        ),
      );
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Azag(
          onComplete: onComplete,
          controller: pinController,
        );
      },
    );
  }
}

class Azag extends StatelessWidget {
  const Azag({
    super.key,
    required this.onComplete,
    required this.controller,
  });

  final TextEditingController controller;

  final ValueChanged<String> onComplete;

  void _onChanged(String value) {
    if (value.length == 4) onComplete(value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            'Enter Payment Pin',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 24.0),
          PinCodeTextField(
            appContext: context,
            length: 4,
            autoFocus: true,
            controller: controller,
            cursorColor: Theme.of(context).primaryColor,
            keyboardType: TextInputType.none,
            errorTextSpace: 0,
            autoDisposeControllers: false,
            mainAxisAlignment: MainAxisAlignment.center,
            separatorBuilder: (_, __) => const SizedBox(width: 14.0),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: _onChanged,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              fieldWidth: 48.0,
              fieldHeight: 56.0,
              activeFillColor: Colors.white,
              activeColor: Theme.of(context).primaryColor.withAlpha(150),
              inactiveColor: Colors.grey.shade400,
              selectedColor: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          const SizedBox(height: 64.0),
          ButtonsGrid(controller: controller),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }
}
