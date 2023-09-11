// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_internet_app/change_account.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internet_app/Variables.dart';
import 'package:flutter_internet_app/cubit/selected_tab_cubit_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

void main() {
  runApp(change_password(toggleThemeMode: () {
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

class change_password extends StatefulWidget {
  final Function() toggleThemeMode;
  final Function(Language language) selectedLanguageChanged;
  const change_password(
      {Key? key,
      required this.toggleThemeMode,
      required this.selectedLanguageChanged})
      : super(key: key);

  @override
  State<change_password> createState() => _change_passwordState();
}

class _change_passwordState extends State<change_password> {

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
      title: 'change_account_page',
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
        child: const change_password_page(),
      ),
    );
  }
}

class change_password_page extends StatefulWidget {
  const change_password_page({super.key});

  @override
  State<change_password_page> createState() => _change_password_pageState();
}

class _change_password_pageState extends State<change_password_page> {
  Language language = Language.en;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Center(
              //logo
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image(image: AssetImage('assets/images/logo.jpg'))),
              ),
            ),
            Expanded(
                child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32)),
                  color: Color.fromARGB(255, 35, 53, 185)),
              child: Column(children: [
                SizedBox(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        localization.simpleFullname,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                      color: Colors.white,
                    ),
                    child: const SingleChildScrollView(
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                          child: account_details_form()),
                    ),
                  ),
                )
              ]),
            ))
          ],
        ),
      ),
    );
  }
}

class account_details_form extends StatefulWidget {
  const account_details_form({super.key});

  @override
  State<account_details_form> createState() => account_details_formState();
}

class account_details_formState extends State<account_details_form> {
  final _signupPass = TextEditingController();
  bool isPasswordOk = false;

  @override
  void dispose() {
    _signupPass.dispose();
    super.dispose();
  }

  void updatePasswordValidation(bool isValid) {
    setState(() {
      isPasswordOk = isValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        height: 20,
      ),
      Row(
        children: [
          Icon(
            Icons.change_circle_outlined,
            color: MyAppColors().primaryColor,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            localization.insertNewPass,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: MyAppColors().primaryColor),
          ),
        ],
      ),
      const SizedBox(
        height: 15,
      ),
      change_password_feild(
        onPasswordValidation: updatePasswordValidation,
        textController: _signupPass,
      ),
      const SizedBox(
        height: 20,
      ),
      ElevatedButton(
        onPressed: isPasswordOk
            ? () {
              //save new password
                debugPrint(
                    "New Password is : ${_signupPass.text}");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => (change_account(
                              toggleThemeMode: () {
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
                          }))),
                );
              }
            : null,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 35, 53, 185)),
            minimumSize: MaterialStateProperty.all(
              Size(MediaQuery.of(context).size.width, 60),
            ),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)))),
        child: Text(
          localization.changePassword,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      const SizedBox(
        height: 25,
      ),
      ElevatedButton(
        onPressed: () {
          //go back
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => (change_account(toggleThemeMode: () {
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
                    }))),
          );
        },
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(MyAppColors().alarmColor),
            minimumSize: MaterialStateProperty.all(
              Size(MediaQuery.of(context).size.width, 60),
            ),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)))),
        child: Text(
          localization.cancel,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
    ]);
  }
}

class change_password_feild extends StatefulWidget {
  final TextEditingController textController;
  final Function(bool isValid) onPasswordValidation;
  const change_password_feild({
    Key? key,
    required this.onPasswordValidation,
    required this.textController,
  }) : super(key: key);

  @override
  State<change_password_feild> createState() => _change_password_feildState();
}

class _change_password_feildState extends State<change_password_feild> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Column(children: [
      TextField(
        controller: widget.textController, // Use the controller from the widget
        obscureText: obscureText,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
          label: Text(
            localization.password,
            style: TextStyle(color: MyAppColors().primaryColor),
          ),
          suffix: InkWell(
            onTap: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
            child: Text(
              obscureText ? localization.show : localization.hide,
              style: TextStyle(fontSize: 14, color: MyAppColors().primaryColor),
            ),
          ),
        ),
      ),
      FlutterPwValidator(
        controller: widget.textController,
        minLength: 8,
        uppercaseCharCount: 1,
        lowercaseCharCount: 1,
        numericCharCount: 2,
        specialCharCount: 1,
        width: 400,
        height: 150,
        onSuccess: () {
          widget.onPasswordValidation(true);
        },
        onFail: () {
          widget.onPasswordValidation(false);
        },
        successColor: MyAppColors().primaryColor,
      )
    ]);
  }
}
