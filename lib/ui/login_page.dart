import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Container(
                  padding: const EdgeInsets.only(top: 9, right: 5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary:
                          Color(0xff5E28D1), // Couleur violette pour le bouton
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SigninPage()),
                      );
                    },
                    child: const Text('Inscription',
                        style: TextStyle(fontSize: 25, color: Colors.white)),
                  ),
                ),
              ]),
              Container(
                margin: const EdgeInsets.only(top: 200),
                padding: EdgeInsets.only(left: 155),
                child: Row(
                  children: [
                    Text("Feels the",
                        style: TextStyle(fontSize: 25, color: Colors.white)),
                    Text("Game",
                        style: TextStyle(fontSize: 35, color: Colors.white)),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 0.0, top: 380.0),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Bienvenue sur \n GamerOdds',
                              style:
                                  TextStyle(fontSize: 28, color: Colors.black)),
                          TextField(
                              controller: emailController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                labelText: 'Username',
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(),
                              )),
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
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(
                                    0xff5E28D1), // Couleur violette pour le bouton
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
