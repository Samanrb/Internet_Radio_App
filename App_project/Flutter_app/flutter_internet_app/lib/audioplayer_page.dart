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
import 'package:audioplayers/audioplayers.dart';


void main() {
  runApp(AudioPlayers(toggleThemeMode: () {
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

class AudioPlayers extends StatefulWidget {
  const AudioPlayers(
      {super.key,
      required Function() toggleThemeMode,
      required Function(Language newSelectedLanguageByUser)
          selectedLanguageChanged});

  @override
  State<AudioPlayers> createState() => _AudioPlayersState();
}

class _AudioPlayersState extends State<AudioPlayers> {
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
        child: const AudioPlayer_page(),
      ),
    );
  }
}

class AudioPlayer_page extends StatefulWidget {
  const AudioPlayer_page({super.key});

  @override
  State<AudioPlayer_page> createState() => _AudioPlayer_pageState();
}

class _AudioPlayer_pageState extends State<AudioPlayer_page> {

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    
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
            AudioPlayerScreen(),
            
          ],
        ),
      ),
      bottomNavigationBar: MyBottonBar(localization),
    );
  }
}


class AudioPlayerScreen extends StatelessWidget {
  const AudioPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(MyAppColors().primaryColor),
              ),
              onPressed: () {
                AudioPlayerManager.playAudioFromAsset('audio/temp_song.mp3');
              },
              child: Text('Play Audio'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(MyAppColors().primaryColor),
              ),
              onPressed: () {
                AudioPlayerManager.pauseAudio();
              },
              child: Text('Pause Audio'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(MyAppColors().primaryColor),
              ),
              onPressed: () {
                AudioPlayerManager.stopAudio();
              },
              child: Text('Stop Audio'),
            ),
          ],
        ),
      
    );
  }
}

class AudioPlayerManager {
  static AudioPlayer audioPlayer = AudioPlayer();

  static Future<void> playAudioFromAsset(String assetPath) async {
    Source audio_source = AssetSource(assetPath);
    await audioPlayer.stop();
    await audioPlayer.play(audio_source);
  }

  static Future<void> pauseAudio() async {
    await audioPlayer.pause();
  }

  static Future<void> stopAudio() async {
    await audioPlayer.stop();
  }
}
