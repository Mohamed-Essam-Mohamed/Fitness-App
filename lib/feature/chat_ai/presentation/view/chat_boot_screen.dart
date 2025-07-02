import 'dart:ui';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/pop_widget.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/theme/app_theme.dart';

class ChatBootScreen extends StatefulWidget {
  const ChatBootScreen({super.key});

  @override
  State<ChatBootScreen> createState() => _ChatBootScreenState();
}

class _ChatBootScreenState extends State<ChatBootScreen> {
  final List<Map<String, dynamic>> messages = [
    {"fromBot": true, "text": "Hello! How can I assist you today?"},
  ];

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add({"fromBot": false, "text": text});
      // You can also simulate a bot reply here if needed
    });

    _controller.clear();

    // Scroll to bottom after short delay
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 100,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background
            Positioned.fill(
              child: Image.asset(
                ImageAsset.backGroundRobot,
                fit: BoxFit.fill,
              ),
            ),

            // Foreground
            Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      pop_widget(context, (){Navigator.pop(context);}),
                      Text("Smart Coach", style: AppTheme.lightTheme.textTheme.titleLarge),
                      Image.asset(ImageAsset.menu, height: 24),
                    ],
                  ),
                ),

                // Chat messages
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isBot = message["fromBot"] as bool;
                      final text = message["text"] as String;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: isBot
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (isBot)
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: AssetImage(ImageAsset.logo),
                              ),
                            if (!isBot) const SizedBox(width: 40),

                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                margin: const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  color: isBot
                                      ? AppColors.gray.withOpacity(0.07)
                                      : Color(0xFFFF6A00).withOpacity(0.6),
                                  borderRadius: BorderRadius.only(
                      bottomLeft: const Radius.circular(20),
                      bottomRight: const Radius.circular(20),
                      topLeft : Radius.circular(isBot ? 0 : 20),
                      topRight : Radius.circular(isBot ? 20 : 0),
                                  ),
                                ),
                                child: Text(
                                  text,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),

                            if (!isBot)
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: AssetImage(ImageAsset.logo),
                              ),
                            if (isBot) const SizedBox(width: 40),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Message Input
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: TextField(
                            controller: _controller,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: 'Type your message...',
                              hintStyle: TextStyle(color: Colors.white54),
                              border: InputBorder.none,
                            ),
                            onSubmitted: (_) => _sendMessage(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: const Icon(Icons.send, color: Colors.white),
                        onPressed: _sendMessage,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
