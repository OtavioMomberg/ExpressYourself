import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

final class AppThemes._() {
  static const white = Color.fromARGB(255, 228, 247, 255);
  static const blueMiddle = Color.fromARGB(255, 212, 242, 255);
  static const blueFinal = Color.fromARGB(255, 148, 221, 255);
  static const fontColor = Color.fromARGB(255, 11, 48, 66);
  static const yellow = Color.fromARGB(255, 255, 209, 44);
  static const blue = Color.fromARGB(255, 68, 138, 255);
  static const red = Color.fromARGB(255, 244, 67, 54);
  static const purple = Color.fromARGB(255, 224, 64, 251);
  static const green = Color.fromARGB(255, 76, 175, 80);

  static const primaryColorSet = [
    fontColor,
    yellow,
    blue,
  ];

  static const secondaryColorSet = [
    red, 
    purple, 
    green
  ];  

  static const gradient = LinearGradient(
    begin: .topCenter,
    end: .bottomCenter,
    colors: [
      white,
      blueMiddle,
      blueFinal
    ]
  );

  static const systemOverlayStyle = SystemUiOverlayStyle(
    statusBarIconBrightness: .dark,
    statusBarColor: white,
    systemStatusBarContrastEnforced: false,
    systemNavigationBarIconBrightness: .dark,
    systemNavigationBarColor: blueFinal,
    systemNavigationBarContrastEnforced: false
  );

  static final appBar = AppBar(
    toolbarHeight: 0,
    backgroundColor: white,
    surfaceTintColor: Colors.transparent,
    systemOverlayStyle: systemOverlayStyle,
  );

  static final inputBoarder = OutlineInputBorder(
    borderRadius: const .all(.circular(12)),
    borderSide: BorderSide(
      color: AppThemes.fontColor.withValues(alpha: .6),
    ),
  );
}