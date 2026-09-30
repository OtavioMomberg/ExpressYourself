import 'package:material_ui/material_ui.dart';
import 'package:message_app/core/themes/app_themes.dart';

class const TextArea({
    required final TextEditingController controller,
    required final Color color,
    required final FocusNode node,
    final String? label, 
    super.key
  }) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      expands: true,
      minLines: null,
      maxLines: null,
      focusNode: node,
      controller: controller,
      textAlignVertical: .top,
      textCapitalization: .sentences,
      cursorColor: color,
      style: TextStyle(color: color),
      decoration: InputDecoration(
        hintText: label,
        hintStyle: TextStyle(color: color),
        border: AppThemes.inputBoarder,
        enabledBorder: AppThemes.inputBoarder,
        focusedBorder: AppThemes.inputBoarder,
      ),
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
    );
  }
}