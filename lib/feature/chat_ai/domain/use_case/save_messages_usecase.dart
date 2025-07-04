
import 'package:fitness_app/feature/chat_ai/domain/entity/smart_coach/message_entity.dart';
import 'package:fitness_app/feature/chat_ai/domain/repository/smart_coach_repository.dart';
import 'package:injectable/injectable.dart';


@injectable

class SaveMessagesUseCase {

  SaveMessagesUseCase(this._repository);
  final SmartCoachRepository _repository;

  Future<void> call(String conversationId, MessageEntity message) {
    return _repository.saveMessage(conversationId, message);
  }
}