import 'package:flutter/widgets.dart';
import 'package:message_app/core/themes/app_themes.dart';

class const FormattedContainer({final Widget? child, super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: .infinity,
      width: .infinity,
      padding: const .symmetric(horizontal: 12, vertical: 10),
      decoration: const BoxDecoration(
        gradient: AppThemes.gradient
      ),
      child: child
    );
  }
}
