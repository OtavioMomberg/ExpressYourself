import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:message_app/core/utils/audio_service.dart';
import 'package:message_app/core/routes/app_routes.dart';
import 'package:message_app/core/themes/app_themes.dart';
import 'package:message_app/core/utils/snackbar_mixin.dart';
import 'package:message_app/presentation/widgets/button_row.dart';
import 'package:message_app/presentation/widgets/color_selector.dart';
import 'package:message_app/presentation/widgets/formatted_container.dart';
import 'package:message_app/presentation/widgets/text_area.dart';
import 'package:message_app/presentation/screens/send_letter_screen.dart';

class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SnackbarMixin {
  final audioService = AudioService.instance();
  final controller = TextEditingController();
  final textNode = FocusNode();
  Color textColor = AppThemes.fontColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemes.appBar,
      backgroundColor: AppThemes.blueFinal,
      body: FormattedContainer(
        child: SafeArea(
          child: Column(
            spacing: 5,
            children: <Widget>[
              const Text(
                "Cores de Fonte",
                style: TextStyle(color: AppThemes.fontColor, fontSize: 20),
              ),
              Container(
                width: .infinity,
                padding: const .all(10),
                child: Column(
                  spacing: 8,
                  children: <Widget>[
                    ColorSelector(
                      colors: AppThemes.primaryColorSet,
                      onTap: ({required index}) {
                        setState(() {
                          textColor = AppThemes.primaryColorSet[index];
                        });
                      },
                    ),
                    ColorSelector(
                      colors: AppThemes.secondaryColorSet,
                      onTap: ({required index}) {
                        setState(() {
                          textColor = AppThemes.secondaryColorSet[index];
                        });
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: DragTarget<Color>(
                  builder: (context, candidateItens, _) {
                    return TextArea(
                      label: "Expresse seus pensamentos...",
                      controller: controller,
                      color: candidateItens.isEmpty
                        ? textColor
                        : candidateItens.first!,
                      node: textNode,
                    );
                  },
                  onAcceptWithDetails: (details) async {
                    setState(() => textColor = details.data);
                    audioService.playColorAudio();
                  },  
                ),
              ),
              ButtonRow(
                sendButton: _sendLetter,
                copyButton: _copyText,
                clearButton: () {
                  audioService.playButtonAudio();
                  if (controller.text.isEmpty) { return; }
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
      getSnackbar(
        context: context, 
        label: "Não é possível enviar conteúdo vazio.", 
        labelColor: AppThemes.fontColor, 
        backgroundColor: AppThemes.white,
        behavior: .floating,
        margin: const .only(bottom: 85, left: 12, right: 12),
        padding: const .all(15),
      );
      return;
    }
    audioService.playButtonAudio();

    if (!mounted) { return; }
    Navigator.push(
      context,
      AppRoutes.getRoute(
        screen: const SendLetterScreen()
      ),
    ).then((_) {
      textNode.unfocus();
      if (controller.text.isNotEmpty) {
        controller.clear();
      }
    });
  }

  void _copyText() async {
    audioService.playButtonAudio();

    if (controller.text.isEmpty) { return; }

    await Clipboard.setData(ClipboardData(text: controller.text));

    if (!mounted) { return; }
    getSnackbar(
      context: context, 
      label: "Texto copiado para área de transferências!", 
      labelColor: AppThemes.fontColor, 
      backgroundColor: AppThemes.white,
      behavior: .floating,
      margin: const .only(bottom: 85, left: 12, right: 12),
      padding: const .all(15),
    );
    textNode.unfocus();
  }

  @override
  void dispose() {
    audioService.buttonPlayer.dispose();
    audioService.colorPlayer.dispose();
    controller.dispose();
    super.dispose();
  }
}