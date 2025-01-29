import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ButtonsGrid extends StatefulWidget {
  const ButtonsGrid({
    super.key,
    this.onPressed,
    this.controller,
    this.onChanged,
    this.deleteOnBackspace = true,
    this.padding,
  });

  final TextEditingController? controller;
  final ValueChanged<int>? onPressed;
  final Function(String?, String?)? onChanged;
  final bool deleteOnBackspace;
  final EdgeInsets? padding;

  @override
  State<ButtonsGrid> createState() => _ButtonsGridState();
}

class _ButtonsGridState extends State<ButtonsGrid> {
  Timer? timer;

  final _duration = const Duration(milliseconds: 80);

  final _buttons = <int, String>{
    1: '',
    2: 'abc',
    3: 'def',
    4: 'ghi',
    5: 'jkl',
    6: 'mno',
    7: 'pqrs',
    8: 'yuv',
    9: 'wxyz',
    -1: '.',
    0: '+',
    -2: '⌫',
  };

  void _onPressed(int key) {
    final prevValue = widget.controller?.text;
    if (key >= 0) {
      _addCharacter(key.toString());
      widget.onPressed?.call(key);
    } else {
      _deleteCharacter();
    }
    final newValue = widget.controller?.text;
    widget.onChanged?.call(prevValue, newValue);
  }

  void _onLongPress(int key) {
    void callback(_) {
      if (widget.controller == null) return;
      if (widget.controller!.selection.baseOffset > 0) {
        _onPressed(key);
        HapticFeedback.mediumImpact();
      }
    }

    timer = Timer.periodic(_duration, callback);
  }

  void _deleteCharacter() {
    if (widget.controller == null) return;

    final cp = widget.controller!.selection.baseOffset;

    if (cp <= 0) return;

    widget.controller!.text = widget.controller!.text.substring(0, cp - 1) +
        widget.controller!.text.substring(cp);
    widget.controller!.selection = TextSelection.collapsed(offset: cp - 1);
  }

  void _addCharacter(String character) {
    if (widget.controller == null) return;

    final cp = widget.controller!.selection.baseOffset;

    widget.controller!.text = widget.controller!.text.substring(0, cp) +
        character +
        widget.controller!.text.substring(cp);

    widget.controller!.selection = TextSelection.collapsed(offset: cp + 1);
  }

  // // Method to simulate key press from custom keyboard
  // void _onKeyPressed(String key) {
  //   if (widget.controller == null) return;
  //   final text = widget.controller!.text;
  //   final selection = widget.controller!.selection;
  //
  //   // Insert the new key into the current position of the cursor
  //   final newText = text.replaceRange(
  //     selection.start,
  //     selection.end,
  //     key,
  //   );
  //
  //   // Update the controller with the new text and move the cursor
  //   setState(() {
  //     widget.controller!.text = newText;
  //     widget.controller!.selection = TextSelection.collapsed(
  //       offset: selection.start + key.length,
  //     );
  //   });
  // }
  //
  // // Method to handle backspace
  // void _onBackspacePressed() {
  //   if (widget.controller == null) return;
  //
  //   final text = widget.controller!.text;
  //   final selection = widget.controller!.selection;
  //
  //   if (selection.start > 0) {
  //     final newText = text.replaceRange(
  //       selection.start - 1,
  //       selection.start,
  //       '',
  //     );
  //
  //     setState(() {
  //       widget.controller!.text = newText;
  //       widget.controller!.selection = TextSelection.collapsed(
  //         offset: selection.start - 1,
  //       );
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: _buttons.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: widget.padding,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 6.0,
        mainAxisExtent: 52.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        final btn = _buttons.entries.elementAt(index);

        return GestureDetector(
          onLongPress: () => _onLongPress(btn.key),
          onLongPressUp: () => timer?.cancel(),
          child: MaterialButton(
            onPressed: () => _onPressed(btn.key),
            elevation: 0,
            highlightElevation: 0,
            color: Theme
                .of(context)
                .highlightColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                if (btn.key < 0)
                  Text(btn.value, style: const TextStyle(fontSize: 22.0))
                else
                  ...[
                    Text(
                      btn.key.toString(),
                      style: const TextStyle(fontSize: 22.0),
                    ),
                    Text(
                      btn.value,
                      style: TextStyle(
                        color: Theme
                            .of(context)
                            .disabledColor,
                      ),
                    ),
                  ],
              ],
            ),
          ),
        );
      },
    );
  }
}
