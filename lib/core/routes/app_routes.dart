import 'package:material_ui/material_ui.dart';

final class AppRoutes._() {
  static Route<dynamic> getRoute({required Widget screen}) {
    return PageRouteBuilder(
      pageBuilder: (_, _, _) => screen,
      transitionDuration: const Duration(milliseconds: 350),
      reverseTransitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (_, animation, _, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation, 
            curve: Curves.easeInOut
          ),
          child: child
        );
      } 
    );
  }
}