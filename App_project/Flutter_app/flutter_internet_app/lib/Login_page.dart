// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internet_app/Variables.dart';
import 'package:flutter_internet_app/change_account.dart';
import 'package:flutter_internet_app/cubit/selected_tab_cubit_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_internet_app/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

class Login_page extends StatefulWidget {
  final Function() toggleThemeMode;
  final Function(Language language) selectedLanguageChanged;
  const Login_page(
      {Key? key,
      required this.toggleThemeMode,
      required this.selectedLanguageChanged})
      : super(key: key);

  @override
  State<Login_page> createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {

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
    print(locale);
    setState(() {
      if (locale.languageCode == 'en') {
        language == Language.fa;
        locale = const Locale('fa');
      } else {
        language == Language.en;
        locale = const Locale('en');
      }
    });
    print(locale);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            const SplashScreen())); //it goes to splash screen and then it comes back with selected langauge
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      resizeToAvoidBottomInset: true,//for keyboard
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
                padding: EdgeInsets.all(10.0),
                child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image(image: AssetImage('assets/images/logo.jpg'))),
              ),
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32)),
                  color: MyAppColors().primaryColor),
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
                                    : MyAppColors().grayColor,
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
                                    : MyAppColors().grayColor,
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
                          //reverse: true,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
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
  const _login_page();

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
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          localization.signInText,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
        ),
        const SizedBox(
          height: 16,
        ),
        TextField(
          //email
          autocorrect: false,
          controller: _loginEmail,
          decoration: InputDecoration(label: Text(localization.email),labelStyle: TextStyle(color: MyAppColors().primaryColor)),
        ),
        PasswordTextField(
          textController: _loginPass,
          onPasswordValidation: (bool isValid) {},
        ),
        const SizedBox(
          height: 24,
        ),
        ElevatedButton(
          onPressed: () {

            debugPrint(
                "Username:  ${_loginEmail.text}\nPass:  ${_loginPass.text}");
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
              backgroundColor: MaterialStateProperty.all(
                  MyAppColors().primaryColor),
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
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
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
  const _signup_page();

  @override
  State<_signup_page> createState() => _signup_pageState();
}

class _signup_pageState extends State<_signup_page> {
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
      Text(
        localization.welcomeBack,
        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
      ),
      const SizedBox(
        height: 5,
      ),
      Text(
        localization.enterYourInforation,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
      ),
      const SizedBox(
        height: 5,
      ),
      TextField(
        //Fullname
        autocorrect: false,
        controller: _signupName,
        decoration: InputDecoration(label: Text(localization.fullname),labelStyle: TextStyle(color: MyAppColors().primaryColor)),
      ),
      TextField(
        //email
        autocorrect: false,
        controller: _signupEmail,
        decoration: InputDecoration(label: Text(localization.email,),labelStyle: TextStyle(color: MyAppColors().primaryColor)),
      ),
      PasswordTextField(
        textController: _signupPass,
        onPasswordValidation: updatePasswordValidation,
      ),
      ElevatedButton(
        onPressed: isPasswordOk &&
                _signupName.text.isNotEmpty &&
                _signupEmail.text.isNotEmpty
            ? () {
                debugPrint(
                    "Fullname:  ${_signupName.text}\nUsername:  ${_signupEmail.text}\nPass:  ${_signupPass.text}");
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => Show_inputs(
                //           _signupEmail.text, _signupPass.text, _signupName.text)),
                // );
              }
            : null,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                MyAppColors().primaryColor),
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
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
        ),
      ),
      Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset('assets/images/Google.jpg'),
            const SizedBox(
              width: 24,
            ),
            Image.asset('assets/images/Facebook.jpg'),
            const SizedBox(
              width: 24,
            ),
            Image.asset('assets/images/Twitter.jpg'),
          ]))
    ]);
  }
}

class PasswordTextField extends StatefulWidget {
  final TextEditingController textController;
  final Function(bool isValid) onPasswordValidation;

  const PasswordTextField({
    Key? key,
    required this.textController,
    required this.onPasswordValidation,
  }) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Column(
      children: [
        TextField(
          controller:
              widget.textController, // Use the controller from the widget
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
                style: TextStyle(
                    fontSize: 14, color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ),
        ),
        BlocBuilder<SelectedTabCubitCubit, SelectedTabCubitState>(
          builder: (context, state) {
            final selectedTab = state is SelectedTabChanged
                ? state.selectedTab
                : SelectedTab.login;
            if (selectedTab == SelectedTab.signup) {
              return FlutterPwValidator(
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
              );
            } else {
              return const SizedBox(
                height: 1,
              );
            }
          },
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
