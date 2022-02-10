import 'package:chg_racing/constants/app_colors.dart';
import 'package:chg_racing/utilities/styling.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  CustomDialog({
    Key? key,
    required this.title,
    this.desc,
    this.button1,
    this.button2,
    this.onTap1,
    this.onTap2,
  }) : super(key: key);

  final String? title;
  final String? desc;
  final String? button1;
  final String? button2;
  final VoidCallback? onTap1;
  final VoidCallback? onTap2;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(11))),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11),
          border: Border.all(color: AppColors.grey),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 15),
            Text(
              title ?? '',
              style: Styling.setTextStyle(
                size: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            // SizedBox(height: 30),
            if (desc != null)
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  desc ?? '',
                  textAlign: TextAlign.justify,
                  style: Styling.setTextStyle(
                    size: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ),
            if (desc == null) SizedBox(height: 30),
            Divider(height: 0),
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: onTap1,
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            button1 ?? '',
                            style: Styling.setTextStyle(
                              size: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(),
                  Expanded(
                    child: InkWell(
                      onTap: onTap2,
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            button2 ?? '',
                            style: Styling.setTextStyle(
                              size: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
