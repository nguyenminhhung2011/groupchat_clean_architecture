import 'package:flutter/material.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/theme/style.dart';

class SendCard extends StatelessWidget {
  final String title;
  final bool check;
  final int typeMess;
  final String imageMess;
  final DateTime time;
  SendCard({
    Key? key,
    required this.title,
    required this.check,
    required this.typeMess,
    required this.imageMess,
    required this.time,
  }) : super(key: key);

  String subString() {
    String result = "";
    for (int i = 0; i < title.length; i++) {
      if (i % 30 == 0 && i != 0) {
        result += '\n';
      }
      result += title[i];
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final widthDevice = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0, top: 2.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: blueColor,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: typeMess == 0
                  ? Text(
                      subString(),
                      style: TextStyle(
                        color: textIconColor,
                        fontWeight: FontWeight.w500,
                        fontSize: medumSizeText,
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subString(),
                          style: TextStyle(
                              color: textIconColor,
                              fontWeight: FontWeight.w500,
                              fontSize: medumSizeText),
                        ),
                        const SizedBox(height: 10.0),
                        Container(
                          width: widthDevice / 2,
                          height: widthDevice / 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5.0,
                              ),
                            ],
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(imageMess),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
            check
                ? Text(
                    '${time.hour}:${time.month}',
                    style: TextStyle(
                      color: textIconColorGray,
                      fontWeight: FontWeight.bold,
                      fontSize: lowSizeText,
                    ),
                  )
                : const SizedBox(),
            SizedBox(height: check ? 10.0 : 0)
          ],
        ),
      ),
    );
  }
}
