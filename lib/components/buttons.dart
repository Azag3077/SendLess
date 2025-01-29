import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'animated_widgets.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  final String text;
  final VoidCallback? onPressed;

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
  final FutureOr<T?> Function() onPressed;
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
                        width: 1.5,
                        color: showError
                            ? Theme.of(context).colorScheme.error
                            : Colors.black.withValues(alpha: .3),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
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
            CustomAnimatedSwitcher(
              value: showError,
              child: Padding(
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
                        state.errorText ?? '',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class CheckboxButton extends StatelessWidget {
  const CheckboxButton({
    super.key,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onSelected,
  });

  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final pryColor = Theme.of(context).primaryColor.withValues(alpha: .7);
    final bgColor = pryColor.withValues(alpha: .05);
    final borderInactiveColor = Colors.grey.shade300;
    final checkInactiveColor = Colors.grey.shade400;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: MaterialButton(
        onPressed: onSelected,
        elevation: 0,
        color: selected ? bgColor : null,
        padding: const EdgeInsets.all(12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(
            color: selected ? pryColor : borderInactiveColor,
            width: 1.5,
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF3E4158),
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFACAFC3),
                      fontSize: 11.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8.0),
            if (selected)
              Icon(
                CupertinoIcons.check_mark_circled_solid,
                color: Theme.of(context).primaryColor,
              )
            else
              SizedBox.square(
                dimension: 20.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: checkInactiveColor,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            const SizedBox(width: 4.0),
          ],
        ),
      ),
    );
  }
}
