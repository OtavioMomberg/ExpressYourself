import 'package:material_ui/material_ui.dart';
import 'package:message_app/core/themes/app_themes.dart';

class const Button({
  required final String label,
  required final BorderRadius borderRadius,
  final Widget? icon,
  final IconAlignment? iconAlignment,
  final void Function()? onPressed,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 60, minHeight: 50),
      child: TextButton.icon(
        icon: icon,
        iconAlignment: iconAlignment,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
            side: BorderSide(
              color: AppThemes.textBlueDark.withValues(alpha: .7),
            ),
          ),
        ),
        onPressed: () => onPressed != null ? onPressed!() : null,
        label: Text(
          label,
          style: const TextStyle(color: AppThemes.textBlueDark),
        ),
      ),
    );
  }
}
