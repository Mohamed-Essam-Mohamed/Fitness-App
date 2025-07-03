// import 'package:fitness_app/feature/chat_ai/domain/repository/smart_coach_repository.dart';
// import 'package:injectable/injectable.dart';
//
// @injectable
// class GetSmartCoachUseCase {
//    GetSmartCoachUseCase(this._smartCoachRepository);
//   final SmartCoachRepository _smartCoachRepository;
//   Future<String> call(String message) => _smartCoachRepository.getReply(message);
//
// }

import 'package:flutter_gemini/flutter_gemini.dart';

import '../repository/smart_coach_repository.dart';


class GetSmartCoachResponse {
  final SmartCoachRepository repository;

  GetSmartCoachResponse(this.repository);

  // Existing function
  Future<String> call(String message) => repository.askSmartCoach(message);

  Stream<Candidates?> callStream(String prompt) =>
      repository.askSmartCoachStream(prompt);

  Stream<Candidates?> callStream2(String prompt, List<Content> history) =>
      repository.askSmartCoachStream2(prompt, history);
}

