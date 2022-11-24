import 'package:flutter/material.dart';
import 'package:socket_flutter/models/Chat.dart';
import 'package:socket_flutter/utils/constants.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({Key? key, required this.chat}) : super(key: key);

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(chat.image),
              ),
              if (chat.isActive)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: 3,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(
            width: kDefaultPadding,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chat.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: kDefaultPadding / 2,
                ),
                Text(
                  chat.lastMessage,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Text(
            chat.time,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}