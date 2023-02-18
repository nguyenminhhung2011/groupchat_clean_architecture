import 'package:flutter/material.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/theme/style.dart';

class ButtonCustom extends StatelessWidget {
  final String title;
  final Color color;
  final Color textColor;
  final double? horizontal;
  final VoidCallback onPress;
  final bool? circle;
  const ButtonCustom({
    super.key,
    required this.title,
    required this.color,
    required this.textColor,
    this.horizontal,
    required this.onPress,
    this.circle = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20.0),
      onTap: onPress,
      child: Container(
        width: double.infinity,
        margin:
            EdgeInsets.symmetric(horizontal: horizontal ?? horizontalAllSize),
        padding: const EdgeInsets.all(paddingAllWidget),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: color,
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5.0)],
        ),
        child: Align(
          alignment: Alignment.center,
          child: !circle!
              ? Text(
                  title,
                  style: headerText1.copyWith(
                    fontSize: middleSizeText,
                    color: textColor,
                  ),
                )
              : const CircularProgressIndicator(color: Colors.white),
        ),
      ),
    );
  }
}
