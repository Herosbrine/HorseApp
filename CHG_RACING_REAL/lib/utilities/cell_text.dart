import 'package:chg_racing/utilities/styling.dart';
import 'package:flutter/material.dart';

class CellText extends StatelessWidget {
  CellText({Key? key, this.text, this.isBold = false, this.size = 16})
      : super(key: key);
  final String? text;
  bool isBold;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          text ?? '',
          softWrap: true,
          textAlign: TextAlign.center,
          style: Styling.setTextStyle(
            size: size,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
