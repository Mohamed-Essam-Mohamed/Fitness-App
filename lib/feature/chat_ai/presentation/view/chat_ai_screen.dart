
import 'package:fitness_app/feature/chat_ai/domain/entity/smart_coach/message_entity.dart';
import 'package:fitness_app/feature/chat_ai/presentation/view_model/smart_coach_cubit.dart';
import 'package:fitness_app/feature/chat_ai/presentation/view_model/smart_coach_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class ChatAiScreen extends StatefulWidget {
  const ChatAiScreen({super.key});

  @override
  State<ChatAiScreen> createState() => _ChatAiScreenState();
}

class _ChatAiScreenState extends State<ChatAiScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SmartCoachCubit>(),
      child: Builder(
        builder: (ctx) => Scaffold(
          appBar: AppBar(title: const Text('Smart Coach')),
          body: Column(
            children: [
              Expanded(
                child: BlocConsumer<SmartCoachCubit, SmartCoachChatState>(
                  listener: (context, state) {
                    if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.errorMessage!),
                          backgroundColor: Colors.red,
                        ),
                      );

                    }

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (_scrollController.hasClients) {
                        _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      }
                    });


                  },
                  builder: (context, state) {
                    final messages = state.messages ?? [];

                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final msg = messages[index];
                        final align = msg.sender == Sender.user
                            ? Alignment.centerRight
                            : Alignment.centerLeft;
                        final bgColor = msg.sender == Sender.user
                            ? Colors.blue
                            : Colors.grey[300];
                        final textColor = msg.sender == Sender.user
                            ? Colors.white
                            : Colors.black;

                        return Align(
                          alignment: align,
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(msg.text, style: TextStyle(color: textColor)),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              _buildInput(ctx),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput(BuildContext ctx) {
    return BlocBuilder<SmartCoachCubit, SmartCoachChatState>(
      builder: (context, state) {
        final bool isLoading = state.isLoading;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: isLoading ? 'Thinking...' : 'Ask coach...',
                    border: const OutlineInputBorder(),
                  ),
                  enabled: !isLoading,
                  onSubmitted: (text) {
                    if (!isLoading && text.trim().isNotEmpty) {
                      ctx.read<SmartCoachCubit>().sendMessage(text.trim());
                      _controller.clear();
                    }
                  },
                ),
              ),
              IconButton(
                icon: isLoading
                    ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
                    : const Icon(Icons.send),
                onPressed: isLoading
                    ? null
                    : () {
                  final text = _controller.text.trim();
                  if (text.isNotEmpty) {
                    ctx.read<SmartCoachCubit>().sendMessage(text);
                    _controller.clear();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}