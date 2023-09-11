import 'package:flutter/material.dart';
import 'package:flutter_internet_app/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_internet_app/Variables.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Internet Radio',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: locale,
      theme: themeMode == ThemeMode.dark
          ? MyAppThemeConfig.dark().getTheme(locale.languageCode)
          : MyAppThemeConfig.light().getTheme(locale.languageCode),
      home: const SplashScreen()
      //all details of login_page has passed to splash screen navigator
    );
  }
}
