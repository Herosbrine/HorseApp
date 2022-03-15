import 'package:chg_racing/constants/app_colors.dart';
import 'package:chg_racing/utilities/styling.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  CustomButton({
    Key? key,
    this.title,
    this.onTap,
    this.buttonHeight = 50,
    this.bottonWidth = 200,
    this.showIcon,
    this.color,
    this.borderColor,
    this.textColor,
    this.textSize,
    this.fontWeight,
  }) : super(key: key);
  final VoidCallback? onTap;
  final String? title;
  final double? buttonHeight, bottonWidth, textSize;
  final FontWeight? fontWeight;
  final Color? color, borderColor, textColor, showIcon;

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    //Custom Gradient Button
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: widget.buttonHeight,
        width: widget.bottonWidth,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: widget.color ?? Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.borderColor ?? widget.color ?? Colors.white,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                widget.title ?? '',
                textAlign: TextAlign.center,
                style: Styling.setTextStyle(
                  size: widget.textSize,
                  fontWeight: widget.fontWeight,
                  color: widget.textColor ?? Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomFlatButton extends StatelessWidget {
  const CustomFlatButton(
      {Key? key,
      this.backgroundColor,
      this.onTap,
      this.title,
      this.height,
      this.width})
      : super(key: key);
  final Color? backgroundColor;
  final String? title;
  final VoidCallback? onTap;
  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50,
      width: width ?? 260,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            backgroundColor ?? AppColors.teal,
          ),
        ),
        child: Center(
          child: Text(
            title ?? '',
            style: Styling.setTextStyle(
              size: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
