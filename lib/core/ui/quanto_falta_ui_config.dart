import 'package:flutter/material.dart';

class TodoListUiConfig {
  TodoListUiConfig._();

  static ThemeData get theme => ThemeData(
        primaryColor: const Color(0xffF0851D),
        primaryColorLight: const Color(0xffF0851D),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffF0851D)),
        ),
      );
}
