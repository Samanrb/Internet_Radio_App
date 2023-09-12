
// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_internet_app/Variables.dart';
import 'package:flutter_internet_app/change_account.dart';
import 'package:flutter_internet_app/home_page.dart';

class MyBottonBar extends StatefulWidget {
  final AppLocalizations localization;
  const MyBottonBar(this.localization, {super.key});

  @override
  State<MyBottonBar> createState() => _MyBottonBarState();
}

class _MyBottonBarState extends State<MyBottonBar> {
  AppLocalizations get localization => widget.localization;

  void changeSelectedIcon(int value){
    setState(() {
      nowStatus = NotchBottomBarController(index: value);
    });
  }

  @override
  Widget build(BuildContext context) {
    // final localization = AppLocalizations.of(context)!;
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
            activeItem: const Icon(
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
            activeItem: const Icon(
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
            activeItem: const Icon(
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
            activeItem: const Icon(
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
