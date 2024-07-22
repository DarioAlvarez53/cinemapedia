import 'package:flutter/material.dart';

class AppTheme {
  //configuarcion de tema inicial
  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: const Color(0xff2862f5)
  );
}