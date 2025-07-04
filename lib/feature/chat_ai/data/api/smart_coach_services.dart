import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class SmartCoachService {
  Stream<Candidates?> streamChat(List<Content> history,{String? model}) {
    return Gemini.instance.streamChat(history,modelName: model);
  }
}

