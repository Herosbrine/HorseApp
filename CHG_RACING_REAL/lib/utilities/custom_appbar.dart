import 'package:chg_racing/utilities/styling.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    Key? key,
    this.height = 60,
    this.showBack = true,
    this.icon,
    this.title,
    this.actionTap,
  }) : super(key: key);
  final double height;
  final String? title;
  final bool showBack;
  final IconData? icon;
  final VoidCallback? actionTap;
  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title ?? '',
        style: Styling.setTextStyle(
          size: 18,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: !showBack
          ? null
          : IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
      actions: [
        if (icon != null)
          IconButton(
            onPressed: actionTap,
            icon: Icon(
              icon ?? Icons.add,
              color: Colors.white,
            ),
          ),
      ],
    );
  }
}
