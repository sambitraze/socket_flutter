import 'package:flutter/material.dart';
import 'package:socket_flutter/models/ChatMessage.dart';

class ImageMessage extends StatelessWidget {
  const ImageMessage({
    Key? key,
    required this.chatMessage,
  }) : super(key: key);
  final ChatMessage chatMessage;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: AspectRatio(
        aspectRatio: 1.6,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            "assets/images/dummy.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}