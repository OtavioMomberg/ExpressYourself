import 'package:material_ui/material_ui.dart';
import 'package:message_app/core/themes/app_themes.dart';
import 'package:message_app/presentation/widgets/draggable_color.dart';

class const ColorSelector({
  required final void Function({required int index}) onTap,
  super.key
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 300,
        minHeight: 130
      ),
      child: Container(
        padding: const .symmetric(horizontal: 12, vertical: 5),
        child: Column(
          spacing: 8,
          children: <Widget>[
            _ColorRow(colors: AppThemes.primaryColorSet, onTap: onTap),
            _ColorRow(colors: AppThemes.secondaryColorSet, onTap: onTap)
          ],
        ),
      ),
    );
  }
}

class const _ColorRow({
  required final List<Color> colors,
  required final void Function({required int index}) onTap
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceEvenly,
      children: <Widget>[
        ....generate((colors.length), (index) {
          return InkWell(
            customBorder: const StarBorder.polygon(
              sides: 8, 
              pointRounding: 0.3
            ),
            onTap: () => onTap(index: index),
            child: DraggableColor(
              color: colors[index]
            ),
          );
        }),
      ],
    );
  }
}
