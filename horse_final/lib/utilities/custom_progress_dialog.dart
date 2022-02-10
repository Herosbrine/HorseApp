import 'package:chg_racing/constants/app_strings.dart';
import 'package:chg_racing/utilities/styling.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

class MyProgressDialog {
  static getProgressDialog(
          String title, String content, BuildContext context) =>
      ProgressDialog(
        context,
        title: Text(
          '$title',
          style: Styling.setTextStyle(size: 18, fontWeight: FontWeight.w600),
        ),
        message: Text(
          '$content',
          style: Styling.setTextStyle(
            size: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      );

  static Widget setProgressTitle(String? title) => Text(
        title ?? 'Failure',
        style: Styling.setTextStyle(
          size: 18,
          fontWeight: FontWeight.w600,
        ),
      );

  static Widget setProgressMessage(String? message) => Text(
        message ?? AppStrings.somethingWrong,
        style: Styling.setTextStyle(
          size: 14,
          fontWeight: FontWeight.w500,
        ),
      );

  static Widget setIcon({IconData? icon, Color? color}) => Icon(
        icon ?? Icons.warning_amber_outlined,
        color: color ?? Colors.red,
      );

  static setErrorDialog(ProgressDialog _progressDialog) {
    _progressDialog.setTitle(setProgressTitle(null));
    _progressDialog.setMessage(setProgressMessage(null));
    _progressDialog.setLoadingWidget(setIcon());
    Future.delayed(Duration(seconds: 3), () => _progressDialog.dismiss());
  }

  static setSuccessDialog(
      ProgressDialog _progressDialog, String? title, String? message,
      {int? time, String? code, bool showIcon = true, showCode = false}) {
    _progressDialog.setTitle(
      Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          setProgressTitle(title ?? "Success"),
          InkWell(
            onTap: () => _progressDialog.dismiss(),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Icon(Icons.cancel_outlined),
            ),
          ),
        ],
      ),
    );
    _progressDialog.setMessage(
      !showCode
          ? setProgressMessage(message ?? "Data Updated Successfully.")
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                setProgressMessage(message ?? "Data Updated Successfully."),
                Text(
                  '${code ?? ''}',
                  style: Styling.setTextStyle(
                    size: 24,
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
    );

    _progressDialog.setLoadingWidget(
      !showIcon
          ? Container()
          : setIcon(icon: Icons.check, color: Colors.greenAccent),
    );

    // await Future.delayed(
    //     Duration(seconds: time ?? 3), () => _progressDialog.dismiss());
  }

  static setCustomMessageDialog(
      ProgressDialog _progressDialog, String? title, String? message,
      {int? seconds}) {
    _progressDialog.setTitle(setProgressTitle(title ?? "Failure"));
    _progressDialog
        .setMessage(setProgressMessage(message ?? AppStrings.somethingWrong));
    _progressDialog.setLoadingWidget(setIcon());
    Future.delayed(
        Duration(seconds: seconds ?? 2), () => _progressDialog.dismiss());
  }
}
