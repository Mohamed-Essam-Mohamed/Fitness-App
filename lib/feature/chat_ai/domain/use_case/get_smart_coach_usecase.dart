
import 'package:fitness_app/feature/chat_ai/domain/entity/smart_coach/message_entity.dart';
import 'package:fitness_app/feature/chat_ai/domain/repository/smart_coach_repository.dart';
import 'package:injectable/injectable.dart';


@injectable

class GetSmartCoachResponseUseCase {

  GetSmartCoachResponseUseCase(this._repository);
  final SmartCoachRepository _repository;

  Stream<String> call(List<MessageEntity> chatHistory) {
    return _repository.getSmartCoachReplyStream(chatHistory);
  }
}