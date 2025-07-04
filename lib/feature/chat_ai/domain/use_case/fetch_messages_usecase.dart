
import 'package:fitness_app/feature/chat_ai/domain/entity/smart_coach/message_entity.dart';
import 'package:fitness_app/feature/chat_ai/domain/repository/smart_coach_repository.dart';
import 'package:injectable/injectable.dart';


@injectable

class FetchMessagesUseCase {

  FetchMessagesUseCase(this._repository);
  final SmartCoachRepository _repository;

  Future<List<MessageEntity>> call(String conversationId) {
    return _repository.fetchMessages(conversationId);
  }
}