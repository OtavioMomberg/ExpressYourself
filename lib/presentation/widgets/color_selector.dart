import 'package:material_ui/material_ui.dart';
import 'package:message_app/presentation/widgets/draggable_color.dart';

class ColorSelector extends StatelessWidget {
  final List<Color> colors;
  final void Function({required int index}) onTap;

  const new({
    required this.colors, 
    required this.onTap,
    super.key
  });
  
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