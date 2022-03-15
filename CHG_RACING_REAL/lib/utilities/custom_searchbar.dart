import 'package:chg_racing/constants/app_colors.dart';
import 'package:chg_racing/utilities/styling.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String)? onChangeFunction;
  final TextEditingController? controller;
  const CustomSearchBar({Key? key, this.controller, this.onChangeFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: AppGlobals.screenWidth * 0.1),
      child: CupertinoSearchTextField(
        controller: controller,
        itemColor: AppColors.teal,
        placeholder: 'Recherche',
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: AppColors.grey),
        ),
        style: Styling.setTextStyle(size: 14, color: AppColors.grey),
        padding: EdgeInsets.fromLTRB(22, 10, 12, 10),
        onChanged: onChangeFunction,
      ),
    );
  }
}
