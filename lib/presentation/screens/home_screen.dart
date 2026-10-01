import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:message_app/core/utils/audio_service.dart';
import 'package:message_app/core/utils/snackbar_mixin.dart';
import 'package:message_app/core/routes/app_routes.dart';
import 'package:message_app/core/themes/app_themes.dart';
import 'package:message_app/core/utils/verify_privacy_terms.dart';
import 'package:message_app/presentation/widgets/home_widgets.dart';
import 'package:message_app/presentation/screens/send_letter_screen.dart';
import 'package:message_app/presentation/widgets/privacy_dialog.dart';

class const HomeScreen({super.key}) extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SnackbarMixin, PrivacyDialog {
  final audioService = AudioService.instance();
  final verifyPrivacy = VerifyPrivacyTerms.instance();
  final controller = TextEditingController();
  final textNode = FocusNode();
  Color textColor = AppThemes.textBlueDark;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!verifyPrivacy.showPrivacyScreen) { return; }
      showPrivacyDialog(
        context: context,
        onPressed: () async {
          audioService.playButtonAudio();
          await verifyPrivacy.changePrefs();

          if (!mounted) { return; }
          Navigator.pop(context);
        },
      );  
    });
  }

  @override
  void dispose() {
    audioService.buttonPlayer.dispose();
    audioService.colorPlayer.dispose();
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
                style: TextStyle(color: AppThemes.textBlueDark, fontSize: 20),
              ),
              ColorSelector(
                onTap: ({required index}) {
                  setState(() {
                    if (index < 3) {
                      textColor = AppThemes.primaryColorSet[index];
                      return;
                    }
                    textColor = AppThemes.secondaryColorSet[
                      (index~/indexFactor)-indexNormalizer];
                  });
                },
              ),
              Expanded(
                child: DragTarget<Color>(
                  builder: (context, item, _) {
                    return TextArea(
                      label: "Expresse seus pensamentos...",
                      controller: controller,
                      color: item.isEmpty ? textColor : item.first!,
                      node: textNode,
                    );
                  },
                  onAcceptWithDetails: (details) async {
                    setState(() => textColor = details.data);
                    audioService.playColorAudio();
                  },
                ),
              ),
              const SizedBox(height: 2),
              ButtonRow(
                sendButton: _sendLetter,
                copyButton: _copyText,
                clearButton: () {
                  audioService.playButtonAudio();
                  if (controller.text.isEmpty) {
                    return;
                  }
                  controller.clear();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendLetter() {
    if (controller.text.isEmpty) {
      audioService.playColorAudio();
      getSnackbar(
        context: context,
        label: "Não é possível enviar conteúdo vazio.",
        labelColor: AppThemes.textBlueDark,
        backgroundColor: AppThemes.white,
        behavior: .floating,
        margin: const .only(bottom: 85, left: 14, right: 14),
        padding: const .all(15),
      );
      return;
    }
    audioService.playButtonAudio();

    if (!mounted) { return; }
    Navigator.push(
      context,
      AppRoutes.getRoute(screen: const SendLetterScreen()),
    ).then((_) {
      textNode.unfocus();
      if (controller.text.isNotEmpty) {
        controller.clear();
      }
    });
  }

  void _copyText() async {
    showPrivacyDialog(
        context: context,
        onPressed: () async {
          audioService.playButtonAudio();
          await verifyPrivacy.changePrefs();

          if (!mounted) { return; }
          Navigator.pop(context);
        },
      );  

    audioService.playButtonAudio();

    if (controller.text.isEmpty) { return; }

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
}
