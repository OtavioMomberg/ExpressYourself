import 'package:material_ui/material_ui.dart';
import 'package:message_app/core/themes/app_themes.dart';
import 'package:message_app/presentation/widgets/button.dart';

class ButtonRow extends StatelessWidget {
  final VoidCallback sendButton;
  final VoidCallback copyButton;
  final VoidCallback clearButton;

  const new({
    required this.sendButton,
    required this.copyButton,
    required this.clearButton,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: <Widget>[
        Expanded(
          child: Button(
            label: "Limpar", 
            borderRadius: const .all(.circular(50)),
            icon: const Icon(Icons.delete, color: AppThemes.fontColor),
            iconAlignment: .start,
            onTap: clearButton,
          ),
        ),
        Expanded(
          child: Button(
            label: "Enviar", 
            borderRadius: const .all(.circular(12)),
            onTap: sendButton,
          ),
        ),
        Expanded(
          child: Button(
            label: "Copiar", 
            borderRadius: const .all(.circular(50)),
            icon: const Icon(Icons.copy, color: AppThemes.fontColor),
            iconAlignment: .end,
            onTap: copyButton,
          ),
        ),
      ],
    );
  }
}