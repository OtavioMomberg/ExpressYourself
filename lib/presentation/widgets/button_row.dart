import 'package:material_ui/material_ui.dart';
import 'package:message_app/core/themes/app_themes.dart';
import 'package:message_app/presentation/widgets/button.dart';

class const ButtonRow({
  required final VoidCallback sendButton,
  required final VoidCallback copyButton,
  required final VoidCallback clearButton,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: <Widget>[
        Expanded(
          child: Button(
            label: "Limpar",
            borderRadius: const .all(.circular(50)),
            icon: const Icon(Icons.delete, color: AppThemes.textBlueDark),
            iconAlignment: .start,
            onPressed: clearButton,
          ),
        ),
        Expanded(
          child: Button(
            label: "Enviar",
            borderRadius: const .all(.circular(12)),
            onPressed: sendButton,
          ),
        ),
        Expanded(
          child: Button(
            label: "Copiar",
            borderRadius: const .all(.circular(50)),
            icon: const Icon(Icons.copy, color: AppThemes.textBlueDark),
            iconAlignment: .end,
            onPressed: copyButton
          )
        )
      ]
    );
  }
}
