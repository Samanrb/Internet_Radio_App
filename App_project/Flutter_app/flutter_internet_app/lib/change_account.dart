// ignore_for_file: unnecessary_const, deprecated_member_use, camel_case_types, unused_element, no_leading_underscores_for_local_identifiers, unused_local_variable, file_names, prefer_final_fields, unused_field, unused_import, prefer_const_literals_to_create_immutables, unnecessary_import, non_constant_identifier_names, avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internet_app/Variables.dart';
import 'package:flutter_internet_app/cubit/selected_tab_cubit_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_internet_app/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

void main() {
  runApp(change_account(toggleThemeMode: () {
    if (themeMode == ThemeMode.dark) {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
  }, selectedLanguageChanged: (Language newSelectedLanguageByUser) {
    locale = newSelectedLanguageByUser == Language.en
        ? Locale('en', '1')
        : Locale('fa', '98');
  }));
}

class change_account extends StatefulWidget {
  final Function() toggleThemeMode;
  final Function(Language _language) selectedLanguageChanged;
  const change_account(
      {Key? key,
      required this.toggleThemeMode,
      required this.selectedLanguageChanged})
      : super(key: key);

  @override
  State<change_account> createState() => _change_accountState();
}

class _change_accountState extends State<change_account> {
  Language _language = Language.en;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: locale,
      localizationsDelegates: [
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
        child: const change_account_page(),
      ),
    );
  }
}

class change_account_page extends StatefulWidget {
  const change_account_page({super.key});

  @override
  State<change_account_page> createState() => _change_account_pageState();
}

class _change_account_pageState extends State<change_account_page> {
  Language language = Language.en;

  void ChangeLanguage() {
    debugPrint("change language");
    print(language);
    print(locale);
    setState(() {
      if (locale.languageCode == 'en') {
        language == Language.fa;
        locale = Locale('fa');
      } else {
        language == Language.en;
        locale = Locale('en');
      }
    });
    print(language);
    print(locale);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            SplashScreen())); //it goes to splash screen and then it comes back with selected langauge
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 5, 12, 0),
                  child: GestureDetector(
                    child: SizedBox(
                        width: 40,
                        height: 40,
                        child: locale.languageCode == 'en'
                            ? const Image(
                                image: AssetImage('assets/images/en_logo.jpg'))
                            : const Image(
                                image:
                                    AssetImage('assets/images/fa_logo.jpg'))),
                    onTap: () {
                      ChangeLanguage();
                    },
                  ),
                ),
              ],
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.all(40.0),
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
                        "Saman Rostam Beigi",
                        style: TextStyle(
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
                    child: SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
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
  final _signupEmail = TextEditingController();
  final _signupPass = TextEditingController();
  final _signupName = TextEditingController();
  bool isPasswordOk = false;

  @override
  void dispose() {
    _signupEmail.dispose();
    _signupPass.dispose();
    _signupName.dispose();
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
      Row(
        children: [
          Icon(
            Icons.alternate_email,
            color: MyAppColors().grayColor,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "Email",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: MyAppColors().grayColor),
          ),
        ],
      ),
      const SizedBox(
        height: 15,
      ),
      TextFormField(
        autocorrect: false,
        showCursor: false,
        enabled: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          suffixIcon: Icon(
            Icons.lock_outline_rounded,
            size: 30,
          ),
          suffixIconColor: MyAppColors().primaryColor,
          hintText: localization.simpleEmail,
          hintStyle: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        children: [
          Icon(
            Icons.account_circle_outlined,
            color: MyAppColors().grayColor,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            localization.fullname,
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: MyAppColors().grayColor),
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),

      TextFormField(
        autocorrect: false,
        showCursor: true,
        enabled: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          suffixIcon: Icon(
            Icons.lock_open,
            size: 30,
          ),
          suffixIconColor: MyAppColors().primaryColor,
          hintText: localization.simpleFullname,
          hintStyle: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        children: [
          Icon(
            Icons.date_range_outlined,
            color: MyAppColors().grayColor,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "Birth",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: MyAppColors().grayColor),
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Birthday_change(),
      const SizedBox(
        height: 10,
      ),
      Text(
        "Change Password",
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
      ),
      const SizedBox(
        height: 25,
      ),
      ElevatedButton(
        onPressed: () {
          debugPrint(
              //todo send new information to database
              "Fullname:  ${_signupName.text}\nUsername:  ${_signupEmail.text}\nPass:  ${_signupPass.text}");
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => Show_inputs(
          //           _signupEmail.text, _signupPass.text, _signupName.text)),
          // );
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 35, 53, 185)),
            minimumSize: MaterialStateProperty.all(
              Size(MediaQuery.of(context).size.width, 60),
            ),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)))),
        child: Text(
          "Save Changes",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      const SizedBox(
        height: 25,
      ),
      ElevatedButton(
        //logout
        onPressed: () {
          //todo send new information to database
          debugPrint(
              "Fullname:  ${_signupName.text}\nUsername:  ${_signupEmail.text}\nPass:  ${_signupPass.text}");
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red[300]),
            minimumSize: MaterialStateProperty.all(
              Size(MediaQuery.of(context).size.width, 60),
            ),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Logout",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.logout,
              size: 25,
            ),
          ],
        ),
      ),
    ]);
  }
}

class Birthday_change extends StatefulWidget {
  const Birthday_change({super.key});

  @override
  State<Birthday_change> createState() => _Birthday_changeState();
}

class _Birthday_changeState extends State<Birthday_change> {
  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: TextField(
      controller: dateInput,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        suffixIcon: Icon(
          Icons.lock_open,
          size: 30,
        ),
        suffixIconColor: MyAppColors().primaryColor,
        hintStyle: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        hintText: "Enter Date",
      ),

      readOnly: true,
      //set it true, so that user will not able to edit text
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1950),
          //DateTime.now() - not to allow to choose before today.
          lastDate: DateTime(2100),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor:
                    MyAppColors().primaryColor, // Header background color
                colorScheme: ColorScheme.light(
                    primary: MyAppColors().primaryColor), // Active text color
                buttonTheme: ButtonThemeData(
                    textTheme: ButtonTextTheme.primary), // Button text color
              ),
              child: child!,
            );
          },
        );

        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          setState(() {
            dateInput.text = getMonthName(formattedDate);
            debugPrint(formattedDate);
          });
        } else {}
      },
    ));
  }
}