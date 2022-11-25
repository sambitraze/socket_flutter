import 'package:flutter/material.dart';
import 'package:socket_flutter/models/ChatMessage.dart';
import 'package:socket_flutter/utils/constants.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    required this.chatMessage,
  }) : super(key: key);
  final ChatMessage chatMessage;
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Text(
        chatMessage.text,
        style: const TextStyle(fontSize: 15),
      ),
    );
  }
}