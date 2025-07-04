

 import 'package:fitness_app/feature/chat_ai/domain/entity/smart_coach/message_entity.dart';

abstract class SmartCoachRepository {
   Stream<String> getSmartCoachReplyStream(List<MessageEntity> chatHistory);
   Future<void> saveMessage(String conversationId, MessageEntity message);
   Future<List<Map<String, dynamic>>> fetchConversationSummaries();
   Future<List<MessageEntity>> fetchMessages(String conversationId);
   Future<void> deleteConversation(String conversationId);
   Future<String> startNewConversation();
   Future<void> setConversationTitle(String conversationId, String title);
 }