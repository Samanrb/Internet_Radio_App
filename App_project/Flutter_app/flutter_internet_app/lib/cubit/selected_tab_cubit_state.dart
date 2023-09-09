part of 'selected_tab_cubit_cubit.dart';

@immutable
sealed class SelectedTabCubitState {}

class SelectedTabCubitInitial extends SelectedTabCubitState {}

class SelectedTabChanged extends SelectedTabCubitState {
  final SelectedTab selectedTab;

  SelectedTabChanged(this.selectedTab);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectedTabChanged &&
          runtimeType == other.runtimeType &&
          selectedTab == other.selectedTab;

  @override
  int get hashCode => selectedTab.hashCode;
}
