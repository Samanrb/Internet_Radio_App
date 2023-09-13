// ignore_for_file: camel_case_types, unused_import, unused_local_variable, prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field, no_leading_underscores_for_local_identifiers, unused_element, non_constant_identifier_names

import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter_internet_app/Variables.dart';
import 'package:flutter_internet_app/bottomBar.dart';
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
            SizedBox(
              height: 20,
            ),
            Expanded(child: Music_List())
          ],
        ),
      ),
      bottomNavigationBar: MyBottonBar(localization),
    );
  }
}

class Music_List extends StatefulWidget {
  const Music_List({
    super.key,
  });

  @override
  State<Music_List> createState() => _Music_ListState();
}

class _Music_ListState extends State<Music_List> {
  List<Musics> musicList = List.generate(15, (index) {
    return Musics("Song $index", "Artist $index", "path: $index");
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: musicList.length,
      itemBuilder: (context, index) {
        final music = musicList[index];
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: Image(
                    image: AssetImage('assets/images/temp_axs.jpg'),
                    height: 60,
                    width: 60,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      music.title,
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(music.artist),
                  ],
                ),
                Expanded(child: SizedBox()),
                IconButton(
                  icon: Icon(
                    Icons.play_circle,
                    size: 35,
                    color: MyAppColors().primaryColor,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    size: 35,
                    color: MyAppColors().primaryColor,
                  ),
                  onPressed: () {
                    debugPrint('should delete song $index');
                    setState(() {
                      musicList.remove(musicList[index]);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 2),
                        content:
                            Center(child: Text('${music.title} removed'))));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
