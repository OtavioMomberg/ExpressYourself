import 'package:material_ui/material_ui.dart';
import 'package:message_app/core/themes/app_themes.dart';
import 'package:message_app/core/utils/snackbar_mixin.dart';
import 'package:message_app/presentation/widgets/formatted_container.dart';
import 'package:message_app/presentation/widgets/image_widget.dart';

class SendLetterScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<SendLetterScreen> createState() => _SendLetterScreenState();
}

class _SendLetterScreenState extends State<SendLetterScreen> with SnackbarMixin {
  bool init = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 600));
      setState(() => init = true);

      await Future.delayed(const Duration(seconds: 1));
      _showResponse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemes.appBar,
      backgroundColor: AppThemes.blueFinal,
      body: FormattedContainer(
        child: Center(
          child: AnimatedScale(
            duration: const Duration(milliseconds: 650),
            scale: init ? 0.0 : 1.0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 600),
              opacity: init ? 0.0 : 1.0,
              child: const ImageWidget(
                imagePath: "assets/images/letter_img.png"
              )
            )
          )
        )
      )
    );
  }

  void _showResponse() {
    Navigator.pop(context);

    getSnackbar(
      context: context, 
      label: "Carta Enviada!", 
      labelColor: AppThemes.fontColor, 
      backgroundColor: AppThemes.white,
      behavior: .floating,
      margin: const .only(bottom: 85, left: 12, right: 12),
      padding: const .all(15),
    );
  }
}