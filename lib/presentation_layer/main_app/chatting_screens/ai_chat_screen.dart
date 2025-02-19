import 'package:esteshara/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/ai_cubit.dart';
import '../../../models/chat_message_model.dart';

class AIChatScreen extends StatelessWidget {
  AIChatScreen({super.key});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<ChatMessage>>(
              stream: context.read<AiCubit>().getChatStream(),
              builder: (context, snapshot) {
                var messages = snapshot.data ?? [];
                bool isLoading = context.watch<AiCubit>().isLoading; // Listen for AI loading state

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_scrollController.hasClients) {
                    _scrollController.jumpTo(_scrollController.position.minScrollExtent);
                  }
                });

                return ListView.builder(
                  controller: _scrollController,
                  itemCount: messages.length + (isLoading ? 1 : 0), // Add loading bubble
                  reverse: true, // Show latest messages at the bottom
                  itemBuilder: (context, index) {
                    if (isLoading && index == 0) {
                      return const TypingBubble(); // Show AI typing animation
                    }
                    return ChatBubble(message: messages[index - (isLoading ? 1 : 0)]);
                  },
                );
              },
            ),
          ),
          _buildMessageInput(context),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xff2DACC9),
      title: const Text('AI Chatting', style: TextStyle(color: Colors.white)),
      leading: BlocBuilder<AiCubit, AiState>(
        builder: (context, state) {
          return IconButton(onPressed: () async {
            await context.read<AiCubit>().clearChatHistory();
          }, icon: Icon(Icons.restore_from_trash_outlined));
        },
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.canPop(context) ? Navigator.pop(context) : null;
          },
          icon: const Icon(Icons.arrow_forward, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: CustomTextFormField3(
              controller: context.read<AiCubit>().questionController,
              title: 'Type somthing here.....',
              hint: 'Please enter your question...',
            ),
          ),
          IconButton(
            onPressed: () {
              String messageText = context.read<AiCubit>().questionController.text.trim();
              if (messageText.isNotEmpty) {
                context.read<AiCubit>().sendMessage(messageText);
                context.read<AiCubit>().questionController.clear();
              }
            },
            icon: const Icon(Icons.send, color: Colors.white),
            style: IconButton.styleFrom(backgroundColor: const Color(0xff2DACC9)),
          ),
        ],
      ),
    );
  }
}

class TypingBubble extends StatefulWidget {
  const TypingBubble({super.key});

  @override
  _TypingBubbleState createState() => _TypingBubbleState();
}

class _TypingBubbleState extends State<TypingBubble> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _dotCount;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 1), vsync: this)..repeat(reverse: true);
    _dotCount = IntTween(begin: 1, end: 3).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft, // AI messages appear on the left
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
        child: AnimatedBuilder(
          animation: _dotCount,
          builder: (context, child) {
            return Text(
              'AI is typing${'.' * _dotCount.value}', // Show animated dots
              style: const TextStyle(color: Colors.black, fontSize: 14),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  /// Function to detect if the text is in Arabic
  bool isArabic(String text) {
    final arabicRegex = RegExp(r'[\u0600-\u06FF]');
    return arabicRegex.hasMatch(text);
  }

  @override
  Widget build(BuildContext context) {
    bool isArabicText = isArabic(message.text);

    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: message.isUser ? Colors.cyan[500] : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Directionality(
          textDirection: isArabicText ? TextDirection.rtl : TextDirection.ltr,
          child: Text(
            message.text,
            textAlign: isArabicText ? TextAlign.right : TextAlign.left,
            style: TextStyle(
              color: message.isUser ? Colors.white : Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
