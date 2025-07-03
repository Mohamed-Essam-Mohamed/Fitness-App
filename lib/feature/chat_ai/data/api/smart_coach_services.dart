import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class SmartCoachService {
  Stream<Candidates?> streamChat(List<Content> history) {
    return Gemini.instance.streamChat(history);
  }
}
// class SmartCoachService {
//   Stream<Candidates?> askStream2(String prompt, List<Content> history) {
//     return Gemini.instance.streamChat(history);
//   }



  // Stream<Candidates?> askStream(String prompt) {
  //   final scopedPrompt = AppValues.PROMPT_PREFIX + prompt;
  //   return Gemini.instance.promptStream(parts: [
  //     Part.text(scopedPrompt),
  //   ]);
  // }
  //
  // Future<String> singleTurnAsk(String prompt) async {
  //   final scopedPrompt = AppValues.PROMPT_PREFIX + prompt;
  //   final response = await Gemini.instance.prompt(parts: [
  //     Part.text(scopedPrompt),
  //   ]);
  //   return response?.output ?? AppValues.PROMPT_FALLBACK;
  // }
//}
