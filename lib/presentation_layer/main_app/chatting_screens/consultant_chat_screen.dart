import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esteshara/core/constants/constants.dart';
import 'package:esteshara/generated/assets.dart';
import 'package:esteshara/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esteshara/business_logic/chat_cubit.dart'; // Import your ChatCubit

class ChatScreen extends StatelessWidget {
  final String chatId;
  final String currentUserId;
  final String userName;
  final String userType;
  final bool? isActive;

  const ChatScreen({super.key, required this.chatId, required this.userType, required this.currentUserId,required this.userName,this.isActive});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff2DACC9),
          automaticallyImplyLeading: false,
          leadingWidth: ScreenSizing.width * 0.7,
          toolbarHeight: kToolbarHeight * 1.2,
          leading: Row(children: [
            const SizedBox(
              width: 10,
            ),
            const CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(Assets.imagesConsultantAvatar),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                userName,
                style: const TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold),
              ),
            )
          ]),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 25,
              ),
            )
          ],
        ),
        body: Container(
          height: ScreenSizing.height,
          width: ScreenSizing.width,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: BlocBuilder<ChatCubit, ChatState>(
                  builder: (context, state) {
                    if (state is ChatLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is MessageSentError) {
                      return Center(child: Text("Error: ${state.error}"));
                    } else {
                      return StreamBuilder<QuerySnapshot>(
                        stream: context.read<ChatCubit>().getMessages(chatId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text("Error: ${snapshot.error}"));
                          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  Assets.imagesChatBackground,
                                  width: ScreenSizing.width * 0.40,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                  child: Text(
                                    'This space is for messaging your therapist. Here you can inquire directly about the sessions and everything related to them. Everything that happens between you and your therapist is completely confidential.',
                                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey[300]),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return ListView(
                              children: snapshot.data!.docs.map((doc) {
                                final message = doc.data() as Map<String, dynamic>;
                                final isMe = message['senderId'] == currentUserId;

                                return Align(
                                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: isMe ? const Color(0xff2DACC9) : Colors.grey[300],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      message['message'],
                                      style: TextStyle(color: isMe ? Colors.white : Colors.black),
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          }
                        },
                      );
                    }
                  },
                ),
              ),
              (isActive??true)? Row(
                children: [
                  Expanded(
                    child: CustomTextFormField3(
                      controller: context.read<ChatCubit>().questionController,
                      title: 'Write a message',
                      hint: 'Enter your message here....',
                    ),
                  ),
                  IconButton(
                    style: IconButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)), backgroundColor: const Color(0xff2DACC9)),
                    onPressed: () {
                      final message = context.read<ChatCubit>().questionController.text.trim();
                      if (message.isNotEmpty) {
                        context.read<ChatCubit>().sendMessage(
                          chatId,
                          currentUserId,
                          chatId.replaceAll(currentUserId, "").replaceAll("_", ""),
                          message,
                        );
                        context.read<ChatCubit>().questionController.clear();
                      }
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ):
              Container(),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}