
import 'package:fitness_app/feature/chat_ai/data/api/prompt_constants.dart';
import 'package:flutter_gemini/flutter_gemini.dart';



class SmartCoachService
{
  Stream<Candidates?> askStream2(String prompt, List<Content> history) {

    return Gemini.instance.streamChat(history);
  }

  Stream<Candidates?> askStream(String prompt) {
    final scopedPrompt = PromptConstants.PROMPT_PREFIX + prompt;
    return Gemini.instance.promptStream(parts: [
      Part.text(scopedPrompt),
    ]);
  }

  Future<String> singleTurnAsk(String prompt) async {
    final scopedPrompt = PromptConstants.PROMPT_PREFIX + prompt;
    final response = await Gemini.instance.prompt(parts: [
      Part.text(scopedPrompt),
    ]);
    return response?.output ?? PromptConstants.PROMPT_FALLBACK;
  }
}


