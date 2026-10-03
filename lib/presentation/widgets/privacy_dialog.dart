import 'package:custom_feedback/custom_feedback.dart';
import 'package:material_ui/material_ui.dart';
import 'package:message_app/core/themes/app_themes.dart';
import 'package:message_app/presentation/widgets/button.dart';

mixin PrivacyDialog {
  void showPrivacyDialog({
    required BuildContext context,
    required Future<void> Function() onPressed
  }) {
    CustomFeedback.rawDialog(
      context: context,
      barrierDismissible: false,
      backgroundColor: AppThemes.white,
      title: const Center(
        child: Text(
          "Privacidade",
          style: TextStyle(
            color: AppThemes.textBlueDark
          )
        )
      ),
      content: Column(
        spacing: 15,
        mainAxisSize: .min,
        children: <Widget>[
          const _PrivacyInfo(),
          FractionallySizedBox(
            widthFactor: 0.6,
            child: Button(
              label: "Confirmar",
              borderRadius: const .all(.circular(12)),
              onPressed: () async => await onPressed()
            ),
          ),
        ],
      ),
    );
  }
}

class const _PrivacyInfo() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 300
      ),
      child: Container(
        width: .infinity,
        padding: const .all(10),
        decoration: BoxDecoration(
          borderRadius: const .all(.circular(12)),
          border: .all(
            color: AppThemes.textBlueDark.withValues(alpha: .7)
          ),
        ),
        child: const SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                "Esse aplicativo não armazena qualquer tipo "
                "de conteúdo desenvolvido pelo usuário por "
                "meio da escrita. É possível apenas copiar "
                "o texto produzido para a área de transferências "
                "do próprio dispositivo do usuário para o mesmo "
                "poder utilizar de acordo com sua necessidade.\n"
                "Todo texto escrito, quando enviado é apagado, "
                "ocorre apenas uma simulação de envio de acordo "
                "com o propósito desse aplicativo e para garantir "
                "a privacidade do conteúdo escrito. ",
                textAlign: .justify,
                style: TextStyle(color: AppThemes.textBlueDark),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
