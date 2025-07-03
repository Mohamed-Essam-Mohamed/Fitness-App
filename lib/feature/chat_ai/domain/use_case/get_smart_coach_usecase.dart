
import 'package:fitness_app/feature/chat_ai/domain/entity/smart_coach/message_entity.dart';
import 'package:fitness_app/feature/chat_ai/domain/repository/smart_coach_repository.dart';
import 'package:injectable/injectable.dart';


//
// class GetSmartCoachResponse {
//
//   GetSmartCoachResponse(this.repository);
//   final SmartCoachRepository repository;
//
//   // Future<String> call(String message) => repository.askSmartCoach(message);
//   //
//   // Stream<Candidates?> callStream(String prompt) =>
//   //     repository.askSmartCoachStream(prompt);
//
//   Stream<Candidates?> callStream2(String prompt, List<Content> history) =>
//       repository.askSmartCoachStream2(prompt, history);
// }

// lib/feature/chat_ai/domain/use_case/get_smart_coach_response_usecase.dart

@injectable

class GetSmartCoachResponseUseCase {

  GetSmartCoachResponseUseCase(this._repository);
  final SmartCoachRepository _repository;

  Stream<String> call(List<MessageEntity> chatHistory) {
    return _repository.getSmartCoachReplyStream(chatHistory);
  }
}