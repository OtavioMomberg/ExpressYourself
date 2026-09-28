import 'package:material_ui/material_ui.dart';

class ImageWidget extends StatelessWidget {
  final String imagePath;

  const ImageWidget({
    required this.imagePath, 
    super.key
  });

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