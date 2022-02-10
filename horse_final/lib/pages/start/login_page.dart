import 'package:chg_racing/constants/app_colors.dart';
import 'package:chg_racing/constants/app_images.dart';
import 'package:chg_racing/constants/globals.dart';
import 'package:chg_racing/pages/start/forgot_password.dart';
import 'package:chg_racing/services/authentication.dart';
import 'package:chg_racing/utilities/custom_button.dart';
import 'package:chg_racing/utilities/custom_richtext.dart';
import 'package:chg_racing/utilities/custom_textfield.dart';
import 'package:chg_racing/utilities/styling.dart';
import 'package:chg_racing/utilities/validator.dart';
import 'package:flutter/material.dart';

import 'signup_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
                  child: _loginFormFields(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginFormFields(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            'Connexion',
            style: Styling.setTextStyle(
              color: Colors.white,
              size: AppGlobals.screenHeight * 0.05,
              fontWeight: FontWeight.bold,
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
          SizedBox(height: 10),
          CustomTextField(
            hintText: 'Mot de passe',
            isObscure: true,
            isPasswordField: true,
            iconPath: AppImages.ic_lock,
            mSuffixIconData: Icons.visibility_off,
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            validator: (value) => _validator.validatePassword(
              value.toString().trim(),
            ),
          ),
          // SizedBox(height: 15.0),
          Spacer(),
          CustomFlatButton(
            title: 'Connexion',
            onTap: () {
              if (_formKey.currentState!.validate()) {
                FocusScope.of(context).requestFocus(new FocusNode());

                AuthenticationHelper().authenticate(
                  context,
                  _emailController.text.trim(),
                  _passwordController.text.trim(),
                );
              }
            },
          ),
          Spacer(),
          CustomRichText(
            linkTitle: 'Mot de passe oublié?',
            fontSize: 16,
            navigateToClass: ForgotPassword(),
          ),
          SizedBox(height: 15.0),
          /* CustomRichText(
            title: "Vous n'avez pas de compte? ",
            linkTitle: "S'inscrire",
            fontSize: 16,
            // linkColor: AppColors.teal,
            navigateToClass: SignupPage(),
          ), */
        ],
      ),
    );
  }
}
