import 'package:fitness_app/feature/chat_ai/data/api/gemini_custom_exception.dart';
import 'package:fitness_app/feature/chat_ai/data/api/smart_coach_services.dart';
import 'package:fitness_app/feature/chat_ai/data/data_source/remote_smart_coach_data_source.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SmartCoachRemoteDataSource)
class SmartCoachRemoteDataSourceImpl implements SmartCoachRemoteDataSource {

  SmartCoachRemoteDataSourceImpl(this._service);
  final SmartCoachService _service;

  @override
  Stream<Candidates?> getSmartCoachResponseStream(List<Content> chatHistory) {
    try {
      final geminiStream = _service.streamChat(chatHistory);

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
      throw ServerException(message: 'Failed to initiate chat stream: $e');
    }
  }
}
