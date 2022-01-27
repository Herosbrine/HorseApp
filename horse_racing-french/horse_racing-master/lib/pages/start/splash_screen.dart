import 'dart:async';
import 'package:chg_racing/constants/app_colors.dart';
import 'package:chg_racing/constants/app_images.dart';
import 'package:chg_racing/constants/globals.dart';
import 'package:chg_racing/pages/home/home_page.dart';
import 'package:chg_racing/pages/start/login_page.dart';
import 'package:chg_racing/services/data_functions.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? _isLogin = false;
  DataFunctions dataFunctions = DataFunctions();

  @override
  void initState() {
    super.initState();
    _getStoredDate();
    // _startTimer();
  }

  _getStoredDate() async {
    _isLogin = await dataFunctions.getBoolVariable("isLogin");
    _isLogin = _isLogin == null ? false : _isLogin;

    if (_isLogin == true) {
      // await dataFunctions.getSavedData();
    }
    _startTimer();
  }

  void _startTimer() async {
    Timer(
      Duration(seconds: 1),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => _isLogin == true ? HomePage() : LoginPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppGlobals.screenHeight = MediaQuery.of(context).size.height;
    AppGlobals.screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.orange,
      body: SafeArea(
        child: Center(
          child: Image.asset(
            AppImages.logo,
            width: AppGlobals.screenWidth * 0.3,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
