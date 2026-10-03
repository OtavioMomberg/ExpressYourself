import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

final class AppThemes._() {
  static const white = Color.fromARGB(255, 228, 247, 255);
  static const blueLight = Color.fromARGB(255, 212, 242, 255);
  static const blueLight2 = Color.fromARGB(255, 148, 221, 255);

  static const textBlueDark = Color.fromARGB(255, 11, 48, 66);
  static const textYellow = Color.fromARGB(255, 255, 209, 44);
  static const textBlue = Color.fromARGB(255, 68, 138, 255);
  static const textRed = Color.fromARGB(255, 244, 67, 54);
  static const textPurple = Color.fromARGB(255, 224, 64, 251);
  static const textGreen = Color.fromARGB(255, 76, 175, 80);

  static const primaryColorSet = [textBlueDark, textYellow, textBlue];

  static const secondaryColorSet = [textRed, textPurple, textGreen];

  static const gradient = LinearGradient(
    begin: .topCenter,
    end: .bottomCenter,
    colors: [white, blueLight, blueLight2],
  );

  static const systemOverlayStyle = SystemUiOverlayStyle(
    statusBarIconBrightness: .dark,
    statusBarColor: white,
    systemStatusBarContrastEnforced: false,
    systemNavigationBarIconBrightness: .dark,
    systemNavigationBarColor: blueLight2,
    systemNavigationBarContrastEnforced: false,
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
      color: AppThemes.textBlueDark.withValues(alpha: .6)
    ),
  );
}
