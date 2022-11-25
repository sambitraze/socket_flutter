import 'package:flutter/material.dart';
import 'package:socket_flutter/models/ChatMessage.dart';
import 'package:socket_flutter/utils/constants.dart';

class AudioMessage extends StatelessWidget {
  const AudioMessage({
    Key? key,
    required this.chatMessage,
  }) : super(key: key);
  final ChatMessage chatMessage;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: 30,
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 0.75,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: chatMessage.isSender
            ? kPrimaryColor.withOpacity(0.8)
            : Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.play_arrow,
            size: 15,
            color: chatMessage.isSender ? Colors.white : kPrimaryColor,
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: chatMessage.isSender
                        ? Colors.white
                        : kPrimaryColor.withOpacity(0.4),
                  ),
                  Positioned(
                    left: 0,
                    child: Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color:
                            chatMessage.isSender ? Colors.white : kPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Text("0:30"),
        ],
      ),
    );
  }
}
