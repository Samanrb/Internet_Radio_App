// ignore_for_file: unnecessary_const, deprecated_member_use, camel_case_types, unused_element, no_leading_underscores_for_local_identifiers, unused_local_variable, file_names, prefer_final_fields, unused_field, unused_import, prefer_const_literals_to_create_immutables, unnecessary_import, non_constant_identifier_names, avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internet_app/Variables.dart';
import 'package:flutter_internet_app/cubit/selected_tab_cubit_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Login_page extends StatefulWidget {
  final Function() toggleThemeMode;
  final Function(Language _language) selectedLanguageChanged;
  const Login_page(
      {Key? key,
      required this.toggleThemeMode,
      required this.selectedLanguageChanged})
      : super(key: key);

  @override
  State<Login_page> createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
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
        child: const Auth(),
      ),
    );
  }
}

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
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
                      BlocBuilder<SelectedTabCubitCubit, SelectedTabCubitState>(
                        builder: (context, state) {
                          final selectedTab = state is SelectedTabChanged
                              ? state.selectedTab
                              : SelectedTab.login;
                          return TextButton(
                            onPressed: () {
                              debugPrint('select -> login');
                              context
                                  .read<SelectedTabCubitCubit>()
                                  .changeTab(SelectedTab.login);
                            },
                            child: Text(
                              localization.login,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.normal,
                                color: selectedTab == SelectedTab.login
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                            ),
                          );
                        },
                      ),
                      BlocBuilder<SelectedTabCubitCubit, SelectedTabCubitState>(
                        builder: (context, state) {
                          final selectedTab = state is SelectedTabChanged
                              ? state.selectedTab
                              : SelectedTab.login;
                          return TextButton(
                            onPressed: () {
                              debugPrint('select -> sign up');
                              context
                                  .read<SelectedTabCubitCubit>()
                                  .changeTab(SelectedTab.signup);
                            },
                            child: Text(
                              localization.signup,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.normal,
                                color: selectedTab == SelectedTab.signup
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child:
                      BlocBuilder<SelectedTabCubitCubit, SelectedTabCubitState>(
                    builder: (context, state) {
                      final selectedTab = state is SelectedTabChanged
                          ? state.selectedTab
                          : SelectedTab.login;
                      return Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          ),
                          color: Colors.white,
                        ),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 40, 30, 30),
                            child: selectedTab == SelectedTab.login
                                ? const _login_page()
                                : const _signup_page(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ]),
            ))
          ],
        ),
      ),
    );
  }
}

class _login_page extends StatefulWidget {
  const _login_page({super.key});

  @override
  State<_login_page> createState() => __login_pageState();
}

class __login_pageState extends State<_login_page> {
  final _loginEmail = TextEditingController();
  final _loginPass = TextEditingController();
  

  @override
  void dispose() {
    _loginEmail.dispose();
    _loginPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localization.welcomeBack,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          localization.signInText,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
        ),
        const SizedBox(
          height: 16,
        ),
        TextField(
          autocorrect: false,
          controller: _loginEmail,
          decoration: InputDecoration(label: Text(localization.username)),
        ),
        PasswordTextField(textController: _loginPass),
        const SizedBox(
          height: 24,
        ),
        ElevatedButton(
          onPressed: () {
            debugPrint(
                "Username:  ${_loginEmail.text}\nPass:  ${_loginPass.text}");
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => Show_inputs.withoutName(_loginEmail.text,_loginPass.text)),
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
            localization.login,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(localization.forgotPass),
            const SizedBox(
              width: 8,
            ),
            TextButton(
              onPressed: () {},
              child: Text(localization.resetHere),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Center(
          child: Text(
            localization.signInWith,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/Google.jpg'),
              const SizedBox(
                width: 24,
              ),
              Image.asset('assets/images/Facebook.jpg'),
              const SizedBox(
                width: 24,
              ),
              Image.asset('assets/images/Twitter.jpg'),
            ],
          ),
        )
      ],
    );
  }
}

class _signup_page extends StatefulWidget {
  const _signup_page({super.key});

  @override
  State<_signup_page> createState() => __signup_pageState();
}

class __signup_pageState extends State<_signup_page> {
  final _signupEmail = TextEditingController();
  final _signupPass = TextEditingController();
  final _signupName = TextEditingController();

  @override
  void dispose() {
    _signupEmail.dispose();
    _signupPass.dispose();
    _signupName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localization.welcomeBack,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          localization.enterYourInforation,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
        ),
        const SizedBox(
          height: 16,
        ),
        TextField(
          autocorrect: false,
          controller: _signupName,
          decoration: InputDecoration(label: Text(localization.fullname)),
        ),
        TextField(
          autocorrect: false,
          controller: _signupEmail,
          decoration: InputDecoration(label: Text(localization.username)),
        ),
        PasswordTextField(textController: _signupPass),
        const SizedBox(
          height: 24,
        ),
        ElevatedButton(
          onPressed: () {
            debugPrint(
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
            localization.signup,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Center(
          child: Text(
            localization.signInWith,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/Google.jpg'),
              const SizedBox(
                width: 24,
              ),
              Image.asset('assets/images/Facebook.jpg'),
              const SizedBox(
                width: 24,
              ),
              Image.asset('assets/images/Twitter.jpg'),
            ],
          ),
        )
      ],
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final TextEditingController textController;

  const PasswordTextField({
    Key? key,
    required this.textController,
  }) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool obscureText = true;
  
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return TextField(
      controller: widget.textController, // Use the controller from the widget
      obscureText: obscureText,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
        label: Text(localization.password),
        suffix: InkWell(
          onTap: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          child: Text(
            obscureText ? localization.show : localization.hide,
            style: TextStyle(
                fontSize: 14, color: Theme.of(context).colorScheme.primary),
          ),
        ),
      ),
    );
  }
}
