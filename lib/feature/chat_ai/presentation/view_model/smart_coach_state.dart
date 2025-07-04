

import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/base_state/base_state.dart';
import 'package:fitness_app/feature/chat_ai/domain/entity/smart_coach/message_entity.dart';

class SmartCoachChatState extends Equatable {
  const SmartCoachChatState({
    this.firstName,
    this.photo,
    this.baseState,
    this.messages,
    this.isLoading = false,
    this.errorMessage,
  });

  final String? firstName;
  final String? photo;
  final BaseState? baseState;
  final List<MessageEntity>? messages;
  final bool isLoading;
  final String? errorMessage;

  SmartCoachChatState copyWith({
    String? firstName,
    String? photo,
    BaseState? baseState,
    List<MessageEntity>? messages,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SmartCoachChatState(
      firstName: firstName ?? this.firstName,
      photo: photo ?? this.photo,
      baseState: baseState ?? this.baseState,
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [firstName, photo, baseState, messages, isLoading, errorMessage];
}


