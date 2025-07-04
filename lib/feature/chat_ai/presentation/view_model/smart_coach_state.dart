

import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/base_state/base_state.dart';
import 'package:fitness_app/feature/chat_ai/domain/entity/smart_coach/message_entity.dart';

class SmartCoachChatState extends Equatable{

  const SmartCoachChatState({
     this.baseState,
     this.messages,
    this.isLoading = false,
    this.errorMessage,
  });
  final BaseState? baseState;
  final List<MessageEntity>? messages;
  final bool isLoading;
  final String? errorMessage;

  SmartCoachChatState copyWith({
     BaseState? baseState,
    List<MessageEntity>? messages,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SmartCoachChatState(
      baseState: baseState ?? this.baseState,
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [baseState, messages, isLoading, errorMessage];
}



