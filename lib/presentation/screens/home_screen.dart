import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:message_app/core/di/home_di.dart';
import 'package:message_app/core/utils/snackbar_mixin.dart';
import 'package:message_app/core/routes/app_routes.dart';
import 'package:message_app/core/themes/app_themes.dart';
import 'package:message_app/presentation/widgets/home_widgets.dart';
import 'package:message_app/presentation/screens/send_letter_screen.dart';
import 'package:message_app/presentation/widgets/privacy_dialog.dart';

class const HomeScreen({super.key}) extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SnackbarMixin, PrivacyDialog {
  final controller = TextEditingController();
  final textNode = FocusNode();
  Color textColor = AppThemes.textBlueDark;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!HomeDeps.verifyPrivacy.showPrivacyScreen) { return; }
      showPrivacyDialog(
        context: context,
        onPressed: () async {
          HomeDeps.audioService.playButtonAudio();
          await HomeDeps.verifyPrivacy.changePrefs();

          if (!mounted) { return; }
          Navigator.pop(context);
        },
      );
    });
  }

  @override
  void dispose() {
    HomeDeps.audioService.buttonPlayer.dispose();
    HomeDeps.audioService.colorPlayer.dispose();
    HomeDeps.wordCount.disposeWordNotifier().dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemes.appBar,
      backgroundColor: AppThemes.blueLight2,
      body: FormattedContainer(
        child: SafeArea(
          child: Column(
            spacing: 5,
            children: <Widget>[
              const Text(
                "Cores de Fonte",
                style: TextStyle(
                  color: AppThemes.textBlueDark, 
                  fontSize: 20
                ),
              ),
              ColorSelector(
                onTap: ({required index}) {
                  setState(() {
                    if (index < indexFactor) {
                      textColor = AppThemes.primaryColorSet[index];
                      return;
                    }
                    textColor = AppThemes.secondaryColorSet[
                      (index ~/ indexFactor) - indexNormalizer];
                  });
                },
              ),
              Expanded(
                child: DragTarget<Color>(
                  builder: (_, item, _) {
                    return TextArea(
                      label: "Expresse seus pensamentos...",
                      controller: controller,
                      color: item.isEmpty ? textColor : item.first!,
                      node: textNode,
                      wordCount: HomeDeps.wordCount,
                    );
                  },
                  onAcceptWithDetails: (details) async {
                    setState(() => textColor = details.data);
                    HomeDeps.audioService.playColorAudio();
                  },
                ),
              ),
              const SizedBox(height: 15),
              ButtonRow(
                sendButton: _sendLetter,
                copyButton: _copyText,
                clearButton: _clearText,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendLetter() {
    HomeDeps.audioService.playColorAudio();
    if (controller.text.isEmpty) { return; }
    HomeDeps.audioService.playButtonAudio();

    if (!mounted) { return; }
    Navigator.push(
      context,
      AppRoutes.getRoute(screen: const SendLetterScreen()),
    ).then((_) {
      textNode.unfocus();
      if (controller.text.isNotEmpty) {
        controller.clear();
        HomeDeps.wordCount.resetWordNumber();
      }
    });
  }

  void _copyText() async {
    HomeDeps.audioService.playColorAudio();
    if (controller.text.isEmpty) { return; }
    HomeDeps.audioService.playButtonAudio();

    await Clipboard.setData(ClipboardData(text: controller.text));

    if (!mounted) { return; }
    getSnackbar(
      context: context,
      label: "Texto copiado para área de transferências!",
      labelColor: AppThemes.textBlueDark,
      backgroundColor: AppThemes.white,
      behavior: .floating,
      margin: const .only(bottom: 85, left: 14, right: 14),
      padding: const .all(15),
    );
    textNode.unfocus();
  }

  void _clearText() {
    HomeDeps.audioService.playColorAudio();
    if (controller.text.isEmpty) { return; }
    HomeDeps.audioService.playButtonAudio();

    HomeDeps.wordCount.resetWordNumber();
    controller.clear();
  }
}