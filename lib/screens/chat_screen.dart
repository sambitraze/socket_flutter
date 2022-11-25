import 'package:flutter/material.dart';
import 'package:socket_flutter/components/message_card.dart';
import 'package:socket_flutter/models/Chat.dart';
import 'package:socket_flutter/models/ChatMessage.dart';
import 'package:socket_flutter/utils/constants.dart';
import 'package:socket_flutter/utils/show_toast.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.isGroup, required this.chat});
  final bool isGroup;
  final Chat chat;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: ListView.builder(
                itemCount: demoChatMessages.length,
                itemBuilder: (context, index) {
                  return MessageCard(
                    chatMessage: demoChatMessages[index],
                    isGroup: widget.isGroup,
                  );
                },
              ),
            ),
          ),
          bottomMessageBox(context)
        ],
      ),
    );
  }

  Container bottomMessageBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 32,
            color: kPrimaryColor.withOpacity(0.4),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            const Icon(Icons.mic, color: kPrimaryColor),
            const SizedBox(
              width: kDefaultPadding,
            ),
            Expanded(
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 0.75,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.6),
                    ),
                    const SizedBox(
                      width: kDefaultPadding / 4,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Type message",
                          hintStyle: TextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .color!
                                .withOpacity(0.6),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.attach_file,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.6),
                    ),
                    const SizedBox(
                      width: kDefaultPadding / 4,
                    ),
                    Icon(
                      Icons.camera_alt_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.6),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/images/user_2.png'),
          ),
          const SizedBox(
            width: kDefaultPadding * 0.75,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.isGroup ? 'Group Chat' : widget.chat.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.isGroup ? "16 Members" : "Active ${widget.chat.time}",
                style: const TextStyle(fontSize: 12),
              )
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            showToast(context, "Feature Comming Soon", "info");
          },
          icon: const Icon(Icons.videocam),
        ),
        IconButton(
          onPressed: () {
            showToast(context, "Feature Comming Soon", "info");
          },
          icon: const Icon(Icons.call),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert),
        ),
      ],
    );
  }
}
