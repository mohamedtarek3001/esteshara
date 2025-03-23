import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esteshara/presentation_layer/main_app/chatting_screens/consultant_chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esteshara/business_logic/chat_cubit.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:quickalert/quickalert.dart';

import '../../../business_logic/chat_cubit.dart';

class UserChatRoomsScreen extends StatelessWidget {

  UserChatRoomsScreen({super.key,required this.isActive,required this.isApproved});
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
            stream: context.read<ChatCubit>().getChatRoomsForUser(
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
                            extentRatio:isActive?0.3: 0.7,
                            motion: const ScrollMotion(),
                            children: [
                             SlidableAction(
                               onPressed: (context) {
                                 showDialog(context: context, builder: (context) => AlertDialog(
                                   title: const Text('Add Review'),
                                   content: SizedBox(
                                     height: 120,
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.stretch,
                                       children: [
                                         const Text('Rate the consultant'),
                                         RatingBar.builder(
                                           initialRating: 3,
                                           minRating: 1,
                                           direction: Axis.horizontal,
                                           allowHalfRating: true,
                                           itemCount: 5,
                                           itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                           itemBuilder: (context, _) => const Icon(
                                             Icons.star,
                                             color: Colors.amber,
                                           ),
                                           onRatingUpdate: (rating) {
                                             context.read<ChatCubit>().setRating(rating);

                                           },
                                         ),
                                         ElevatedButton(
                                           onPressed: () {
                                             context.read<ChatCubit>().reviewConsultant(consultantId: otherUserId, rate: context.read<ChatCubit>().rating??0);
                                             Navigator.pop(context);
                                           },
                                           child: const Text('Submit'),
                                         ),

                                       ],
                                     ),
                                   ),
                                 ),);

                               },
                               backgroundColor: Colors.amber[800]!,
                               foregroundColor: Colors.white,
                               icon: Icons.reviews,
                               label:  'Add Review',
                             ),
                              !isActive? SlidableAction(
                               onPressed: (context) {
                                 context.read<ChatCubit>().changeChatRoomActivity(
                                   chatId: chatRoom['chatId'],
                                   isActive: true,
                                 );
                               },
                               backgroundColor: Colors.greenAccent,
                               foregroundColor: Colors.white,
                               icon: Icons.lock_open,
                               label:  'Open Chat',
                             ):Container()
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
                                      userType: 'user',
                                      chatId: chatRoom['chatId'],
                                      userName: otherUserName,
                                      currentUserId:
                                      firebaseAuth.currentUser?.uid ?? '',
                                      isActive: isActive,
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
