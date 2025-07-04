
enum Sender { user, model }

class MessageEntity {

  MessageEntity({required this.text, required this.sender});
  final String text;
  final Sender sender;

  MessageEntity copyWith({String? text, Sender? sender}) {
    return MessageEntity(
      text: text ?? this.text,
      sender: sender ?? this.sender,
    );
  }
}