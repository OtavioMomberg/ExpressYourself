import 'package:material_ui/material_ui.dart';
import 'package:message_app/core/themes/app_themes.dart';

class const DraggableColor({required final Color color, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Draggable<Color>(
      data: color,
      feedback: SizedBox.square(
        dimension: 80,
        child: Card(
          shape: const StarBorder.polygon(sides: 8, pointRounding: 0.3),
          color: color,
        ),
      ),
      childWhenDragging: const Material(
        elevation: 6,
        shape: StarBorder.polygon(sides: 8, pointRounding: 0.3),
        child: SizedBox.square(dimension: 60),
      ),
      child: Material(
        elevation: 6,
        shadowColor: AppThemes.textBlueDark,
        shape: const StarBorder.polygon(sides: 8, pointRounding: 0.3),
        child: SizedBox.square(
          dimension: 60,
          child: Card(
            shape: const StarBorder.polygon(sides: 8, pointRounding: 0.3),
            color: color,
          ),
        ),
      ),
    );
  }
}
