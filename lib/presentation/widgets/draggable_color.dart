import 'package:material_ui/material_ui.dart';
import 'package:message_app/core/themes/app_themes.dart';

class DraggableColor extends StatelessWidget {
  final Color color;

  const new({required this.color, super.key});

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
        shadowColor: AppThemes.fontColor,
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