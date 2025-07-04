import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/feature/chat_ai/presentation/view_model/smart_coach_cubit.dart';
import 'package:fitness_app/feature/chat_ai/domain/entity/smart_coach/message_entity.dart';
import 'package:fitness_app/feature/chat_ai/data/api/firesbase_services.dart';

class PreviousConversationsMenu extends StatefulWidget {
  final VoidCallback onConversationSelected;
  const PreviousConversationsMenu({super.key, required this.onConversationSelected});

  @override
  State<PreviousConversationsMenu> createState() => _PreviousConversationsMenuState();
}

class _PreviousConversationsMenuState extends State<PreviousConversationsMenu> {
  final FirebaseChatService _firebaseService = FirebaseChatService();
  List<Map<String, dynamic>> _conversations = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadConversations();
  }

  Future<void> _loadConversations() async {
    final fetched = await _firebaseService.fetchConversationSummaries();
    setState(() {
      _conversations = fetched;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.9),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: _loading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : ListView.builder(
        itemCount: _conversations.length,
        itemBuilder: (context, index) {
          final convo = _conversations[index];
          return Card(
            color: Colors.white10,
            child: ListTile(
              title: Text(
                convo['title'] ?? 'Conversation ${index + 1}',
                style: const TextStyle(color: Colors.white),
              ),
              onTap: () async {
                final messages = await _firebaseService.fetchMessages(convo['id']);
                context.read<SmartCoachCubit>().loadConversation(convo['id'], messages);
                widget.onConversationSelected();
              },
            ),
          );
        },
      ),
    );
  }
}
