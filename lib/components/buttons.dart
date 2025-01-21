import 'package:flutter/material.dart';

import '../core/extensions/num_duration.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: const TextStyle(fontSize: 16.0),
        padding: const EdgeInsets.symmetric(vertical: 14.0),
      ),
      child: Center(child: Text(text)),
    );
  }
}

class SelectionButton<T> extends StatelessWidget {
  const SelectionButton({
    super.key,
    this.labelText,
    this.hintText,
    this.initialValue,
    this.textBuilder,
    required this.onPressed,
    this.margin = const EdgeInsets.only(bottom: 16.0),
    this.validator,
  });

  final String? labelText;
  final String? hintText;
  final T? initialValue;
  final String? Function(T?)? textBuilder;
  final Future<T?> Function() onPressed;
  final EdgeInsets margin;
  final FormFieldValidator<T>? validator;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.normal,
      color: Colors.black.withValues(alpha: .79),
    );

    if (initialValue == null) {
      textStyle = textStyle.copyWith(
        fontSize: 14.0,
        color: Theme.of(context).hintColor,
        fontWeight: FontWeight.normal,
      );
    }

    return FormField<T>(
      validator: validator,
      initialValue: initialValue,
      builder: (FormFieldState<T> state) {
        final showError = state.hasError && state.errorText != null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: margin,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (labelText != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0, bottom: 8.0),
                      child: Text(
                        labelText!,
                        style: TextStyle(
                          color: Colors.black.withValues(alpha: .89),
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  MaterialButton(
                    onPressed: () async {
                      state.didChange(await onPressed());
                      if (state.isValid) state.reset();
                      state.save();
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(
                        color: Colors.black.withValues(alpha: .3),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        if (hintText != null)
                          Expanded(
                            child: Text(
                              textBuilder?.call(state.value) ?? hintText ?? '',
                              style: textStyle,
                            ),
                          ),
                        Icon(
                          Icons.expand_more,
                          color: Theme.of(context).hintColor,
                        ),
                      ],
                    ),
                  ),
                ],
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
    );
  }
}
