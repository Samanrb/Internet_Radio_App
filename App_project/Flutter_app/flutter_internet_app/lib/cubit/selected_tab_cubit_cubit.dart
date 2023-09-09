// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'selected_tab_cubit_state.dart';

enum SelectedTab { login, signup }

class SelectedTabCubitCubit extends Cubit<SelectedTabCubitState> {
  SelectedTabCubitCubit() : super(SelectedTabCubitInitial());

  //void changeTab(state) => emit(state);

  void changeTab(SelectedTab selectedTab) {
    emit(SelectedTabChanged(selectedTab));
  }

}
