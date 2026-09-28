import 'package:material_ui/material_ui.dart';
import 'package:custom_feedback/custom_feedback.dart';

mixin SnackbarMixin {
  void getSnackbar({
    required BuildContext context,
    required String label,
    required Color labelColor,
    required Color backgroundColor,
    SnackBarBehavior? behavior,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding
  }) {
    CustomFeedback.rawSnackbar(
      context: context,
      content: Text(
        label,
        style: TextStyle(color: labelColor),
      ),
      backgroundColor: backgroundColor,
      behavior: behavior ?? .floating,
      margin: margin,
      padding: padding ?? const .all(10),
    );
  }
}