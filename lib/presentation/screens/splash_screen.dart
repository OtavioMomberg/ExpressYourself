import 'package:material_ui/material_ui.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:message_app/core/utils/user_preferences.dart';
import 'package:message_app/core/utils/audio_service.dart';
import 'package:message_app/core/routes/app_routes.dart';
import 'package:message_app/core/themes/app_themes.dart';
import 'package:message_app/presentation/widgets/formatted_container.dart';
import 'package:message_app/presentation/screens/home_screen.dart';
import 'package:message_app/presentation/screens/privacy_screen.dart';

class const SplashScreen({super.key}) extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final userPrefs = VerifyPrivacyScreen.instance();
  final audioService = AudioService.instance();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    audioService.init();
    await userPrefs.loadPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemes.appBar,
      backgroundColor: AppThemes.blueLight2,
      body: FormattedContainer(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: .center,
            children: <Widget>[
              SizedBox(
                width: .infinity,
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 28,
                    color: AppThemes.textBlueDark,
                    fontFamily: "ChelseaMarket",
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        "Express Yourself",
                        textAlign: .center,
                        speed: const Duration(milliseconds: 170),
                      ),
                    ],
                    isRepeatingAnimation: false,
                    onFinished: () {
                      Navigator.pushReplacement(
                        context,
                        AppRoutes.getRoute(
                          screen: userPrefs.showPrivacyScreen
                              ? PrivacyScreen(
                                  audioService: audioService,
                                  verifyPrivacy: userPrefs,
                                )
                              : const HomeScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
