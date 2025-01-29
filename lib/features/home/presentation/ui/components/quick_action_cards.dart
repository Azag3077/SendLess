import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constants/assets.dart';

class QuickActionRow extends StatelessWidget {
  const QuickActionRow({super.key, required this.children,});
  final List<QuickAction> children;

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.7,
      ),
      children: children,
    );
  }
}

class QuickAction extends StatelessWidget {
  const QuickAction({
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
          child: Column(
            children: <Widget>[
              Container(
                height: constraints.maxWidth,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withValues(alpha: .08),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: SvgPicture.asset(iconPath),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      height: 1.2,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
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
