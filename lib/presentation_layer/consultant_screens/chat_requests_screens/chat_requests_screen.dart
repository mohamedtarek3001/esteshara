import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esteshara/business_logic/chat_cubit.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../business_logic/chat_cubit.dart';
import '../../main_app/chatting_screens/consultant_chat_screen.dart'; // Import your ChatCubit

class ConsultantChatRequestsScreen extends StatelessWidget {

  ConsultantChatRequestsScreen({super.key,required this.isActive,required this.isApproved});
  final bool isActive;
  final bool isApproved;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff2DACC9),
        centerTitle: true,
        title: const Text("Chats",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
      ),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          return StreamBuilder<List<Map<String, dynamic>>>(
            stream: context.read<ChatCubit>().getChatRoomsForConsultant(
              firebaseAuth.currentUser?.uid ?? '',
              isActive,
              isApproved,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("No chats found."));
              } else {
                final chatRooms = snapshot.data!;
                return ListView.builder(
                  itemCount: chatRooms.length,
                  itemBuilder: (context, index) {
                    final chatRoom = chatRooms[index];
                    final otherUserId = chatRoom['otherUserId'];
                    final otherUserName = chatRoom['otherUserName'];

                    return StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('human_chats')
                          .doc(chatRoom['chatId'])
                          .collection('messages')
                          .orderBy('timestamp', descending: true)
                          .limit(1)
                          .snapshots(),
                      builder: (context, messageSnapshot) {
                        final lastMessage = messageSnapshot.hasData &&
                            messageSnapshot.data!.docs.isNotEmpty
                            ? messageSnapshot.data!.docs.first['message']
                            : "No messages yet";

                        return Slidable(
                          key: ValueKey(chatRoom['chatId']),
                          startActionPane: ActionPane(
                            extentRatio: 0.3,
                            motion: const ScrollMotion(),
                            children: [
                             !isApproved? SlidableAction(
                                onPressed: (context) {
                                  context.read<ChatCubit>().approveChatRoom(
                                    chatId: chatRoom['chatId'],
                                    isApproved: !isApproved,
                                  );
                                },
                                backgroundColor: Colors.greenAccent,
                                foregroundColor: Colors.white,
                                icon:  Icons.check,
                                label: 'Approve',
                              ):
                             SlidableAction(
                               onPressed: (context) {
                                 context.read<ChatCubit>().changeChatRoomActivity(
                                   chatId: chatRoom['chatId'],
                                   isActive: !isActive,
                                 );
                               },
                               backgroundColor:
                               isActive ? Colors.red : Colors.blue,
                               foregroundColor: Colors.white,
                               icon: isActive
                                   ? Icons.archive_outlined
                                   : Icons.unarchive_outlined,
                               label: isActive ? 'Archive' : 'UnArchive',
                             )
                            ],
                          ),
                          child: ListTile(
                            leading: const CircleAvatar(
                              radius: 28,
                            ),
                            title: Text("User $otherUserName"),
                            subtitle: Text(isApproved?"Last Message: $lastMessage":"Pending For Approval"),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatScreen(
                                    userType: 'consultant',
                                    chatId: chatRoom['chatId'],
                                    userName: otherUserName,
                                    currentUserId:
                                    firebaseAuth.currentUser?.uid ?? '',
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
