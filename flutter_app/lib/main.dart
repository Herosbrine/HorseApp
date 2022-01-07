import 'package:flutter/material.dart';
import 'package:jeveux_2020/loginpage.dart';
import 'package:jeveux_2020/widget/home_controller.dart';
import 'package:jeveux_2020/employe/widgets/home_employe.dart';
import 'package:jeveux_2020/loginpage.dart';

//vacances, absent, course

void main() => runApp(LoginPage());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SafeArea(
        child: Center(
          child: Container(
            color: Colors.white60,
            padding: EdgeInsets.only(top: 150),
            child: Column(
              children: [
                BoutonSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => new Size.fromHeight(50);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/logo.png',
            fit: BoxFit.contain,
            height: 40,
          ),
        ],
      ),
    );
  }
}

class BoutonSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(60),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue,
                    onSurface: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return HomeController(title: 'Chevaux');
                        },
                      ),
                    );
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Chevaux',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return HomeEmploye(title: 'Employés');
                        },
                      ),
                    );
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Employés',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
