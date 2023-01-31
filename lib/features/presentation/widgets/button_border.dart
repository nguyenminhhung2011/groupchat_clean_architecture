import 'package:flutter/material.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/theme/style.dart';

class ButtonBorder extends StatelessWidget {
  final Widget icon;
  final String title;
  final VoidCallback callback;
  final double? horizontal;
  const ButtonBorder({
    super.key,
    required this.icon,
    required this.title,
    required this.callback,
    this.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20.0),
      onTap: callback,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: paddingAllWidget),
        margin:
            EdgeInsets.symmetric(horizontal: horizontal ?? horizontalAllSize),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(width: 1, color: colorC1C1C1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 10.0),
            Text(
              title,
              style: headerText1.copyWith(fontSize: middleSizeText),
            )
          ],
        ),
      ),
    );
  }
}
