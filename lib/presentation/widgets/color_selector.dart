import 'package:material_ui/material_ui.dart';
import 'package:message_app/core/themes/app_themes.dart';
import 'package:message_app/presentation/widgets/draggable_color.dart';

const indexFactor = 3;
const indexNormalizer = 1;

enum RowId { first, second }

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
            _ColorRow(
              colors: AppThemes.primaryColorSet, 
              rowID: .first,
              onTap: onTap
            ),
            _ColorRow(
              colors: AppThemes.secondaryColorSet,
              rowID: .second,
              onTap: onTap
            )
          ]
        )
      )
    );
  }
}

class const _ColorRow({
  required final List<Color> colors,
  required final RowId rowID,
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
            onTap: () => onTap(
              index: (rowID == .first)
                ? index 
                : (index + indexNormalizer) * indexFactor
              ),
            child: DraggableColor(
              color: colors[index]
            ),
          );
        }),
      ],
    );
  }
}
