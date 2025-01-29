import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    required this.title,
    required this.addMoneyText,
    required this.onProfile,
    required this.onAddMoney,
    required this.onBellIcon,
  });

  final String title;
  final String addMoneyText;
  final VoidCallback onProfile;
  final VoidCallback onAddMoney;
  final VoidCallback onBellIcon;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    const appBarTextStyle = TextStyle(
      fontSize: 18.0,
      color: Color(0xFF18191F),
      fontWeight: FontWeight.bold,
    );

    return AppBar(
      titleTextStyle: appBarTextStyle,
      title: GestureDetector(
        onTap: onProfile,
        child: Row(
          children: <Widget>[
            const CircleAvatar(),
            const SizedBox(width: 8.0),
            Text(title),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onAddMoney,
          child: Row(
            children: <Widget>[
              Text(
                addMoneyText,
                style: appBarTextStyle.copyWith(fontSize: 12.0),
              ),
              const SizedBox(width: 8.0),
              SizedBox.square(
                dimension: 24.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: const Color(0xFF200E32),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
              IconButton(
                onPressed: onBellIcon,
                icon: const Icon(CupertinoIcons.bell),
                style: IconButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  iconSize: 24,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
