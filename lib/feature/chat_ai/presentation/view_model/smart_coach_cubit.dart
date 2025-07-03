// import 'dart:async';
// import 'package:fitness_app/feature/chat_ai/domain/use_case/get_smart_coach_usecase.dart';
// import 'package:fitness_app/feature/chat_ai/presentation/view_model/message.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_gemini/flutter_gemini.dart';
//
//
import 'package:fitness_app/feature/chat_ai/domain/use_case/get_smart_coach_usecase.dart';
import 'package:fitness_app/feature/chat_ai/presentation/view_model/message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:fitness_app/feature/chat_ai/data/api/prompt_constants.dart'; // Import PromptConstants
class ChatState {
  final List<MessageModel> messages;
  final bool isLoading;

  ChatState({required this.messages, this.isLoading = false});

  ChatState copyWith({List<MessageModel>? messages, bool? isLoading}) =>
      ChatState(
        messages: messages ?? this.messages,
        isLoading: isLoading ?? this.isLoading,
      );
}

// class SmartCoachCubit extends Cubit<ChatState> {
//   final GetSmartCoachResponse useCase;
//
//   SmartCoachCubit(this.useCase) : super(ChatState(messages: []));
//
//   void sendMessage(String prompt) async {
//     final userMessage = MessageModel(text: prompt, sender: Sender.user);
//     final messages = [...state.messages, userMessage];
//     emit(state.copyWith(messages: messages, isLoading: true));
//
//     final buffer = StringBuffer();
//
//     // Add empty placeholder for AI response
//     final aiMessage = MessageModel(text: "", sender: Sender.ai);
//     final updatedMessages = [...messages, aiMessage];
//     emit(state.copyWith(messages: updatedMessages));
//
//     await for (final candidate in useCase.callStream(prompt)) {
//       if (candidate is Candidates) {
//         final contentParts = candidate.content?.parts ?? [];
//
//         for (var part in contentParts) {
//           // Safely access only text parts
//           if (part is TextPart) {
//             buffer.write(part.text);
//           }
//         }
//
//         // Update the last message with the current accumulated buffer
//         final newMessages = List<MessageModel>.from(updatedMessages);
//         newMessages[newMessages.length - 1] =
//             MessageModel(text: buffer.toString(), sender: Sender.ai);
//
//         emit(state.copyWith(messages: newMessages));
//       }
//     }
//
//     emit(state.copyWith(isLoading: false));
//   }
// }

// In your feature/chat_ai/presentation/view_model/smart_coach_cubit.dart



// Your existing ChatState and MessageModel classes remain the same

class SmartCoachCubit extends Cubit<ChatState> {
  final GetSmartCoachResponse useCase;

  SmartCoachCubit(this.useCase) : super(ChatState(messages: []));

  // Helper to convert your MessageModel to Gemini's Content format
  // This helper will now also prepend the PROMPT_PREFIX for the *first* user message,
  // or integrate it carefully into subsequent messages.
  // A better way is to make the initial "system instruction" a 'user' role
  // in the first message if you want it to be persistent.
  List<Content> _convertToGeminiContent(List<MessageModel> messages) {
    List<Content> geminiContent = [];

    // The system instruction/PROMPT_PREFIX should ideally be part of the initial
    // content of the chat, not prepended to every single user message.
    // If you prepend to every user message, the model gets redundant instructions.
    // For Gemini, there's no direct 'system' role. The common pattern is:
    // User: "PROMPT_PREFIX + first user message"
    // Model: "response"
    // User: "second user message"
    // Model: "response"
    // ...and so on.

    // Let's modify the way the PROMPT_PREFIX is handled to be more efficient
    // for multi-turn chats. It should only affect the *first* user message sent
    // or be implicitly understood by the model from careful initial priming.

    // For simplicity with `streamChat`, we will just convert existing messages.
    // The PROMPT_PREFIX should be added to the *first* user message only,
    // or handled outside this conversion if you want it to always influence
    // the current turn without being part of the history repeatedly.

    // Best practice for persistent system instruction: include it as part of the
    // *very first* `Content` object in the chat history with the 'user' role.

    // Let's adapt this for `streamChat`:
    for (int i = 0; i < messages.length; i++) {
      final msg = messages[i];
      String text = msg.text;

      // Only add the PROMPT_PREFIX to the very first user message.
      // This is a common pattern for "system instructions" in models without a dedicated system role.
      if (i == 0 && msg.sender == Sender.user) {
        text = PromptConstants.PROMPT_PREFIX + text;
      }

      geminiContent.add(Content(
        role: msg.sender == Sender.user ? 'user' : 'model',
        parts: [Part.text(text)],
      ));
    }
    return geminiContent;
  }

  void sendMessage(String prompt) async {
    final userMessage = MessageModel(text: prompt, sender: Sender.user);
    final messagesWithNewUser = [...state.messages, userMessage];
    emit(state.copyWith(messages: messagesWithNewUser, isLoading: true));

    final buffer = StringBuffer();

    // Add empty placeholder for AI response
    final aiMessagePlaceholder = MessageModel(text: "", sender: Sender.ai);
    final updatedMessages = [...messagesWithNewUser, aiMessagePlaceholder];
    emit(state.copyWith(messages: updatedMessages));

    // Convert the entire updated conversation list (including the new user message)
    // into Gemini's Content format. This list will be the 'chats' argument for streamChat.
    final fullConversationForGemini = _convertToGeminiContent(messagesWithNewUser);

    // Now, pass the *full conversation history* to the use case.
    // The `prompt` argument itself isn't directly used by `streamChat` as the last message
    // is already part of `fullConversationForGemini`. We still keep it for consistency
    // with the `callStream` signature, but it's redundant here if `_convertToGeminiContent`
    // correctly adds the last user message.
    await for (final candidate in useCase.callStream2(prompt, fullConversationForGemini)) {
      if (candidate is Candidates) {
        final contentParts = candidate.content?.parts ?? [];

        for (var part in contentParts) {
          if (part is TextPart) {
            buffer.write(part.text);
          }
        }

        // Update the last message (the AI's placeholder) with the streamed content
        final newMessages = List<MessageModel>.from(updatedMessages);
        newMessages[newMessages.length - 1] =
            MessageModel(text: buffer.toString(), sender: Sender.ai);

        emit(state.copyWith(messages: newMessages));
      }
    }

    emit(state.copyWith(isLoading: false));
  }
}