import 'package:material_ui/material_ui.dart';

class const ImageWidget({required final String imagePath, super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const .all(.circular(12)),
      child: Image.asset(
        imagePath,
        filterQuality: .high,
        fit: .contain,
        colorBlendMode: .darken
      )
    );
  }
}