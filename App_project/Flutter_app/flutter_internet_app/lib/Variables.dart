// ignore_for_file: file_names, deprecated_member_use, non_constant_identifier_names

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppColors{
  final Color primaryColor = const Color.fromARGB(255, 35, 53, 185);
  final Color? grayColor = Colors.grey[700];
  final Color? alarmColor = Colors.red[300];
}

ThemeMode themeMode = ThemeMode.dark;
Locale locale = const Locale('en');
var nowStatus = NotchBottomBarController(index: 1);


selectedLanguageChanged() {
  if (locale == const Locale('en')) {
    locale = const Locale('fa');
  } else {
    locale = const Locale('en');
  }
}

enum Language {
  en,
  fa,
}

class MyAppThemeConfig {
  static const String faPrimaryFontFamily = 'IranYekan';
  final Color primaryColor = const Color.fromARGB(255, 35, 53, 185);
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color surfaceColor;
  final Color backgroundColor;
  final Color appBarColor;
  final Brightness brightness;

  MyAppThemeConfig.dark()
      : primaryTextColor = Colors.white,
        secondaryTextColor = Colors.white70,
        surfaceColor = const Color(0x0dffffff),
        backgroundColor = const Color.fromARGB(255, 30, 30, 30),
        appBarColor = Colors.black,
        brightness = Brightness.dark;

  MyAppThemeConfig.light()
      : primaryTextColor = Colors.grey.shade900,
        secondaryTextColor = Colors.grey.shade900.withOpacity(0.8),
        surfaceColor = const Color(0x0d000000),
        backgroundColor = Colors.white,
        appBarColor = const Color.fromARGB(255, 235, 235, 235),
        brightness = Brightness.light;

  ThemeData getTheme(String languageCode) {
    return ThemeData(
      primarySwatch: Colors.pink,
      primaryColor: primaryColor,
      brightness: brightness,
      dividerColor: surfaceColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primaryColor),
        ),
      ),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: appBarColor,
          foregroundColor: primaryTextColor),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle:
            const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: surfaceColor,
      ),
      textTheme: languageCode == 'en' ? enPrimaryTextTheme : faPrimaryTextTheme,
    );
  }

  TextTheme get enPrimaryTextTheme => GoogleFonts.latoTextTheme(TextTheme(
        bodyText2: TextStyle(fontSize: 15, color: primaryTextColor),
        bodyText1: TextStyle(fontSize: 13, color: secondaryTextColor),
        headline6:
            TextStyle(fontWeight: FontWeight.bold, color: primaryTextColor),
        subtitle1: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: primaryTextColor),
      ));

  TextTheme get faPrimaryTextTheme => TextTheme(
      bodyText2: TextStyle(
          fontSize: 15,
          height: 1.5,
          color: primaryTextColor,
          fontFamily: faPrimaryFontFamily),
      bodyText1: TextStyle(
          fontSize: 13,
          height: 1.5,
          color: secondaryTextColor,
          fontFamily: faPrimaryFontFamily),
      caption: const TextStyle(fontFamily: faPrimaryFontFamily),
      headline6: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: primaryTextColor,
          fontFamily: faPrimaryFontFamily),
      subtitle1: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: primaryTextColor,
          fontFamily: faPrimaryFontFamily),
      button: const TextStyle(fontFamily: faPrimaryFontFamily));
}

String getMonthName(String formattedDate) {
  List<String> selectedDate = formattedDate.split('-');
  String tempMonth = "";
  switch (selectedDate[1]) {
    case '01':
      tempMonth = "Jan";
      break;
    case '02':
      tempMonth = "Feb";
      break;
    case '03':
      tempMonth = "Mar";
      break;
    case '04':
      tempMonth = "Apr";
      break;
    case '05':
      tempMonth = "May";
      break;
    case '06':
      tempMonth = "Jun";
      break;
    case '07':
      tempMonth = "Jul";
      break;
    case '08':
      tempMonth = "Aug";
      break;
    case '09':
      tempMonth = "Sep";
      break;
    case '10':
      tempMonth = "Oct";
      break;
    case '11':
      tempMonth = "Nov";
      break;
    case '12':
      tempMonth = "Dec";
      break;
    default:
      tempMonth = "err";
      break;
  }
  String selectedDateWithMonth =
      "${selectedDate[0]} $tempMonth ${selectedDate[2]}";
  return selectedDateWithMonth;
}

class Musics {
  final String title;
  final String artist;
  final String filePathPath;
  Musics(this.title, this.artist, this.filePathPath);
}

List<Musics> musicList = List.generate(10, (index) {
  return Musics("Song $index", "Artist $index", "path: $index");
});
