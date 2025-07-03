// import 'package:fitness_app/feature/chat_ai/data/api/smart_coach_services.dart';
// import 'package:fitness_app/feature/chat_ai/domain/repository/smart_coach_repository.dart';
// import 'package:fitness_app/feature/chat_ai/domain/use_case/get_smart_coach_usecase.dart';
// import 'package:fitness_app/feature/chat_ai/presentation/view_model/message.dart';
// import 'package:fitness_app/feature/chat_ai/presentation/view_model/smart_coach_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class ChatAiScreen extends StatelessWidget {
//   ChatAiScreen({super.key});
//
//   final TextEditingController _controller = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final service = SmartCoachService();
//     final repo = SmartCoachRepository(service);
//     final usecase = GetSmartCoachUseCase(repo);
//
//     return BlocProvider(
//       create: (_) => ChatCubit(usecase),
//       child: Builder( // 👈 This creates a new context within the BlocProvider scope
//         builder: (context) => Scaffold(
//           appBar: AppBar(title: const Text('Smart Coach')),
//           body: Column(
//             children: [
//               Expanded(
//                 child: BlocBuilder<ChatCubit, ChatState>(
//                   builder: (ctx, state) => ListView.builder(
//                     itemCount: state.messages.length,
//                     itemBuilder: (c, i) {
//                       final msg = state.messages[i];
//                       final align = msg.sender == Sender.user
//                           ? Alignment.centerRight
//                           : Alignment.centerLeft;
//                       return Align(
//                         alignment: align,
//                         child: Container(
//                           margin: const EdgeInsets.all(8),
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             color: msg.sender == Sender.user
//                                 ? Colors.blue
//                                 : Colors.grey[300],
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Text(
//                             msg.text,
//                             style: TextStyle(
//                               color: msg.sender == Sender.user
//                                   ? Colors.white
//                                   : Colors.black,
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//               _buildQuickSuggestions(context),
//               _buildInputArea(context),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildQuickSuggestions(BuildContext ctx) {
//     final chips = [
//       "Suggest breakfast",
//       "Suggest lunch for muscle gain",
//       "Suggest dinner for fat loss",
//       "Suggest post-workout meal"
//     ];
//     return Wrap(
//       spacing: 8,
//       children: chips
//           .map((t) => ActionChip(
//         label: Text(t),
//         onPressed: () {
//           _controller.text = t;
//           _send(ctx);
//         },
//       ))
//           .toList(),
//     );
//   }
//
//   Widget _buildInputArea(BuildContext ctx) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: _controller,
//               decoration: const InputDecoration(hintText: 'Ask coach...'),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.send),
//             onPressed: () => _send(ctx),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _send(BuildContext ctx) {
//     final text = _controller.text.trim();
//     if (text.isNotEmpty) {
//       ctx.read<ChatCubit>().send(text);
//       _controller.clear();
//     }
//   }
// }
import 'package:fitness_app/feature/chat_ai/data/api/smart_coach_services.dart';
import 'package:fitness_app/feature/chat_ai/data/repository_impl/smart_coach_repository_impl.dart';
import 'package:fitness_app/feature/chat_ai/domain/use_case/get_smart_coach_usecase.dart';
import 'package:fitness_app/feature/chat_ai/presentation/view_model/message.dart';
import 'package:fitness_app/feature/chat_ai/presentation/view_model/smart_coach_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatAiScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  ChatAiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SmartCoachCubit(
        GetSmartCoachResponse(
          SmartCoachRepositoryImpl(SmartCoachService()),
        ),
      ),
      child: Builder(
        builder: (ctx) => Scaffold(
          appBar: AppBar(title: const Text("Smart Coach")),
          body: Column(
            children: [
              Expanded(
                child: BlocBuilder<SmartCoachCubit, ChatState>(
                  builder: (context, state) {
                    return ListView.builder(
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        final msg = state.messages[index];
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
              // _buildSuggestions(ctx),
              _buildInput(ctx),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput(BuildContext ctx) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: "Ask coach..."),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
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
  }

  Widget _buildSuggestions(BuildContext ctx) {
    final suggestions = [
      "Suggest breakfast",
      "Lunch for muscle gain",
      "Dinner for fat loss",
      "Post-workout meal",
    ];

    return Wrap(
      spacing: 8,
      children: suggestions
          .map((s) => ActionChip(
        label: Text(s),
        onPressed: () {
          _controller.text = s;
          ctx.read<SmartCoachCubit>().sendMessage(s);
        },
      ))
          .toList(),
    );
  }
}
