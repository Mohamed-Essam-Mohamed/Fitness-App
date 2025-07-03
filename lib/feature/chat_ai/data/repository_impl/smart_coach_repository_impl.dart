// import 'package:fitness_app/feature/chat_ai/data/data_source/remote_smart_coach_data_source.dart';
// import 'package:fitness_app/feature/chat_ai/domain/repository/smart_coach_repository.dart';
// import 'package:injectable/injectable.dart';
//
// @Injectable(as: SmartCoachRepository)
// class SmartCoachRepositoryImpl implements SmartCoachRepository {
//   SmartCoachRepositoryImpl(this._remoteSmartCoachDataSource);
//   final RemoteSmartCoachDataSource _remoteSmartCoachDataSource;
//
// }
import 'package:fitness_app/feature/chat_ai/data/api/gemini_custom_exception.dart';
import 'package:fitness_app/feature/chat_ai/data/data_source/remote_smart_coach_data_source.dart';
import 'package:fitness_app/feature/chat_ai/domain/entity/smart_coach/message_entity.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

//
// class SmartCoachRepositoryImpl implements SmartCoachRepository {
//   SmartCoachRepositoryImpl(this.service);
//   final SmartCoachService service;
//
//
//   //
//   // @override
//   // Future<String> askSmartCoach(String message) =>
//   //     service.singleTurnAsk(message);
//   //
//   // @override
//   // Stream<Candidates?> askSmartCoachStream(String message) =>
//   //     service.askStream(message);
//
//   @override
//   Stream<Candidates?> askSmartCoachStream2(String message, List<Content> history) =>
//     service.askStream2(message,history);
// }


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
        role: msg.sender == Sender.user ? 'user' : 'model',
        parts: [Part.text(text)],
      ));
    }
    return geminiContent;
  }

  @override
  Stream<String> getSmartCoachReplyStream(List<MessageEntity> chatHistory) {
    try {
      final geminiChatHistory = _mapMessagesToGeminiContent(chatHistory);
      final geminiResponseStream = remoteDataSource.getSmartCoachResponseStream(geminiChatHistory);

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

        throw ServerException(message: 'An unexpected error occurred in repository: $error');
      });
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Failed to process chat request: $e');
    }
  }
}
