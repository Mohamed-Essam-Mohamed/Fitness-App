// class SmartCoachCubit extends Cubit<ChatState> {
//
//   SmartCoachCubit(this.useCase) : super(ChatState(messages: []));
//   final GetSmartCoachResponse useCase;
//
//
//   List<Content> _convertToGeminiContent(List<MessageModel> messages) {
//     final List<Content> geminiContent = [];
//     for (int i = 0; i < messages.length; i++) {
//       final msg = messages[i];
//       String text = msg.text;
//
//       if (i == 0 && msg.sender == Sender.user) {
//         text = AppValues.promptPrefix + text;
//       }
//
//       geminiContent.add(Content(
//         role: msg.sender == Sender.user ? 'user' : 'model',
//         parts: [Part.text(text)],
//       ));
//     }
//     return geminiContent;
//   }
//
//   void sendMessage(String prompt) async {
//     final userMessage = MessageModel(text: prompt, sender: Sender.user);
//     final messagesWithNewUser = [...state.messages, userMessage];
//     emit(state.copyWith(messages: messagesWithNewUser, isLoading: true));
//
//     final buffer = StringBuffer();
//
//     final aiMessagePlaceholder = MessageModel(text: '', sender: Sender.model);
//     final updatedMessages = [...messagesWithNewUser, aiMessagePlaceholder];
//     emit(state.copyWith(messages: updatedMessages));
//
//     final fullConversationForGemini = _convertToGeminiContent(messagesWithNewUser);
//
//     await for (final candidate in useCase.callStream2(prompt, fullConversationForGemini)) {
//       if (candidate is Candidates) {
//         final contentParts = candidate.content?.parts ?? [];
//         for (var part in contentParts) {
//           if (part is TextPart) {
//             buffer.write(part.text);
//           }
//         }
//
//         final newMessages = List<MessageModel>.from(updatedMessages);
//         newMessages[newMessages.length - 1] =
//             MessageModel(text: buffer.toString(), sender: Sender.model);
//
//         emit(state.copyWith(messages: newMessages));
//       }
//     }
//
//     emit(state.copyWith(isLoading: false));
//   }
// }

import 'dart:async';
import 'package:fitness_app/core/base_state/base_state.dart';
import 'package:fitness_app/feature/chat_ai/data/api/gemini_custom_exception.dart';
import 'package:fitness_app/feature/chat_ai/domain/entity/smart_coach/message_entity.dart';
import 'package:fitness_app/feature/chat_ai/domain/use_case/get_smart_coach_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fitness_app/feature/chat_ai/presentation/view_model/smart_coach_state.dart';
import 'package:injectable/injectable.dart';

@injectable

// class SmartCoachCubit extends Cubit<SmartCoachChatState> {
//
//   SmartCoachCubit(this.getSmartCoachResponseUseCase) : super(SmartCoachChatState(baseState: BaseInitialState()));
//   final GetSmartCoachResponseUseCase getSmartCoachResponseUseCase;
//
//   void sendMessage(String prompt) async {
//     emit(state.copyWith(errorMessage: null));
//
//     final userMessage = MessageEntity(text: prompt, sender: Sender.user);
//     final messagesWithNewUser = [...?state.messages, userMessage];
//     emit(state.copyWith(messages: messagesWithNewUser, isLoading: true));
//
//     final aiMessagePlaceholder = MessageEntity(text: '', sender: Sender.model);
//     final updatedMessagesWithPlaceholder = [...messagesWithNewUser, aiMessagePlaceholder];
//     emit(state.copyWith(messages: updatedMessagesWithPlaceholder));
//
//     // --- Retry Logic for 429 Errors ---
//     int retryCount = 0;
//     const int maxRetries = 3; // Max attempts to retry API call
//     Duration delay = const Duration(seconds: 1); // Starting delay
//
//     while (retryCount < maxRetries) {
//       try {
//         final streamedResponse = getSmartCoachResponseUseCase.call(messagesWithNewUser);
//         StringBuffer buffer = StringBuffer();
//
//         await for (final String chunk in streamedResponse) {
//           buffer.write(chunk);
//           // Update the last message as data streams in
//           final newMessages = List<MessageEntity>.from(state.messages!);
//           newMessages[newMessages.length - 1] = aiMessagePlaceholder.copyWith(text: buffer.toString());
//           emit(state.copyWith(messages: newMessages));
//         }
//
//         // If stream completes, successful response received
//         emit(state.copyWith(isLoading: false));
//         return; // Exit the retry loop
//       } on ServerException catch (e) {
//         // Check for 429 specifically
//         if (e.statusCode == 429) {
//           retryCount++;
//           if (retryCount < maxRetries) {
//             print('429 error detected. Retrying in ${delay.inSeconds}s (Attempt $retryCount/$maxRetries)');
//             await Future.delayed(delay);
//             delay *= 2; // Exponential backoff
//           } else {
//             // Max retries reached for 429
//             final errorMessage = "FitGenius AI is experiencing high demand. Please try again in a moment.";
//             _updateLastMessageWithError(errorMessage, state.messages);
//             emit(state.copyWith(isLoading: false, errorMessage: errorMessage));
//             break; // Exit retry loop
//           }
//         } else {
//           // Other ServerExceptions (e.g., 400, 500)
//           final errorMessage = "An error occurred: ${e.message}. Please try again.";
//           _updateLastMessageWithError(errorMessage, state.messages);
//           emit(state.copyWith(isLoading: false, errorMessage: errorMessage));
//           break; // Exit retry loop
//         }
//       } catch (e) {
//         // Catch any other unexpected errors
//         final errorMessage = "An unexpected issue occurred. Please try again later.";
//         _updateLastMessageWithError(errorMessage, state.messages);
//         emit(state.copyWith(isLoading: false, errorMessage: errorMessage));
//         break; // Exit retry loop
//       }
//     }
//     // If the loop finishes without success (e.g., max retries hit or other error),
//     // ensure loading state is false.
//     if(state.isLoading) {
//       emit(state.copyWith(isLoading: false));
//     }
//   }
//
//   void _updateLastMessageWithError(String? errorMessage, List<MessageEntity>? currentMessages) {
//     final updatedMessageList = List<MessageEntity>.from(currentMessages!);
//     if (updatedMessageList.isNotEmpty && updatedMessageList.last.sender == Sender.model && updatedMessageList.last.text.isEmpty) {
//       updatedMessageList[updatedMessageList.length - 1] = updatedMessageList.last.copyWith(text: errorMessage);
//     } else {
//       updatedMessageList.add(MessageEntity(text: errorMessage ?? '', sender: Sender.model));
//     }
//     emit(state.copyWith(messages: updatedMessageList));
//   }
// }

class SmartCoachCubit extends Cubit<SmartCoachChatState> {
  SmartCoachCubit(this.getSmartCoachResponseUseCase)
      : super(SmartCoachChatState(baseState: BaseInitialState()));

  final GetSmartCoachResponseUseCase getSmartCoachResponseUseCase;

  StreamSubscription<String>? _chatStreamSubscription;

  @override
  Future<void> close() {
    _chatStreamSubscription?.cancel();
    return super.close();
  }

  void sendMessage(String prompt) async {
    emit(state.copyWith(
      baseState: BaseLoadingState(),
      isLoading: true,
      errorMessage: null,
    ));

    final userMessage = MessageEntity(text: prompt, sender: Sender.user);
    final messagesWithNewUser = [
      ...?state.messages,
      userMessage
    ];
    emit(state.copyWith(
        messages: messagesWithNewUser));

    final aiMessagePlaceholder = MessageEntity(text: '', sender: Sender.model);
    final messagesWithPlaceholder = [
      ...messagesWithNewUser,
      aiMessagePlaceholder
    ];
    emit(state.copyWith(messages: messagesWithPlaceholder));

    await _chatStreamSubscription?.cancel();

    final StringBuffer buffer = StringBuffer();
    final List<MessageEntity> currentMessagesForStream =
        messagesWithPlaceholder;

    _chatStreamSubscription =
        getSmartCoachResponseUseCase.call(messagesWithNewUser).listen(
      (chunk) {
        buffer.write(chunk);

        final updatedList = List<MessageEntity>.from(currentMessagesForStream);
        if (updatedList.isNotEmpty && updatedList.last.sender == Sender.user) {
          updatedList
              .add(aiMessagePlaceholder.copyWith(text: buffer.toString()));
        } else if (updatedList.isNotEmpty) {
          updatedList[updatedList.length - 1] =
              aiMessagePlaceholder.copyWith(text: buffer.toString());
        }
        emit(state.copyWith(
            messages: updatedList));
      },
      onError: (error) {
        String displayErrorMessage =
            'An unknown error occurred. Please try again.';
        Exception? exceptionToReport;

        if (error is ServerException) {
          exceptionToReport = error;
          if (error.statusCode == 429) {
            displayErrorMessage =
                'FitGenius AI is currently experiencing too many requests. Please try again in a moment.';
          } else {
            displayErrorMessage = 'An API error occurred: ${error.message}.';
          }
        } else {
          displayErrorMessage =
              'An unexpected issue occurred. Please try again later.';
        }

        final errorMessagesList =
            List<MessageEntity>.from(state.messages ?? []);
        _updateLastMessageWithError(displayErrorMessage, errorMessagesList);

        emit(state.copyWith(
          baseState: BaseErrorState(
              errorMessage: displayErrorMessage, exception: exceptionToReport),
          isLoading: false,
          errorMessage: displayErrorMessage,
        ));
      },
      onDone: () {
        emit(state.copyWith(
          baseState: BaseSuccessState(),
          isLoading: false,
          errorMessage: null,
        ));
      },
    );
  }

  void _updateLastMessageWithError(
      String errorMessage, List<MessageEntity>? currentMessages) {
    final updatedMessageList = List<MessageEntity>.from(currentMessages!);
    if (updatedMessageList.isNotEmpty &&
        updatedMessageList.last.sender == Sender.model &&
        updatedMessageList.last.text.isEmpty) {
      updatedMessageList[updatedMessageList.length - 1] =
          updatedMessageList.last.copyWith(text: errorMessage);
    } else {
      updatedMessageList.add(MessageEntity(
          text: errorMessage,
          sender: Sender.model));
    }
    emit(state.copyWith(messages: updatedMessageList));
  }
}
