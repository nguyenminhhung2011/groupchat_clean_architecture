import 'package:flutter/material.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/theme/style.dart';

class OptionSettingItem extends StatelessWidget {
  final Color color;
  final Widget icon;
  final String leadTitle;
  final String title;
  final VoidCallback select;
  const OptionSettingItem({
    super.key,
    required this.color,
    required this.icon,
    required this.leadTitle,
    required this.title,
    required this.select,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: horizontalAllSize, vertical: 10.0),
      child: InkWell(
        onTap: select,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 35.0,
              height: 35.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
              child: icon,
            ),
            const SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  leadTitle,
                  style: headerText2.copyWith(fontSize: medumSizeText),
                ),
                Text(
                  title,
                  style: headerText2.copyWith(fontSize: lowSizeText),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
