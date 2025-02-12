import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// class NavbarItem extends StatelessWidget implements BottomNavigationBarItem {
class NavbarItem extends BottomNavigationBarItem {
  NavbarItem({
    required super.label,
    required this.iconPath,
  }) : super(
          icon: SvgPicture.asset(iconPath),
          activeIcon: _NavbarActiveIcon(iconPath),
        );

  final String iconPath;
}

class _NavbarActiveIcon extends StatelessWidget {
  const _NavbarActiveIcon(this.iconPath);

  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconPath,
      colorFilter: ColorFilter.mode(
        Theme.of(context).primaryColor,
        BlendMode.srcIn,
      ),
    );
  }
}
