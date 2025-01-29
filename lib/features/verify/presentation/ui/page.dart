import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../components/animated_widgets.dart';
import '../../../../components/buttons.dart';
import '../../../../components/textfields.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/constants/texts.dart';
import '../../../../core/validators.dart';
import '../provider.dart';

class VerifyPage extends ConsumerStatefulWidget {
  const VerifyPage({super.key});

  static const routeName = '/verify';

  @override
  ConsumerState<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends ConsumerState<VerifyPage> {
  static final _pageText = AppTexts.verifyPage;
  final _idNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(verifyPageProvider);
    final notifier = ref.read(verifyPageProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text(_pageText.title.tr())),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Image.asset(AssetImages.pngs.search),
                    const SizedBox(height: 24.0),
                    Text(
                      _pageText.subtitle.tr(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    SelectionButton<IdType>(
                      labelText: _pageText.idType.tr(),
                      hintText: _pageText.idTypeHint.tr(),
                      initialValue: state.idType,
                      textBuilder: (value) => value?.trKey.tr(),
                      validator: (value) => Validator.name(value?.trKey.tr()),
                      onPressed: () => notifier.showIdTypeBottomSheet(context),
                    ),
                    CustomAnimatedSwitcher(
                      value: state.idType == IdType.standardNINSlip,
                      child: SignupTextField(
                        labelText: _pageText.idType.tr(),
                        controller: _idNumberController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: Validator.validatePhoneNumber,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              _pageText.footer.tr(),
              style: const TextStyle(
                color: Color(0xFF5E5E5E),
              ),
            ),
            const SizedBox(height: 24.0),
            CustomFilledButton(
              text: _pageText.verifyMyAccount.tr(),
              onPressed: () => notifier.onVerify(context),
            ),
          ],
        ),
      ),
    );
  }
}
