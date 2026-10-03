import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import "package:message_app/core/utils/home_utils.dart";
import 'package:message_app/presentation/widgets/home_widgets.dart';
import 'package:message_app/presentation/screens/send_letter_screen.dart';

class const HomeScreen({super.key}) extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SnackbarMixin, PrivacyDialog, WidgetsBindingObserver {
  final controller = TextEditingController();
  final textNode = FocusNode();
  bool hideButtonRow = false;
  Color textColor = AppThemes.textBlueDark;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => _checkPrivacy());
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    HomeDeps.audioService.buttonPlayer.dispose();
    HomeDeps.audioService.colorPlayer.dispose();
    HomeDeps.wordCountNotifier.disposeWordNotifier().dispose();
    controller.dispose();
    textNode.dispose();
    super.dispose();
  }

  @override
void didChangeMetrics() {
  super.didChangeMetrics();

  hideButtonRow = 
    WidgetsBinding.instance.platformDispatcher.views.first.viewInsets.bottom > 0;
  setState(() {});
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
              ColorSelector(onTap: _selectColor),
              Expanded(
                child: DragTarget<Color>(
                  builder: (_, color, _) {
                    return TextArea(
                      label: "Expresse seus pensamentos...",
                      controller: controller,
                      color: color.isEmpty ? textColor : color.first!,
                      node: textNode,
                      wordCount: HomeDeps.wordCountNotifier,
                    );
                  },
                  onAcceptWithDetails: (details) async {
                    setState(() => textColor = details.data);
                    HomeDeps.audioService.playColorAudio();
                  },
                ),
              ),

              if (!hideButtonRow)...[
                const SizedBox(height: 15),
                ButtonRow(
                  sendButton: _sendLetter,
                  copyButton: _copyText,
                  clearButton: _clearText,
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

  void _checkPrivacy() {
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
  }

  void _selectColor({required int index}) {
    textColor = (index < indexFactor)
      ? AppThemes.primaryColorSet[index]
      : AppThemes.secondaryColorSet[(index ~/ indexFactor) - indexNormalizer];
    setState(() {});
  }

  void _sendLetter() {
    if (!_checkText()) { return; }

    Navigator.push(
      context,
      AppRoutes.getRoute(screen: const SendLetterScreen()),
    ).then((_) {
      textNode.unfocus();
      if (controller.text.isNotEmpty) {
        controller.clear();
        HomeDeps.wordCountNotifier.resetWordNumber();
      }
    });
  }

  void _copyText() async {
    if (!_checkText()) { return; }

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
    if (!_checkText()) { return; }

    HomeDeps.wordCountNotifier.resetWordNumber();
    controller.clear();
  }

  bool _checkText() {
    switch (controller.text) {
      case "":
        HomeDeps.audioService.playColorAudio();
        return false;
      default:
        HomeDeps.audioService.playButtonAudio();
        return true;
    }
  }
}
