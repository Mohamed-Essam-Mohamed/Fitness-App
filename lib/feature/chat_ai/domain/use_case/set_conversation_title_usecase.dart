import 'package:fitness_app/feature/chat_ai/domain/repository/smart_coach_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SetConversationTitleUseCase {
  SetConversationTitleUseCase(this._repository);
  final SmartCoachRepository _repository;

  Future<void> call(String conversationId, String title) {
    return _repository.setConversationTitle(conversationId, title);
  }
}
