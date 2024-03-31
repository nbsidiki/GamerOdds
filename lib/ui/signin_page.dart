import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gamer_oods_flutter_application/models/api.dart';
import 'package:gamer_oods_flutter_application/theme/colors.dart';
import 'package:gamer_oods_flutter_application/ui/login_page.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  //Define all controlers
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final _globalKey = GlobalKey<ScaffoldMessengerState>();

  String? errorEmail;
  String? errorConfirmPassword;
  String? errorPassword;

  void register() async {
    if (!isValidEmail(emailController.text)) {
      errorEmail = "'${emailController.text}' is not email !";
    } else {
      errorEmail = null;
    }
    if (passwordController.text != confirmPasswordController.text) {
      print("password and confirmPassword must be the same");
    }
    if (errorEmail == null &&
        errorPassword == null &&
        errorConfirmPassword == null) {
      try {
        UserCredential user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        print("User created");
        API.addNewUser(user.user!.uid);
        var snackBar =
            SnackBar(content: Text('Successfully create the account ! 👌'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.of(context).pop();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          errorEmail = "${emailController.text} is already use !";
        }
      } catch (e) {
        print(e);
      }
    }
    setState(() {});
  }

  bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: primary,
          image: DecorationImage(
              image: AssetImage('assets/images/login_background.png'),
              fit: BoxFit.fill,
              alignment: FractionalOffset.topRight),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 48, 16, 0),
                width: MediaQuery.of(context).size.width,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 18),
                        child: Text("Feels the ",
                            style: TextStyle(
                              fontSize: 36,
                              color: white,
                            )),
                      ),
                      Text("Game",
                          style: TextStyle(
                              fontSize: 64,
                              fontWeight: FontWeight.bold,
                              color: white)),
                      Padding(
                        padding: EdgeInsets.only(top: 18),
                        child: Text(".",
                            style: TextStyle(fontSize: 36, color: white)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.16),
                    blurRadius: 8,
                    // Shadow position
                  ),
                ],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0)),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    const Text('GamerOdds',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 32,
                            color: black,
                            fontWeight: FontWeight.bold)),
                    Text(
                      "Inscrivez-vous à GamerOdds 🎮",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Container(
                      height: 54,
                      padding: EdgeInsets.only(left: 4, right: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Color(0xffEBEEEF),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.16),
                            blurRadius: 4,
                            offset: Offset(0, 4), // Shadow position
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: emailController,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            color: black, fontWeight: FontWeight.bold),
                        cursorColor: third,
                        decoration: InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide.none),
                            hintText: 'E-mail',
                            hintStyle: TextStyle(
                                fontFamily: 'BricolageGrotesque',
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: black.withOpacity(0.4))),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      height: 54,
                      padding: EdgeInsets.only(left: 4, right: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Color(0xffEBEEEF),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.16),
                            blurRadius: 4,
                            offset: Offset(0, 4), // Shadow position
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        style: TextStyle(
                            color: black, fontWeight: FontWeight.bold),
                        cursorColor: third,
                        decoration: InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide.none),
                            hintText: 'Mot de passe',
                            hintStyle: TextStyle(
                                fontFamily: 'BricolageGrotesque',
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: black.withOpacity(0.4))),
                        obscureText: true,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      height: 54,
                      padding: EdgeInsets.only(left: 4, right: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Color(0xffEBEEEF),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.16),
                            blurRadius: 4,
                            offset: Offset(0, 4), // Shadow position
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: confirmPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        style: TextStyle(
                            color: black, fontWeight: FontWeight.bold),
                        cursorColor: third,
                        decoration: InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide.none),
                            hintText: 'Confirmation de votre mot de passe',
                            hintStyle: TextStyle(
                                fontFamily: 'BricolageGrotesque',
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: black.withOpacity(0.4))),
                        obscureText: true,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      height: 54,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.16),
                            blurRadius: 4,
                            offset: Offset(0, 4), // Shadow position
                          ),
                        ],
                      ),
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // <-- Radius
                          ),
                        ),
                        onPressed: () {
                          register();
                          if (FirebaseAuth.instance.currentUser != null) {
                            //print(FirebaseAuth.instance.currentUser?.uid);
                          }
                        },
                        child: const Text('S\'inscrire',
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Retour",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
