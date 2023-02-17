import 'package:flutter/material.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/theme/style.dart';

class PersonAcityItem extends StatelessWidget {
  final String image;
  final String name;
  final bool isActive;

  const PersonAcityItem({
    super.key,
    required this.image,
    required this.name,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: SizedBox(
        width: 60.0,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(image),
                    ),
                  ),
                ),
                Positioned(
                  top: 33.0,
                  left: 33,
                  child: Container(
                    width: 15.0,
                    height: 15.0,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2.0, color: Colors.white),
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2.0),
            Text(
              name,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: headerText2.copyWith(fontSize: lowSizeText),
            ),
          ],
        ),
      ),
    );
  }
}
