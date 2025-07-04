
import 'package:fitness_app/feature/chat_ai/domain/entity/smart_coach/message_entity.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

abstract class SmartCoachRemoteDataSource {
  Stream<Candidates?> getSmartCoachResponseStream(List<Content> chatHistory,{String? model});
  Future<List<Map<String, dynamic>>> fetchConversationSummaries();
  Future<List<MessageEntity>> fetchMessages(String conversationId);
  Future<void> deleteConversation(String conversationId);
  Future<String> startNewConversation();
  Future<void> saveMessage(String conversationId, MessageEntity message);
  Future<void> setConversationTitle(String conversationId, String title);
}