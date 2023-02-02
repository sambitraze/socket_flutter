import 'package:objectbox/objectbox.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

@Entity()
class ChatMessage {
  @Id()
  int id = 0;
  String? uid;
  String? text;
  String? reciever;
  String? sender;
  @Property(type: PropertyType.date) // Store as int in milliseconds
  DateTime time;
  String? messageType;
  String? messageStatus;

  ChatMessage({
    this.uid,
    this.text,
    this.reciever,
    this.sender,
    DateTime? time,
    this.messageType,
    this.messageStatus,
  }) : time = time ?? DateTime.now();
}