import 'package:flutter/material.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/theme/style.dart';

class RecCard extends StatelessWidget {
  final String title;
  final String avt;
  final bool check;
  final int typeMess;
  final String imageMess;
  final DateTime time;
  RecCard({
    Key? key,
    required this.time,
    required this.title,
    required this.avt,
    required this.check,
    required this.typeMess,
    required this.imageMess,
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
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 2.5, bottom: 2.5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 20.0,
              height: 20.0,
              margin: EdgeInsets.only(
                  bottom: check ? 16.0 : 4.0, left: 10.0, right: 4.0, top: 2.5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5.0,
                  )
                ],
                image: DecorationImage(
                  image: NetworkImage(avt == ""
                      ? 'https://sbcf.fr/wp-content/uploads/2018/03/sbcf-default-avatar.png'
                      : avt),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5.0,
                      )
                    ],
                  ),
                  child: typeMess == 0
                      ? Text(
                          subString(),
                          style: TextStyle(
                            color: textIconColorGray,
                            fontWeight: FontWeight.w500,
                            fontSize: medumSizeText,
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 20.0,
                                  height: 20.0,
                                  margin: const EdgeInsets.only(right: 10.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(avt == ""
                                          ? 'https://sbcf.fr/wp-content/uploads/2018/03/sbcf-default-avatar.png'
                                          : avt),
                                    ),
                                  ),
                                ),
                                Text(
                                  subString(),
                                  style: TextStyle(
                                    color: textIconColorGray,
                                    fontWeight: FontWeight.w500,
                                    fontSize: medumSizeText,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Container(
                              width: widthDevice / 2,
                              height: widthDevice / 2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black12, blurRadius: 5.0),
                                ],
                                image: DecorationImage(
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
          ],
        ),
      ),
    );
  }
}
