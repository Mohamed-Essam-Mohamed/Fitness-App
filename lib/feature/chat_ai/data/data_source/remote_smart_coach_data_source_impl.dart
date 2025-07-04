import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/feature/chat_ai/data/api/firesbase_services.dart';
import 'package:fitness_app/feature/chat_ai/data/api/gemini_custom_exception.dart';
import 'package:fitness_app/feature/chat_ai/data/api/smart_coach_services.dart';
import 'package:fitness_app/feature/chat_ai/data/data_source/remote_smart_coach_data_source.dart';
import 'package:fitness_app/feature/chat_ai/domain/entity/smart_coach/message_entity.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SmartCoachRemoteDataSource)
class SmartCoachRemoteDataSourceImpl implements SmartCoachRemoteDataSource {

  SmartCoachRemoteDataSourceImpl(this._smartCoachService, this._firebaseChatService);
  final SmartCoachService _smartCoachService;
  final FirebaseChatService _firebaseChatService;

  @override
  Stream<Candidates?> getSmartCoachResponseStream(List<Content> chatHistory,{String? model}) {
    try {
      final geminiStream = _smartCoachService.streamChat(chatHistory,   model: model,);

      return geminiStream.handleError((error) {
        if (error is GeminiException) {
          throw ServerException(
            message: error.message.toString(),
            statusCode: error.statusCode,
            errorData: error.toString(),
          );
        }
        throw error;
      });
    } catch (e) {
      throw ServerException(message: '${LocaleKeys.smart_coach_chat_stream_failed.tr()} $e');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> fetchConversationSummaries() {
    return _firebaseChatService.fetchConversationSummaries();
  }

  @override
  Future<List<MessageEntity>> fetchMessages(String conversationId) {
    return _firebaseChatService.fetchMessages(conversationId);
  }

  @override
  Future<void> deleteConversation(String conversationId) {
    return _firebaseChatService.deleteConversation(conversationId);
  }

  @override
  Future<String> startNewConversation() {
    return _firebaseChatService.startNewConversation();
  }

  @override
  Future<void> saveMessage(String conversationId, MessageEntity message) async {
    try {
      await _firebaseChatService.saveMessage(conversationId, message);
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? LocaleKeys.smart_coach_firebase_error.tr());
    }
  }


  @override
  Future<void> setConversationTitle(String conversationId, String title) {
    return _firebaseChatService.setConversationTitle(conversationId, title);
  }
}
