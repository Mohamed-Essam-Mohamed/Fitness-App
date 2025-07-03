
import 'package:fitness_app/feature/chat_ai/domain/entity/smart_coach/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({required super.text, required super.sender});

  factory MessageModel.fromEntity(MessageEntity entity) {
    return MessageModel(text: entity.text, sender: entity.sender);
  }

  MessageEntity toEntity() {
    return MessageEntity(text: text, sender: sender);
  }


}