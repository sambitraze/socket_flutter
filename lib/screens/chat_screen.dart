import 'package:flutter/material.dart';
import 'package:socket_flutter/components/message_card.dart';
import 'package:socket_flutter/models/Chat.dart';
import 'package:socket_flutter/models/ChatMessage.dart';
import 'package:socket_flutter/utils/constants.dart';
import 'package:socket_flutter/utils/show_toast.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:timeago/timeago.dart' as timeago;

import '../models/User.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.isGroup,
    required this.chat,
    required this.currentUser,
    required this.chatUser,
  });
  final bool isGroup;
  final Chat chat;
  final User chatUser;
  final Map currentUser;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late IO.Socket socket;
  _connectSocket() {
    print("connect try start");
    socket = IO.io('http://192.168.2.104:8080', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'query': {
        'user': widget.currentUser['id'],
      }
    });

    socket.on(
      "passmessage",
      (data) {
        setState(() {
          chats.add(
            ChatMessage(
              isSender: false,
              text: data['text'],
              messageType: ChatMessageType.text,
              messageStatus: MessageStatus.viewed,
            ),
          );
        });
      },
    );

    socket.connect();
    socket.onConnect((_) => print("conencted: ${socket.id}"));
    socket.onConnectError((_) => print("conencterror: ${socket.id}"));
    socket.onConnectTimeout((_) => print("conenct timeout: ${socket.id}"));
    socket.onDisconnect((_) => print("disconnected"));
  }

  _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      socket.emit('message', {
        'text': _messageController.text,
        'sender': widget.currentUser['id'],
        'receiver': widget.chatUser.id,
        'time': DateTime.now().toString(),
        'messageType': "text",
        'messageStatus': "not_sent",
      });
      setState(() {
        chats.add(
        ChatMessage(
          isSender: true,
          text: _messageController.text,
          messageType: ChatMessageType.text,
          messageStatus: MessageStatus.viewed,
        ),
      );
      });
      _messageController.clear();
    } else {
      showToast(context, "Message can't be empty", "info");
    }
  }

  // dispose socket
  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
    socket.dispose();
  }

  @override
  void initState() {
    super.initState();
    _connectSocket();
  }

  List<ChatMessage> chats = [];

  final TextEditingController _messageController = TextEditingController();
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
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  return MessageCard(
                    chatMessage: chats[index],
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
                        controller: _messageController,
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
                    IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .color!
                            .withOpacity(0.6),
                      ),
                      onPressed: _sendMessage,
                    )
                    // _messageController.text.trim().isNotEmpty
                    //     ? Icon(
                    //         Icons.send,
                    //         color: Theme.of(context)
                    //             .textTheme
                    //             .bodyText1!
                    //             .color!
                    //             .withOpacity(0.6),
                    //       )
                    //     : Icon(
                    //         Icons.attach_file,
                    //         color: Theme.of(context)
                    //             .textTheme
                    //             .bodyText1!
                    //             .color!
                    //             .withOpacity(0.6),
                    //       ),
                    // _messageController.text.trim().isNotEmpty
                    //     ? const SizedBox()
                    //     : const SizedBox(
                    //         width: kDefaultPadding / 4,
                    //       ),
                    // _messageController.text.trim().isNotEmpty
                    //     ? const SizedBox()
                    //     : Icon(
                    //         Icons.camera_alt_outlined,
                    //         color: Theme.of(context)
                    //             .textTheme
                    //             .bodyText1!
                    //             .color!
                    //             .withOpacity(0.6),
                    //       ),
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
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(widget.chatUser.photoUrl),
          ),
          const SizedBox(
            width: kDefaultPadding * 0.75,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.isGroup ? 'Group Chat' : widget.chatUser.firstName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 100,
                child: Text(
                  widget.isGroup
                      ? "16 Members"
                      // : "Active ${timeago.format(DateTime.now())}",
                      : "Active",
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                ),
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
