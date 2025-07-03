//
//  import 'package:flutter_gemini/flutter_gemini.dart';
//
// abstract class SmartCoachRepository {
//   Stream<Candidates?> askSmartCoachStream2(String message,List<Content> history);
//
//   // Stream<Candidates?> askSmartCoachStream(String message);
//   // Future<String> askSmartCoach(String message);
//  }



 import 'package:fitness_app/feature/chat_ai/domain/entity/smart_coach/message_entity.dart';

abstract class SmartCoachRepository {
   Stream<String> getSmartCoachReplyStream(List<MessageEntity> chatHistory);
 }