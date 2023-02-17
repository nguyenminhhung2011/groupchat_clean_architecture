import 'package:flutter/material.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/theme/style.dart';

class MainPageOptionItem extends StatelessWidget {
  final bool check;
  final Widget icon;
  final String text;
  final VoidCallback select;
  const MainPageOptionItem({
    super.key,
    required this.check,
    required this.icon,
    required this.text,
    required this.select,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: select,
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: check ? Colors.grey.withOpacity(0.1) : Colors.transparent,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(paddingAllWidget - 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.2),
              ),
              child: icon,
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                text,
                style: headerText2.copyWith(
                  fontSize: medumSizeText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
