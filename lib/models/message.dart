import 'package:objectbox/objectbox.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

@Entity()
class ChatMessage {
  // Each "Entity" needs a unique integer ID property.
  // Add `@Id()` annotation if its name isn't "id" (case insensitive).
  String id = uuid.v1();

  String? text;

  @Property(type: PropertyType.date) // Store as int in milliseconds
  DateTime date;

  @Transient() // Make this field ignored, not stored in the database.
  int? notPersisted;

  // An empty default constructor is needed but you can use optional args.
  ChatMessage({this.text, DateTime? date}) : date = date ?? DateTime.now();

  // Note: just for logs in the examples below(), not needed by ObjectBox.
  toString() => 'Note{id: $id, text: $text}';
}