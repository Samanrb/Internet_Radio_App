// ignore_for_file: unused_import, prefer_const_constructors

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'change_language_state.dart';
import 'package:flutter_internet_app/Variables.dart';

class ChangeLanguageCubit extends Cubit<ChangeLanguageState> {
  ChangeLanguageCubit() : super(ChangeLanguageInitial());

  void toggleLanguage(Locale currentLocale) {
    Locale newLocale;
    if (currentLocale.languageCode == 'en') {
      newLocale = Locale('fa');
    } else {
      newLocale = Locale('en');
    }

    emit(ChangeLanguageUpdated(newLocale));
  }
}
