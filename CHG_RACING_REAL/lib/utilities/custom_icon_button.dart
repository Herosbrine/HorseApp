import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({Key? key, this.icon, this.onTap, this.color})
      : super(key: key);
  final IconData? icon;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon ?? Icons.edit,
        color: color,
      ),
      onPressed: onTap,
    );
  }
}
