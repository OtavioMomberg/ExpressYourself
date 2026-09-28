import 'package:flutter/widgets.dart';
import 'package:message_app/core/themes/app_themes.dart';

class FormattedContainer extends StatelessWidget {
  final Widget? child;
  const new({this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: .infinity,
      width: .infinity,
      padding: const .all(10),
      decoration: const BoxDecoration(
        gradient: AppThemes.gradient
      ),
      child: child
    );
  }
}
