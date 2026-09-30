import 'package:material_ui/material_ui.dart';
import 'package:message_app/core/utils/user_preferences.dart';
import 'package:message_app/core/utils/audio_service.dart';
import 'package:message_app/core/routes/app_routes.dart';
import 'package:message_app/core/themes/app_themes.dart';
import 'package:message_app/presentation/widgets/button.dart';
import 'package:message_app/presentation/widgets/formatted_container.dart';
import 'package:message_app/presentation/screens/home_screen.dart';

class const PrivacyScreen({
  required final VerifyPrivacyScreen verifyPrivacy,
  required final AudioService audioService,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemes.appBar,
      backgroundColor: AppThemes.blueFinal,
      body: FormattedContainer(
        child: SafeArea(
          child: Column(
            spacing: 20,
            children: <Widget>[
              const Text(
                "Privacidade",
                style: TextStyle(color: AppThemes.fontColor, fontSize: 30),
              ),
              const SizedBox(height: 20),
              Container(
                width: .infinity,
                padding: const .all(10),
                decoration: BoxDecoration(
                  borderRadius: const .all(.circular(12)),
                  border: .all(color: AppThemes.fontColor),
                ),
                child: const Text(
                  "Esse aplicativo não armazena qualquer tipo "
                  "de conteúdo desenvolvido pelo usuário por "
                  "meio da escrita. É possível apenas copiar "
                  "o texto produzido para a área de transferências "
                  "do próprio dispositivo do usuário para o mesmo "
                  "poder utilizar de acordo com sua necessidade.\n"
                  "Todo texto escrito, quando enviado é apagado, "
                  "ocorre apenas uma simulação de envio de acordo "
                  "com o propósito desse aplicativo e para garantir "
                  "a privacidade do conteúdo escrito.",
                  textAlign: .justify,
                  style: TextStyle(color: AppThemes.fontColor),
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.6,
                child: Button(
                  label: "Confirmar",
                  borderRadius: const .all(.circular(12)),
                  onTap: () async {
                    audioService.playButtonAudio();
                    await verifyPrivacy.changePrefs();

                    if (context.mounted) {
                      Navigator.pushReplacement(
                        context,
                        AppRoutes.getRoute(screen: const HomeScreen()),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}