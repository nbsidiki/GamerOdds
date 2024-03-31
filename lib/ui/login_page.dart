import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gamer_oods_flutter_application/theme/colors.dart';
import 'package:gamer_oods_flutter_application/ui/home_page.dart';
import 'package:gamer_oods_flutter_application/ui/signin_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  FirebaseDatabase database = FirebaseDatabase.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  signIn() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((value) => {
              //print(value),
              if (FirebaseAuth.instance.currentUser != null)
                {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => HomePage()))
                }
            });
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: primary,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Animate(
        effects: [FadeEffect(duration: 400.ms, curve: Curves.decelerate)],
        child: Container(
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
                    child: Animate(
                      effects: [
                        FadeEffect(
                            delay: 250.ms,
                            duration: 600.ms,
                            curve: Curves.decelerate),
                        SlideEffect(
                            delay: 250.ms,
                            duration: 400.ms,
                            curve: Curves.decelerate),
                      ],
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
              ),
              Animate(
                effects: [
                  FadeEffect(
                      delay: 550.ms, duration: 500.ms, curve: Curves.easeIn),
                  SlideEffect(
                      delay: 550.ms,
                      duration: 600.ms,
                      curve: Curves.fastOutSlowIn,
                      begin: Offset(0, 1))
                ],
                child: Container(
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
                  child: Animate(
                    effects: [
                      FadeEffect(
                          delay: 1000.ms,
                          duration: 400.ms,
                          curve: Curves.easeIn),
                      SlideEffect(
                          delay: 1000.ms,
                          duration: 600.ms,
                          curve: Curves.fastOutSlowIn,
                          begin: Offset(0, 0.2))
                    ],
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
                            "Connectez-vous à votre compte",
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
                                  hintText: 'Votre e-mail',
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
                                  hintText: 'Votre mot de passe',
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
                                signIn();
                                if (FirebaseAuth.instance.currentUser != null) {
                                  //print(FirebaseAuth.instance.currentUser?.uid);
                                }
                              },
                              child: const Text('Se connecter',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white)),
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Pas de compte ? ",
                                  style: TextStyle(fontSize: 16)),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SigninPage()));
                                },
                                child: Text(
                                  "Inscrivez-vous",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
