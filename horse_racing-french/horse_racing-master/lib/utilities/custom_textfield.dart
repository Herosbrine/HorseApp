import 'package:chg_racing/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'styling.dart';

class CustomTextField extends StatefulWidget {
  final String? iconPath, hintText, labelText;
  final Color? borderColor, backgroundColor;
  final TextEditingController? controller;
  final FormFieldValidator? validator;
  final TextInputType? keyboardType;
  final Function(String)? onChange;
  IconData? mSuffixIconData;
  bool isPasswordField, isEnabled, isObscure;

  CustomTextField({
    Key? key,
    this.iconPath,
    this.hintText,
    this.mSuffixIconData,
    this.borderColor,
    this.backgroundColor,
    this.controller,
    this.labelText,
    this.validator,
    this.onChange,
    this.keyboardType,
    this.isEnabled = true,
    this.isObscure = false,
    this.isPasswordField = false,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      enabled: widget.isEnabled,
      maxLength: 100,
      obscureText: widget.isObscure,
      keyboardType: widget.keyboardType,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      style: TextStyle(color: AppColors.grey),
      onChanged:
          widget.onChange == null ? null : (value) => widget.onChange!(value),
      decoration: InputDecoration(
        counterText: '',
        labelText: widget.labelText,
        hintText: widget.hintText,
        filled: true,
        fillColor: widget.backgroundColor ?? Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        hintStyle: Styling.setTextStyle(color: AppColors.lightGrey),
        prefixIcon:
            widget.iconPath == null ? null : iconImage(widget.iconPath!),
        suffixIcon: !(widget.isPasswordField)
            ? null
            : IconButton(
                icon: Icon(widget.mSuffixIconData ?? Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    widget.isObscure = !widget.isObscure;
                    widget.isObscure
                        ? widget.mSuffixIconData = Icons.visibility_off
                        : widget.mSuffixIconData = Icons.visibility;
                  });
                },
              ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.orange),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.grey),
        ),
      ),
    );
  }

  Image iconImage(String path) {
    return Image.asset(
      path,
      scale: 2,
      color: AppColors.lightGrey,
    );
  }

  static void unFocus(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }
}
