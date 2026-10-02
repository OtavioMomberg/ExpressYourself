import 'package:material_ui/material_ui.dart';
import 'package:message_app/core/themes/app_themes.dart';
import 'package:message_app/core/utils/word_count.dart';

class const TextArea({
  required final TextEditingController controller,
  required final Color color,
  required final FocusNode node,
  required final WordCount wordCount,
  final String? label,
  super.key,
}) extends StatefulWidget {
  @override
  State<TextArea> createState() => _TextAreaState();
}

class _TextAreaState extends State<TextArea> {
  final _words = ValueNotifier<int>(0);

  @override
  void dispose() {
    _words.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: widget.wordCount.word,
      builder: (_, word, _) {
        return TextFormField(
          expands: true,
          minLines: null,
          maxLines: null,
          focusNode: widget.node,
          controller: widget.controller,
          textAlignVertical: .top,
          textCapitalization: .sentences,
          cursorColor: widget.color,
          style: TextStyle(color: widget.color),
          decoration: InputDecoration(
            hintText: widget.label,
            hintStyle: TextStyle(color: widget.color),
            counter: Text(
              "Palavras Digitadas: $word",
              style: TextStyle(
                color: AppThemes.textBlueDark, 
              ),
            ),
            enabledBorder: AppThemes.inputBoarder,
            focusedBorder: AppThemes.inputBoarder.copyWith(
              borderSide: const BorderSide(
                color: AppThemes.textBlueDark,
                width: 1.25
              ),
            ),
          ),
          onChanged: (value) {
            final text = value.trim();

            if (text.isEmpty) {
              widget.wordCount.changeValue(newValue: 0);
              return;
            }
            widget.wordCount.changeValue(
              newValue: text.split(RegExp(r"\s+")).length
            );
          },
          onTapOutside: (_) {
            FocusScope.of(context).unfocus();
          },
        );
      },
    );
  }
}
