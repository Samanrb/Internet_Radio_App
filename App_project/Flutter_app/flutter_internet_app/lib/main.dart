// ignore_for_file: camel_case_types, file_names, prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables, unused_field, no_leading_underscores_for_local_identifiers, library_private_types_in_public_api, prefer_final_fields, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_internet_app/Login_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
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
      title: 'Internet Radio',
      localizationsDelegates: [
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
      home: Login_page(toggleThemeMode: () {
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
              ? Locale('en','1')
              : Locale('fa','98');
        });
      }),
    );
  }
}
