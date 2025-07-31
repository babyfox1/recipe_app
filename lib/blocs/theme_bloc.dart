import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ThemeState {
  ThemeData get themeData;
}

class LightThemeState extends ThemeState {
  @override
  ThemeData get themeData => ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      );
}

class DarkThemeState extends ThemeState {
  @override
  ThemeData get themeData => ThemeData(
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.dark,
      );
}

abstract class ThemeEvent {}

class ToggleTheme extends ThemeEvent {}

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(LightThemeState()) {
    on<ToggleTheme>((event, emit) {
      if (state is LightThemeState) {
        emit(DarkThemeState());
      } else {
        emit(LightThemeState());
      }
    });
  }
}