// enum Sender { user, coach }
//
// class Message {
//   final String text;
//   final Sender sender;
//   Message({required this.text, required this.sender});
// }

enum Sender { user, ai }

class MessageModel {
  final String text;
  final Sender sender;

  MessageModel({required this.text, required this.sender});
}
