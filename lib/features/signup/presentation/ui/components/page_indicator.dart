import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.length,
    required this.currentIndex,
  });

  final int length;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        length,
            (index) {
          final isCurrent = index <= currentIndex;

          return <Widget>[
            if (index != 0)
              Expanded(
                child: Divider(
                  indent: 8.0,
                  endIndent: 8.0,
                  thickness: 4.0,
                  color: Colors.black.withValues(alpha: .3),
                ),
              ),
            SizedBox.square(
              dimension: isCurrent ? 25.0 : 20.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCurrent ? null : Colors.black.withValues(alpha: .30),
                  border: isCurrent
                      ? Border.all(
                    width: 7.0,
                    color: Theme
                        .of(context)
                        .primaryColor,
                  )
                      : null,
                ),
              ),
            ),
          ];
        },
      ).expand((element) => element).toList(),
    );
  }
}
