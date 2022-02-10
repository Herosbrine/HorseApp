import 'package:chg_racing/constants/app_colors.dart';
import 'package:chg_racing/constants/app_images.dart';
import 'package:chg_racing/constants/app_strings.dart';
import 'package:chg_racing/constants/globals.dart';
import 'package:chg_racing/services/authentication.dart';
import 'package:chg_racing/utilities/custom_button.dart';
import 'package:chg_racing/utilities/custom_textfield.dart';
import 'package:chg_racing/utilities/styling.dart';
import 'package:chg_racing/utilities/validator.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  Validator _validator = Validator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: AppGlobals.screenHeight,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: AppGlobals.screenHeight * 0.6,
                  width: double.infinity,
                  child: Image.asset(
                    AppImages.horse,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  height: AppGlobals.screenHeight * 0.6,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.orange,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(AppGlobals.screenWidth * 0.3),
                    ),
                  ),
                  child: _signupFormFields(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signupFormFields(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                Text(
                  'Mot de passe oublié',
                  style: Styling.setTextStyle(
                    color: Colors.white,
                    size: AppGlobals.screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              AppStrings.resetPassword,
              style: Styling.setTextStyle(
                color: Colors.white,
                size: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 20),
          CustomTextField(
            hintText: 'Email',
            controller: _emailController,
            iconPath: AppImages.ic_email,
            isObscure: false,
            isPasswordField: false,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => _validator.validateEmail(
              value.toString().trim(),
            ),
          ),
          // SizedBox(height: 15.0),
          Spacer(),
          CustomFlatButton(
            title: 'réinitialiser le mot de passe',
            onTap: () {
              if (_formKey.currentState!.validate()) {
                FocusScope.of(context).requestFocus(new FocusNode());

                AuthenticationHelper().forgotPassword(
                  context,
                  email: _emailController.text.trim(),
                );
              }
            },
          ),
          Spacer(),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
