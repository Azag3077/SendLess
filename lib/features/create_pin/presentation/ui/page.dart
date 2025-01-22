import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../components/buttons.dart';
import '../../../../core/constants/texts.dart';
import '../provider.dart';
import 'components/keyboard.dart';

class CreatePinPage extends ConsumerStatefulWidget {
  const CreatePinPage({super.key});

  static const routeName = '/create_pin';

  @override
  ConsumerState<CreatePinPage> createState() => _CreatePinPageState();
}

class _CreatePinPageState extends ConsumerState<CreatePinPage> {
  final _pageText = AppTexts.createPinPage;
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(createPinPageProvider);
    final notifier = ref.read(createPinPageProvider.notifier);

    return PopScope(
      canPop: state.pageIndex == 0,
      onPopInvokedWithResult: (_, __) =>
          notifier.onPopInvokedWithResult(_controller),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            state.pageIndex == 0
                ? _pageText.title1.tr()
                : _pageText.title2.tr(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: <Widget>[
              Text(
                _pageText.subtitle.tr(),
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 48.0),
                    PinCodeTextField(
                      appContext: context,
                      length: 4,
                      autoFocus: true,
                      controller: _controller,
                      cursorColor: Theme.of(context).primaryColor,
                      keyboardType: TextInputType.none,
                      errorTextSpace: 0,
                      autoDisposeControllers: false,
                      mainAxisAlignment: MainAxisAlignment.center,
                      separatorBuilder: (_, __) => const SizedBox(width: 14.0),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: notifier.onChanged,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        fieldWidth: 48.0,
                        fieldHeight: 56.0,
                        activeFillColor: Colors.white,
                        activeColor:
                            Theme.of(context).primaryColor.withAlpha(150),
                        inactiveColor: Colors.grey.shade400,
                        selectedColor: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                  ],
                ),
              ),
              CustomFilledButton(
                text: state.pageIndex == 0
                    ? _pageText.next.tr()
                    : _pageText.done.tr(),
                onPressed: state.disableButton
                    ? null
                    : () => notifier.onNext(context, _controller),
              ),
              const SizedBox(height: 24.0),
              ButtonsGrid(controller: _controller),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    );
  }
}
