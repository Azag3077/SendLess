import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BillsGrid extends StatelessWidget {
  const BillsGrid({
    super.key,
    required this.children,
  });

  final List<BillsContainer> children;

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 8.0,
      ),
      children: children,
    );
  }
}

class BillsContainer extends StatelessWidget {
  const BillsContainer({
    super.key,
    required this.onPressed,
    required this.iconPath,
    required this.text,
  });

  final VoidCallback onPressed;
  final String iconPath;
  final String text;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: onPressed,
          child: Container(
            height: constraints.maxWidth,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),
            child: Column(
              children: <Widget>[
                Expanded(child: SvgPicture.asset(iconPath)),
                FittedBox(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.2,
                      fontSize: 14.0,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
