import 'package:chg_racing/constants/app_colors.dart';
import 'package:chg_racing/pages/home/home_page.dart';
import 'package:chg_racing/services/data_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

  Future<void> authenticate(
      BuildContext context, String? email, String? password,
      {bool signup = false}) async {
    try {
      UserCredential? credential;
      if (signup == true) {
        //SIGN UP METHOD
        credential = await _auth.createUserWithEmailAndPassword(
          email: email ?? '',
          password: password ?? '',
        );
      } else {
        //SIGN IN METHOD
        credential = await _auth.signInWithEmailAndPassword(
          email: email ?? '',
          password: password ?? '',
        );
      }
      User? user = credential.user;
      if (user != null) {
        // String? userid = user.uid;
        DataFunctions().saveData(isLogin: true);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
          (_) => false,
        );
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        snackBar(context, "L'email existe déjà.");
        // showToast('Email already exists');
      } else if (error.code == 'wrong-password') {
        snackBar(context, 'Mot de passe incorrect.');
      } else if (error.code == 'user-not-found') {
        snackBar(context,
            "Utilisateur non trouvé. Essayez d'abord de vous inscrire");
      } else if (error.code == 'invalid-email') {
        snackBar(context, "L'email donné est invalide.");
      }
    }
  }

  Future signIn({String? email, String? password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email ?? '', password: password ?? '');
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //Forgot Password Method
  Future<void> forgotPassword(BuildContext context, {String? email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email ?? '');
      snackBar(context, "Email de réinitialisation du mot de passe envoyé");
      await Future.delayed(Duration(seconds: 2));
      Navigator.pop(context);
    } on FirebaseAuthException catch (error) {
      if (error.code == 'invalid-email') {
        snackBar(context, "L'adresse e-mail est mal formatée.");
      } else if (error.code == 'user-not-found') {
        snackBar(context,
            'Il existe un enregistrement non utilisateur correspondant à cet email.');
      }
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    DataFunctions().setBoolVariable("isLogin", false);
    await _auth.signOut();
  }
}

snackBar(BuildContext context, String? message) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message ?? '',
        softWrap: true,
        overflow: TextOverflow.visible,
      ),
      duration: Duration(seconds: 2),
      backgroundColor: AppColors.teal,
    ),
  );
}
