
import 'package:fitness_app/feature/chat_ai/domain/repository/smart_coach_repository.dart';
import 'package:injectable/injectable.dart';


@injectable

class FetchConversationSummariesUseCase {

  FetchConversationSummariesUseCase(this._repository);
  final SmartCoachRepository _repository;

  Future<List<Map<String, dynamic>>> call() {
    return _repository.fetchConversationSummaries();
  }
}