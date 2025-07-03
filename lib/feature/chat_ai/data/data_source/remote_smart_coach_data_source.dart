
import 'package:flutter_gemini/flutter_gemini.dart';

abstract class SmartCoachRemoteDataSource {
  Stream<Candidates?> getSmartCoachResponseStream(List<Content> chatHistory,{String? model});
}