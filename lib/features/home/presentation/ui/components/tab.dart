import 'package:flutter/material.dart';

class CustomTab extends StatelessWidget {
  const CustomTab({
    super.key,
    required this.onTab,
    required this.text,
    required this.selected,
  });

  final VoidCallback onTab;
  final String text;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: selected ? 1.0 : .5,
      child: Container(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.only(right: 12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 6.0,
              spreadRadius: 3.0,
              color: Colors.grey.shade200,
            ),
          ],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: MaterialButton(
          minWidth: 0.0,
          onPressed: onTab,
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 24.0,
          ),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: selected ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
