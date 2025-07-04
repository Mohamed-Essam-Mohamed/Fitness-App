
import 'package:fitness_app/feature/chat_ai/domain/repository/smart_coach_repository.dart';
import 'package:injectable/injectable.dart';


@injectable

class DeleteConversationUseCase {

  DeleteConversationUseCase(this._repository);
  final SmartCoachRepository _repository;

  Future<void> call(String conversationId) {
    return _repository.deleteConversation(conversationId);
  }
}