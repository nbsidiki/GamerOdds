import 'package:flutter/material.dart';
import 'package:gamer_oods_flutter_application/ui/login_page.dart';
import 'package:gamer_oods_flutter_application/ui/home_page.dart';
import 'package:gamer_oods_flutter_application/ui/signin_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GamerOdds',
      theme: ThemeData(
        fontFamily: 'BricolageGrotesque',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: "GamerOdds"),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Centrer verticalement
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text('Page de Connexion'),
              ),
              const SizedBox(
                  height:
                      16), // Ajoutez un espacement de 16 pixels entre les boutons
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                child: const Text('Home Page'),
              ),
              const SizedBox(
                  height:
                      16), // Ajoutez un espacement de 16 pixels entre les boutons
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SigninPage()),
                  );
                },
                child: const Text('Signin Page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
