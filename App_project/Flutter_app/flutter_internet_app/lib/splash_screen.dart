// //ignore_for_file: unused_import, unnecessary_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_internet_app/Login_page.dart';
import 'package:flutter_internet_app/Variables.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => 
          Login_page(toggleThemeMode: () {
        setState(() {
          if (themeMode == ThemeMode.dark) {
            themeMode = ThemeMode.light;
          } else {
            themeMode = ThemeMode.dark;
          }
        });
      }, selectedLanguageChanged: (Language newSelectedLanguageByUser) {
        setState(() {
          locale = newSelectedLanguageByUser == Language.en
              ? const Locale('en','1')
              : const Locale('fa','98');
        });
      }),
          ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Image(image: AssetImage('assets/images/splash_screen.jpg'))),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  width: 250,
                  height: 300,
                  image: AssetImage('assets/images/logo.jpg')),
                  Text("INTERNET RADIO APP",
                  style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),)
              ],
            ),
          )
        ],
    )
    );
  }
}
