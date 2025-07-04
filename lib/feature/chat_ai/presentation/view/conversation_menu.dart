import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/dialogs/app_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/feature/chat_ai/presentation/view_model/smart_coach_cubit.dart';
import 'package:fitness_app/feature/chat_ai/data/api/firesbase_services.dart';

class PreviousConversationsMenu extends StatefulWidget {
  const PreviousConversationsMenu(
      {super.key, required this.onConversationSelected});
  final VoidCallback onConversationSelected;

  @override
  State<PreviousConversationsMenu> createState() =>
      _PreviousConversationsMenuState();
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
      decoration: const BoxDecoration(
          color: Color(0xEE242424),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), bottomLeft: Radius.circular(24))),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                      widget.onConversationSelected();
                    },
                    child:  const Text(
                      'Previous Conversations',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: _loading
                  ? const Center(
                      child: CircularProgressIndicator(color:AppColors.orange))
                  : ListView.builder(
                      itemCount: _conversations.length,
                      itemBuilder: (context, index) {
                        final convo = _conversations[index];
                        return Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                final messages = await _firebaseService
                                    .fetchMessages(convo['id']);
                                context
                                    .read<SmartCoachCubit>()
                                    .loadConversation(convo['id'], messages);
                                widget.onConversationSelected();
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.redAccent),
                                      onPressed: () async {
                                        final confirmed =
                                            await showDialog<bool>(
                                          context: context,
                                          builder: (context) => AppCustomDialog(
                                            title: 'Delete Chat',
                                            message:
                                                'Are you sure you want to delete this chat?',
                                            onConfirm: () =>
                                                Navigator.of(context).pop(true),
                                            onCancel: () =>
                                                Navigator.of(context)
                                                    .pop(false),
                                            cancelButtonText: 'Cancel',
                                            confirmButtonText: 'Delete',
                                          ),
                                        );

                                        if (confirmed == true) {
                                          await _firebaseService
                                              .deleteConversation(convo['id']);
                                          _loadConversations();
                                        }
                                      },
                                    ),
                                    Expanded(
                                      child: Text(
                                        convo['text'] ??
                                            'Conversation ${index + 1}',
                                        style: const TextStyle(
                                            color: Colors.white),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(color: Color(0xFF2D2D2D)),
                          ],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
