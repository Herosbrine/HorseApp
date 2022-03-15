import 'package:chg_racing/utilities/styling.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText(
      {Key? key,
      this.title,
      this.linkTitle,
      this.navigateToClass,
      this.color,
      this.linkColor,
      this.fontSize,
      this.fontWeight})
      : super(key: key);
  final String? title, linkTitle;
  final Widget? navigateToClass;
  final Color? color, linkColor;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: Styling.setTextStyle(
          color: color,
          size: fontSize,
          fontWeight: fontWeight,
        ),
        children: [
          TextSpan(text: title),
          TextSpan(
            text: linkTitle,
            style: Styling.setTextStyle(
              color: linkColor,
              size: fontSize,
              fontWeight: fontWeight,
            ).copyWith(decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                if (navigateToClass != null)
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => navigateToClass!),
                  );
              },
          ),
        ],
      ),
    );
  }
}
