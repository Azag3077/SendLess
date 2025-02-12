import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BillsGrid extends StatelessWidget {
  const BillsGrid({
    super.key,
    required this.children,
  });

  final List<BillsButton> children;

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

class BillsButton extends StatelessWidget {
  const BillsButton({
    super.key,
    required this.onPressed,
    required this.iconPath,
    required this.text,
    this.selected = false,
  });

  final VoidCallback onPressed;
  final String iconPath;
  final String text;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return MaterialButton(
          onPressed: onPressed,
          height: constraints.maxWidth,
          padding: const EdgeInsets.all(4.0),
          elevation: 0,
          color:
              selected ? Theme.of(context).colorScheme.primaryContainer : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: iconPath.endsWith('svg')
                    ? SvgPicture.asset(iconPath)
                    : Image.asset(iconPath, width: 32.0),
              ),
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
        );
      },
    );
  }
}
