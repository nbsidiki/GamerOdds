import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        var snackBar =
            SnackBar(content: Text('Successfully create the account ! 👌'));

        _globalKey.currentState?.showSnackBar(snackBar);
        await Future.delayed(const Duration(seconds: 2));

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
    return ScaffoldMessenger(
      key: _globalKey,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/login_background.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: new BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: new Container(
                      decoration: new BoxDecoration(
                          color: Colors.white.withOpacity(0.0)),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 250),
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    Text(
                      "Feels the ",
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.w100),
                    ),
                    Text("Game",
                        style: TextStyle(
                            fontSize: 70,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    Text(
                      ".",
                      style: TextStyle(
                          fontSize: 40,
                          color: Color.fromARGB(255, 212, 211, 211),
                          fontWeight: FontWeight.w100),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 0.0, top: 500.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)),
                  color: Colors.white,
                ),
                child: Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: Column(
                        children: [
                          Text('Inscription',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: const Icon(Icons.email),
                                border: const OutlineInputBorder(),
                                errorText: errorEmail),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: const InputDecoration(
                              labelText: 'Mot de passe',
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: confirmPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: const InputDecoration(
                              labelText: 'Confirmation du mot de passe',
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(
                                    0xff5E28D1), // Couleur violette pour le bouton
                              ),
                              onPressed: () {
                                register();
                              },
                              child: const Text('inscription',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(2),
                            child: GestureDetector(
                              child: Text(
                                "Retour",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
