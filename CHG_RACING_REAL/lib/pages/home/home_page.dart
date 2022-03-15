import 'package:chg_racing/constants/app_images.dart';
import 'package:chg_racing/constants/globals.dart';
import 'package:chg_racing/pages/home/weighing/weighing_page.dart';
import 'package:chg_racing/pages/start/login_page.dart';
import 'package:chg_racing/services/authentication.dart';
import 'package:chg_racing/utilities/custom_appbar.dart';
import 'package:chg_racing/utilities/custom_button.dart';
import 'package:chg_racing/utilities/custom_dialog.dart';
import 'package:chg_racing/utilities/styling.dart';
import 'package:flutter/material.dart';

import 'employees/employees_page.dart';
import 'horses/horses_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'CHG Racing',
        showBack: false,
        icon: Icons.exit_to_app_sharp,
        actionTap: () {
          //Logout button

          showDialog(
            context: context,
            builder: (BuildContext context) => CustomDialog(
              title: 'Se déconnecter',
              desc: 'Êtes-vous sûr de vouloir vous déconnecter?',
              button1: 'Oui',
              button2: 'Non',
              onTap2: () => Navigator.pop(context),
              onTap1: () async {
                await AuthenticationHelper().signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          );
        },
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.horses_bg),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: AppGlobals.screenHeight * 0.2),
              CustomFlatButton(
                title: 'Employés',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EmployeesPage(),
                      ));
                },
              ),
              SizedBox(height: 20),
              CustomFlatButton(
                title: 'Chevaux',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewHorsesPage(),
                      ));
                },
              ), SizedBox(height: 20),
              CustomFlatButton(
                title: 'Pesée',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HorsesPage(),
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
