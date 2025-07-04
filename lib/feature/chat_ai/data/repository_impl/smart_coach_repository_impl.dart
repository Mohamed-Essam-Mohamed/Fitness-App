
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/feature/chat_ai/data/api/gemini_custom_exception.dart';
import 'package:fitness_app/feature/chat_ai/data/data_source/remote_smart_coach_data_source.dart';
import 'package:fitness_app/feature/chat_ai/domain/entity/smart_coach/message_entity.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter_gemini/flutter_gemini.dart';



import 'package:fitness_app/feature/chat_ai/domain/repository/smart_coach_repository.dart';
import 'package:fitness_app/core/constants/app_values.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: SmartCoachRepository)

class SmartCoachRepositoryImpl implements SmartCoachRepository {

  SmartCoachRepositoryImpl(this.remoteDataSource);
  final SmartCoachRemoteDataSource remoteDataSource;

  List<Content> _mapMessagesToGeminiContent(List<MessageEntity> messages) {
    final List<Content> geminiContent = [];
    for (int i = 0; i < messages.length; i++) {
      final msg = messages[i];
      String text = msg.text;

      if (i == 0 && msg.sender == Sender.user) {
        text = AppValues.promptPrefix + text;
      }

      geminiContent.add(Content(
        role: msg.sender == Sender.user ? AppValues.user : AppValues.model,
        parts: [Part.text(text)],
      ));
    }
    return geminiContent;
  }

  @override
  Stream<String> getSmartCoachReplyStream(List<MessageEntity> chatHistory) {
    try {
      final geminiChatHistory = _mapMessagesToGeminiContent(chatHistory);
      final geminiResponseStream = remoteDataSource.getSmartCoachResponseStream(geminiChatHistory,  model: AppValues.geminiModel ,  );

      return geminiResponseStream.map((candidate) {
        if (candidate == null || candidate.content == null) {
          return AppValues.promptFallback;
        }

        final contentParts = candidate.content!.parts;
        final StringBuffer buffer = StringBuffer();
        for (var part in contentParts!) {
          if (part is TextPart) {
            buffer.write(part.text);
          }
        }
        return buffer.toString().trim();
      }).handleError((error) {
        if (error is ServerException) {
          throw error;
        }

        throw ServerException(message: ' ${LocaleKeys.smart_coach_unexpected_error_repo.tr()} $error');
      });
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: '${LocaleKeys.smart_coach_chat_request_failed.tr()} $e');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> fetchConversationSummaries() {
    return remoteDataSource.fetchConversationSummaries();
  }

  @override
  Future<List<MessageEntity>> fetchMessages(String conversationId) {
    return remoteDataSource.fetchMessages(conversationId);
  }

  @override
  Future<void> deleteConversation(String conversationId) {
    return remoteDataSource.deleteConversation(conversationId);
  }

  @override
  Future<String> startNewConversation() {
    return remoteDataSource.startNewConversation();
  }

  @override
  Future<void> saveMessage(String conversationId, MessageEntity message) {
    return remoteDataSource.saveMessage(conversationId, message);
  }

  @override
  Future<void> setConversationTitle(String conversationId, String title) {
    return remoteDataSource.setConversationTitle(conversationId, title);
  }
}
