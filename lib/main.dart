import 'package:material_ui/material_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:message_app/core/themes/app_themes.dart';
import 'package:message_app/presentation/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString("assets/fonts/OFL.txt");
    yield LicenseEntryWithLineBreaks(["Google Fonts - ChelseaMarket"], license);
  });

  await SystemChrome.setPreferredOrientations([.portraitUp, .portraitDown]);

  runApp(const ExpressYourself());
}

class const ExpressYourself({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Express Yourself",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: AppThemes.white),
        fontFamily: "ChelseaMarket",
      ),
      home: const SplashScreen()
    );
  }
}
