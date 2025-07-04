
import 'package:fitness_app/feature/chat_ai/domain/repository/smart_coach_repository.dart';
import 'package:injectable/injectable.dart';


@injectable

class StartNewConversationUseCase {

  StartNewConversationUseCase(this._repository);
  final SmartCoachRepository _repository;

  Future<String> call() {
    return _repository.startNewConversation();
  }
}