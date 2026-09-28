import 'package:material_ui/material_ui.dart';
import 'package:message_app/core/themes/app_themes.dart';

class Button extends StatelessWidget {
  final String label;
  final BorderRadius borderRadius;
  final Widget? icon;
  final IconAlignment? iconAlignment;
  final void Function()? onTap;

  const new({
    required this.label,
    required this.borderRadius,
    this.icon,
    this.iconAlignment,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: .all(
          color: AppThemes.fontColor.withValues(alpha: .7)
        ),
      ),
      child: TextButton.icon(
        icon: icon,
        iconAlignment: iconAlignment,
        onPressed: () {
          if (onTap != null) { onTap!(); }
        },
        label: Text(
          label,
          style: const TextStyle(
            color: AppThemes.fontColor
          ),
        ),
      ),
    );
  }
}