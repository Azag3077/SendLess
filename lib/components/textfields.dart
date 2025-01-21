import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/extensions/num_duration.dart';

class SignupTextField extends StatelessWidget {
  const SignupTextField({
    super.key,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    required this.labelText,
    this.hintText,
    this.errorText,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    EdgeInsets? margin,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.obscuringCharacter = '*',
    this.textCapitalization = TextCapitalization.none,
    this.isValidated = false,
    bool readOnly = false,
    this.onTap,
    this.radius = 8.0,
    this.canRequestFocus = true,
    this.maxLength,
  }) : margin = margin ?? const EdgeInsets.only(bottom: 16.0);
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String labelText;
  final String? hintText;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final EdgeInsets margin;
  final bool obscureText;
  final String obscuringCharacter;
  final TextCapitalization textCapitalization;
  final bool isValidated;
  final GestureTapCallback? onTap;
  final double radius;
  final bool canRequestFocus;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: FormField<String>(
        validator: validator,
        initialValue: controller?.text,
        builder: (FormFieldState<String> state) {
          final showError = state.hasError && state.errorText != null;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 2.0, bottom: 8.0),
                child: Text(
                  labelText,
                  style: TextStyle(
                    color: Colors.black.withValues(alpha: .89),
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
              ),
              TextField(
                controller: controller,
                keyboardType: keyboardType,
                textInputAction: textInputAction,
                inputFormatters: inputFormatters,
                obscureText: obscureText,
                obscuringCharacter: obscuringCharacter,
                textCapitalization: textCapitalization,
                canRequestFocus: canRequestFocus,
                maxLength: maxLength,
                onChanged: (value) => _onChanged(value, state),
                onSubmitted: (_) => _onSubmitted(state),
                onTapOutside: (_) => _onTapOutside(),
                onTap: () => _onTap(context, state),
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                ),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius),
                    borderSide: BorderSide(
                      color: Colors.black.withValues(alpha: .3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 1.5,
                    ),
                  ),
                  prefixIcon: prefixIcon,
                  suffixIcon: suffixIcon,
                  prefixIconConstraints: const BoxConstraints(),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                ),
              ),
              AnimatedSwitcher(
                duration: 300.ms,
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeInOut,
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SizeTransition(
                      sizeFactor: animation,
                      child: child,
                    ),
                  );
                },
                child: showError
                    ? Padding(
                        key: ValueKey<bool>(showError),
                        padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.error,
                              size: 16.0,
                              color: Theme.of(context).colorScheme.error,
                            ),
                            const SizedBox(width: 4.0),
                            Expanded(
                              child: Text(
                                state.errorText!,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox.shrink(key: ValueKey<bool>(showError)),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onTap(BuildContext context, FormFieldState<String> state) {
    onTap?.call();

    if (!canRequestFocus) {
      return;
    }
  }

  void _onChanged(String value, FormFieldState<String> state) {
    state.didChange(value);
    onChanged?.call(value);

    if (state.hasError) {
      state.validate();
    }
  }

  void _onSubmitted(FormFieldState<String> state) => state.validate();

  void _onTapOutside() => FocusManager.instance.primaryFocus?.unfocus();
}

// class CommaTextInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue,
//     TextEditingValue newValue,
//   ) {
//     String newText = newValue.text;
//     if (newText == oldValue.text) {
//       return newValue;
//     }
//
//     if (!newText.isDigitWithAtLeast1Dot) {
//       return oldValue;
//     }
//
//     // Remove all commas from the new text
//     final textWithoutCommas = newText.replaceAll(',', '');
//
//     // Split the text into the integer and fractional parts
//     final parts = textWithoutCommas.split('.');
//
//     // Format the integer part with commas
//     final integerPart = parts[0].replaceAllMapped(
//         RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match match) => '${match[1]},');
//
//     // Reconstruct the new text with the fractional part if it exists
//     final formattedText =
//         parts.length > 1 ? '$integerPart.${parts[1]}' : integerPart;
//
//     // Adjust the cursor position
//     final newOffset =
//         newValue.selection.baseOffset + (formattedText.length - newText.length);
//
//     return TextEditingValue(
//       text: formattedText,
//       selection: TextSelection.collapsed(offset: newOffset),
//     );
//   }
// }

// class CustomPinCodeTextField extends StatelessWidget {
//   const CustomPinCodeTextField({
//     super.key,
//     this.focusNode,
//     this.controller,
//     this.onCompleted,
//     this.onChanged,
//     this.length = 4,
//     this.autoFocus = false,
//     this.obscureText = false,
//     this.autoDisposeControllers = false,
//   });
//
//   final int length;
//   final bool autoFocus;
//   final bool obscureText;
//   final bool autoDisposeControllers;
//   final FocusNode? focusNode;
//   final TextEditingController? controller;
//   final ValueChanged<String>? onCompleted;
//   final ValueChanged<String>? onChanged;
//
//   @override
//   Widget build(BuildContext context) {
//     final selectedColor = appMaterialColor.withGreen(140);
//
//     return PinCodeTextField(
//       appContext: context,
//       length: length,
//       focusNode: focusNode,
//       controller: controller,
//       cursorColor: AppColors.primaryColor,
//       keyboardType: TextInputType.none,
//       autoFocus: autoFocus,
//       errorTextSpace: 0,
//       blinkWhenObscuring: true,
//       obscureText: obscureText,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//       onCompleted: onCompleted,
//       enablePinAutofill: false,
//       enableActiveFill: true,
//       autoDisposeControllers: autoDisposeControllers,
//       onChanged: onChanged,
//       pinTheme: PinTheme(
//         shape: PinCodeFieldShape.box,
//         fieldWidth: 48.0,
//         fieldHeight: 56.0,
//         activeFillColor: Colors.white,
//         activeColor: Colors.grey,
//         activeBoxShadow: <BoxShadow>[
//           if (focusNode!.hasFocus)
//             BoxShadow(
//               color: selectedColor.withOpacity(.2),
//               spreadRadius: 2.5,
//               blurRadius: 1.5,
//             ),
//         ],
//         inactiveColor: Colors.grey.shade400,
//         selectedFillColor: Colors.white,
//         inactiveFillColor: Colors.white,
//         selectedColor: selectedColor,
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//     );
//   }
// }
//
// class CustomTextField extends StatelessWidget {
//   const CustomTextField({
//     super.key,
//     this.hintText,
//     Widget? prefixIcon,
//     this.onChanged,
//     this.showSearchIcon = true,
//   }) : prefixIcon = showSearchIcon
//             ? const Icon(
//                 CupertinoIcons.search,
//                 color: AppColors.grey,
//                 size: 20.0,
//               )
//             : prefixIcon;
//
//   final String? hintText;
//   final Widget? prefixIcon;
//   final ValueChanged<String>? onChanged;
//   final bool showSearchIcon;
//
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       onChanged: onChanged,
//       decoration: InputDecoration(
//         prefixIcon: prefixIcon,
//         prefixIconConstraints: const BoxConstraints(minWidth: 46.0),
//         hintText: hintText,
//         isCollapsed: true,
//         hintStyle: const TextStyle(
//           fontSize: 14.0,
//           color: AppColors.grey,
//           fontWeight: FontWeight.normal,
//         ),
//         contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8.0),
//           borderSide: BorderSide(
//             color: Theme.of(context).highlightColor,
//             width: 1.6,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8.0),
//           borderSide: BorderSide(
//             color: Theme.of(context).primaryColor,
//             width: 1.6,
//           ),
//         ),
//       ),
//     );
//   }
// }
