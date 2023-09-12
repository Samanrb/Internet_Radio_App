// ignore_for_file: camel_case_types, unused_import, unused_local_variable, prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field, no_leading_underscores_for_local_identifiers, unused_element

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter_internet_app/Variables.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internet_app/change_account.dart';
import 'package:flutter_internet_app/cubit/selected_tab_cubit_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_internet_app/splash_screen.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

void main() {
  runApp(HomeScreen(toggleThemeMode: () {
    if (themeMode == ThemeMode.dark) {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
  }, selectedLanguageChanged: (Language newSelectedLanguageByUser) {
    locale = newSelectedLanguageByUser == Language.en
        ? const Locale('en', '1')
        : const Locale('fa', '98');
  }));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {super.key,
      required Function() toggleThemeMode,
      required Function(Language newSelectedLanguageByUser)
          selectedLanguageChanged});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'Flutter auth',
      // home: BlocProvider(
      //   create: (context) => SelectedTabCubitCubit(),
      //   child: const Auth(),
      // ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SelectedTabCubitCubit(),
          ),
          // BlocProvider<BlocB>(
          //   create: (BuildContext context) => BlocB(),
          // ),
          // BlocProvider<BlocC>(
          //   create: (BuildContext context) => BlocC(),
          // ),
        ],
        child: const HomeScreen_page(),
      ),
    );
  }
}

class HomeScreen_page extends StatefulWidget {
  const HomeScreen_page({super.key});

  @override
  State<HomeScreen_page> createState() => _HomeScreen_pageState();
}

class _HomeScreen_pageState extends State<HomeScreen_page> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    void _onItemTapped(int index) {
      debugPrint('$index');
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: true, //for keyboard
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image(image: AssetImage('assets/images/logo.jpg'))),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyButtonBar(
          ),
    );
  }
}

class MyButtonBar extends StatefulWidget {
  const MyButtonBar({super.key});

  @override
  State<MyButtonBar> createState() => _MyButtonBarState();
}

class _MyButtonBarState extends State<MyButtonBar> {

  void changeSelectedIcon(int value){
    setState(() {
      nowStatus = NotchBottomBarController(index: value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(
          color: Colors.transparent,
          width: 0,
        ),
      ),
      height: 100,
      child: AnimatedNotchBottomBar(
        notchColor: MyAppColors().primaryColor,
        durationInMilliSeconds: 300,
        showBlurBottomBar: true,
        blurOpacity: 1,
        blurFilterX: 10.0,
        blurFilterY: 10.0,
        //pageController: _pageController,
        bottomBarItems: [
          BottomBarItem(
            inActiveItem: Icon(
              Icons.account_circle,
              color: MyAppColors().grayColor,
              size: 25,
            ),
            activeItem: Icon(
              Icons.account_circle,
              color: Colors.white,
              size: 25,
            ),
            itemLabel: localization.profile,
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.home_filled,
              color: MyAppColors().grayColor,
              size: 25,
            ),
            activeItem: Icon(
              Icons.home_filled,
              color: Colors.white,
              size: 25,
            ),
            itemLabel: localization.home,
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.cloud_upload_outlined,
              color: MyAppColors().grayColor,
              size: 25,
            ),
            activeItem: Icon(
              Icons.cloud_upload_outlined,
              color: Colors.white,
              size: 25,
            ),
            itemLabel: localization.profile,
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.search_sharp,
              color: MyAppColors().grayColor,
              size: 25,
            ),
            activeItem: Icon(
              Icons.search_sharp,
              color: Colors.white,
              size: 25,
            ),
            itemLabel: localization.search,
          ),
        ],
        notchBottomBarController: nowStatus,
        onTap: (int value) {
          switch (value) {
            case 0:
              changeSelectedIcon(0);
              debugPrint("select -> Profile");
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      change_account(toggleThemeMode: () {
                        if (themeMode == ThemeMode.dark) {
                          themeMode = ThemeMode.light;
                        } else {
                          themeMode = ThemeMode.dark;
                        }
                      }, selectedLanguageChanged:
                          (Language newSelectedLanguageByUser) {
                        locale = newSelectedLanguageByUser == Language.en
                            ? const Locale('en', '1')
                            : const Locale('fa', '98');
                      }),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    var begin = const Offset(1.0, 1.0);
                    var end = Offset.zero;
                    var curve = Curves.ease;
                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  }));
              break;
            case 1:
              debugPrint("select -> Home");
              changeSelectedIcon(1);

              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      HomeScreen(toggleThemeMode: () {
                        if (themeMode == ThemeMode.dark) {
                          themeMode = ThemeMode.light;
                        } else {
                          themeMode = ThemeMode.dark;
                        }
                      }, selectedLanguageChanged:
                          (Language newSelectedLanguageByUser) {
                        locale = newSelectedLanguageByUser == Language.en
                            ? const Locale('en', '1')
                            : const Locale('fa', '98');
                      }),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    var begin = const Offset(1.0, 1.0);
                    var end = Offset.zero;
                    var curve = Curves.ease;
                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  }));
              break;
            case 2:
              debugPrint("select -> Upload");
              changeSelectedIcon(2);
              break;
            case 3:
              debugPrint("select -> Search");
              changeSelectedIcon(3);
              break;
          }
        
        },
      ),
    );
  }
}
