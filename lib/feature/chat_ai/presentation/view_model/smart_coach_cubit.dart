
import 'dart:async';
import 'package:fitness_app/core/base_state/base_state.dart';
import 'package:fitness_app/feature/chat_ai/data/api/firesbase_services.dart';
import 'package:fitness_app/feature/chat_ai/data/api/gemini_custom_exception.dart';
import 'package:fitness_app/feature/chat_ai/domain/entity/smart_coach/message_entity.dart';
import 'package:fitness_app/feature/chat_ai/domain/use_case/get_smart_coach_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/feature/chat_ai/presentation/view_model/smart_coach_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class SmartCoachCubit extends Cubit<SmartCoachChatState> {
  SmartCoachCubit(this.getSmartCoachResponseUseCase,this._firebaseService)
      : super(SmartCoachChatState(baseState: BaseInitialState())){
    _startNewConversation();

  }

  final GetSmartCoachResponseUseCase getSmartCoachResponseUseCase;
  final FirebaseChatService _firebaseService;
  String? _currentConversationId;
  StreamSubscription<String>? _chatStreamSubscription;

  @override
  Future<void> close() {
    _chatStreamSubscription?.cancel();
    return super.close();
  }

  Future<void> _startNewConversation() async {
    _currentConversationId = await _firebaseService.startNewConversation();
  }

  void loadConversation(String conversationId, List<MessageEntity> messages) {
    _currentConversationId = conversationId;
    emit(state.copyWith(messages: messages));
  }

  void sendMessage(String prompt) async {
    emit(state.copyWith(
      baseState: BaseLoadingState(),
      isLoading: true,
      errorMessage: null,
    ));

    final userMessage = MessageEntity(text: prompt, sender: Sender.user);

    if (_currentConversationId == null) {
      _currentConversationId = await _firebaseService.startNewConversation();
      await _firebaseService.setConversationTitle(_currentConversationId!, prompt);
    }

    await _firebaseService.saveMessage(_currentConversationId!, userMessage);

    final messagesWithNewUser = [...?state.messages, userMessage];
    emit(state.copyWith(messages: messagesWithNewUser));

    final aiMessagePlaceholder = MessageEntity(text: '', sender: Sender.model);
    final messagesWithPlaceholder = [...messagesWithNewUser, aiMessagePlaceholder];
    emit(state.copyWith(messages: messagesWithPlaceholder));

    final StringBuffer buffer = StringBuffer();
    List<MessageEntity> updatedList = List.from(messagesWithPlaceholder);

    await _chatStreamSubscription?.cancel();

    _chatStreamSubscription = getSmartCoachResponseUseCase
        .call(messagesWithNewUser)
        .listen(
          (chunk) {
        buffer.write(chunk);

        if (updatedList.isNotEmpty && updatedList.last.sender == Sender.user) {
          updatedList.add(aiMessagePlaceholder.copyWith(text: buffer.toString()));
        } else if (updatedList.isNotEmpty) {
          updatedList[updatedList.length - 1] =
              aiMessagePlaceholder.copyWith(text: buffer.toString());
        }

        emit(state.copyWith(messages: updatedList));
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
        }

        final errorMessagesList = List<MessageEntity>.from(state.messages ?? []);
        _updateLastMessageWithError(displayErrorMessage, errorMessagesList);

        emit(state.copyWith(
          baseState: BaseErrorState(
            errorMessage: displayErrorMessage,
            exception: exceptionToReport,
          ),
          isLoading: false,
          errorMessage: displayErrorMessage,
        ));
      },
      onDone: () async {
        emit(state.copyWith(
          baseState: BaseSuccessState(),
          isLoading: false,
          errorMessage: null,
        ));

        if (updatedList.isNotEmpty &&
            updatedList.last.sender == Sender.model &&
            updatedList.last.text.isNotEmpty) {
          await _firebaseService.saveMessage(
            _currentConversationId!,
            updatedList.last,
          );
        }
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
