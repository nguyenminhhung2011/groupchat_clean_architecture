import 'package:flutter/material.dart';

// class AppBarWidget extends StatelessWidget {
//   final Widget? leading;
//   final List<Widget>? actions;
//   final Widget? title;
//   final Color? backgroudColor;
//   const AppBarWidget(
//       {super.key, this.leading, this.actions, this.title, this.backgroudColor});

//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: backgroudColor ?? Colors.transparent,
//       elevation: 0,
//       leading: leading ?? const SizedBox(),
//       actions: actions ?? [],
//       title: title ?? title,
//     );
//   }
// }

AppBar appBarWidget(Widget? leading, List<Widget>? actions, Widget? title,
    Color? backgroudColor) {
  return AppBar(
    backgroundColor: backgroudColor ?? Colors.transparent,
    elevation: 0,
    leading: leading ?? const SizedBox(),
    actions: actions ?? [],
    title: title ?? title,
  );
}
