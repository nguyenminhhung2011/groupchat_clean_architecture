import 'package:flutter/material.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/theme/style.dart';

class ChatItem extends StatelessWidget {
  final String name;
  final String url;
  final Map<String, dynamic> lastMess;
  const ChatItem({
    super.key,
    required this.name,
    required this.url,
    required this.lastMess,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalAllSize - 5.0),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(url),
                  ),
                ),
              ),
              Positioned(
                top: 45.0,
                left: 45,
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
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: headerText1.copyWith(fontSize: medumSizeText),
                  maxLines: 1,
                ),
                const SizedBox(height: 2.0),
                Text(
                  lastMess['mess'],
                  style: headerText2.copyWith(
                    fontSize: lowSizeText,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              '',
              style: headerText1.copyWith(
                  fontSize: lowSizeText, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
