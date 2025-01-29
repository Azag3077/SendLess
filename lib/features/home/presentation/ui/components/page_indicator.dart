import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.length,
    required this.index,
  });

  final int length;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        length,
        (index) {
          final current = this.index == index;

          return Padding(
            padding: EdgeInsets.only(left: index > 0 ? 6.0 : 0),
            child: SizedBox.square(
              dimension: current ? 10.0 : 8.0,
              child: DecoratedBox(
                decoration: ShapeDecoration(
                  shape: const CircleBorder(),
                  color: Theme.of(context)
                      .primaryColor
                      .withValues(alpha: current ? 1 : .45),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
