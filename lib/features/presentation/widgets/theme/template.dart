import 'package:flutter/material.dart';

class ListViewMain extends StatelessWidget {
  final List<Widget> children;
  final bool? scrollPhysics;
  const ListViewMain(
      {super.key, required this.children, this.scrollPhysics = true});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(
        parent: scrollPhysics!
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
      ),
      children: children,
    );
  }
}
