import 'package:flutter/material.dart';
import 'package:socket_flutter/components/audio_message.dart';
import 'package:socket_flutter/components/image_message.dart';
import 'package:socket_flutter/components/text_mesage.dart';
import 'package:socket_flutter/components/video_mesage.dart';
import 'package:socket_flutter/models/ChatMessage.dart';
import 'package:socket_flutter/utils/constants.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({
    Key? key,
    required this.chatMessage,
    required this.isGroup,
  }) : super(key: key);
  final ChatMessage chatMessage;
  final bool isGroup;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: Row(
        mainAxisAlignment: chatMessage.isSender
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!chatMessage.isSender && isGroup) ...[
            const CircleAvatar(
              radius: 12,
              backgroundImage: AssetImage('assets/images/user_2.png'),
            ),
            const SizedBox(
              width: kDefaultPadding / 2,
            ),
          ],
          messageCardBox(context),
          const SizedBox(
            width: kDefaultPadding / 2,
          ),
          if (chatMessage.isSender)
            MessageStatusWidget(status: chatMessage.messageStatus)
        ],
      ),
    );
  }

  Widget messageCardContent(BuildContext context, ChatMessage chatMessage) {
    switch (chatMessage.messageType) {
      case ChatMessageType.text:
        return TextMessage(
          chatMessage: chatMessage,
        );
      case ChatMessageType.audio:
        return AudioMessage(chatMessage: chatMessage);
      case ChatMessageType.video:
        return VideoMessage(chatMessage: chatMessage);
      case ChatMessageType.image:
        return ImageMessage(chatMessage: chatMessage);
      default:
        return TextMessage(
          chatMessage: ChatMessage(
            isSender: chatMessage.isSender,
            text: 'Unknown message type',
            messageStatus: chatMessage.messageStatus,
            messageType: chatMessage.messageType,
          ),
        );
    }
  }

  Widget messageCardBox(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isGroup && !chatMessage.isSender) ...[
          Text(
            "sender name",
            style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .color!
                  .withOpacity(0.6),
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: kDefaultPadding / 4,
          ),
        ],
        messageCardContent(context, chatMessage),
      ],
    );
  }
}

class MessageStatusWidget extends StatelessWidget {
  const MessageStatusWidget({super.key, required this.status});
  final MessageStatus status;
  @override
  Widget build(BuildContext context) {
    Color dotColor(MessageStatus status) {
      switch (status) {
        case MessageStatus.not_sent:
          return kErrorColor;
        case MessageStatus.not_view:
          return Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.1);
        case MessageStatus.viewed:
          return Colors.white;
        default:
          return Colors.transparent;
      }
    }

    return Container(
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: status == MessageStatus.viewed
            ? kPrimaryColor.withOpacity(0.6)
            : Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        status == MessageStatus.not_sent ? Icons.close : Icons.done,
        color: dotColor(status),
        size: 8,
      ),
    );
  }
}
