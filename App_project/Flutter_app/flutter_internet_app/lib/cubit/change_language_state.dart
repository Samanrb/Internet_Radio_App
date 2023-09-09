// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_internet_app/Variables.dart';

@immutable
abstract class ChangeLanguageState {}

class ChangeLanguageInitial extends ChangeLanguageState {}

class ChangeLanguageUpdated extends ChangeLanguageState {
  final Locale locale;

  ChangeLanguageUpdated(this.locale);
}
