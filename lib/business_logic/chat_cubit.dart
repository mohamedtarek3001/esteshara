import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController questionController = TextEditingController();
  bool isLoading = false;

  // Method to set loading state to true
  void setIsLoadingTrue() {
    isLoading = true;
    emit(ChatLoading());
  }

  // Method to set loading state to false
  void setIsLoadingFalse() {
    isLoading = false;
    emit(ChatLoaded());
  }

  // Method to create or get a chat room
  Future<Map<String, Map<bool,bool>>> getOrCreateChatRoom({required String userUid, required String consultantUid, required String userName, required String consultantName}) async {
    // Sort user IDs to ensure unique chat room
    List<String> participants = [userUid, consultantUid];
    participants.sort();
    String chatId = participants.join("_");

    // Check if chat room already exists
    final chatRoom = await _firestore.collection('human_chats').doc(chatId).get();
    bool isApproved = chatRoom.data()?['isApproved'] ?? false;
    bool isActive = chatRoom.data()?['isActive'] ?? true;
    if (kDebugMode) {
      print(chatRoom.data());
    }
    if (!chatRoom.exists) {
      // Create a new chat room
      await _firestore.collection('human_chats').doc(chatId).set({
        'participants': participants,
        'userName': userName,
        'consultantName': consultantName,
        'isActive': true,
        'isApproved': false,
        'createdAt': Timestamp.now(),
      });
    }

    return {chatId: {isApproved : isActive}
    };
  }

  Future<String> changeChatRoomActivity({required String chatId, required bool isActive}) async {
    // Check if chat room already exists
    final chatRoom = await _firestore.collection('human_chats').doc(chatId).get();
    if (kDebugMode) {
      print(chatRoom.data());
    }
    if (!chatRoom.exists) {
      // Create a new chat room
      await _firestore.collection('human_chats').doc(chatId).set({
        'isActive': isActive,
      });
    }
    else {
      // Create a new chat room
      await _firestore.collection('human_chats').doc(chatId).update({
        'isActive': isActive,
      });
    }
    return chatId;
  }

  Future<String> approveChatRoom({required String chatId, required bool isApproved}) async {
    // Check if chat room already exists
    final chatRoom = await _firestore.collection('human_chats').doc(chatId).get();
    if (kDebugMode) {
      print(chatRoom.data());
    }
    if (!chatRoom.exists) {
      // Create a new chat room
      await _firestore.collection('human_chats').doc(chatId).set({
        'isApproved': isApproved,
      });
    }
    else {
      // Create a new chat room
      await _firestore.collection('human_chats').doc(chatId).update({
        'isApproved': isApproved,
      });
    }
    return chatId;
  }

  Future<void> reviewConsultant({required String consultantId, required double rate}) async {
    final consultant = await _firestore.collection('users').doc(consultantId).get();

    double existingRate = consultant.data()?['rate'] ?? 0;
    int count = consultant.data()?['count'] ?? 0;

    // Scale the input rate to a score out of 5
    double normalizedRate = (rate - 0) / 5 * 5; // This simplifies to "rate" since it's already 0-5

    // Compute the new average rate
    double newRate = ((existingRate * count) + normalizedRate) / (count + 1);

    await _firestore.collection('users').doc(consultantId).update({
      'rate': double.tryParse(newRate.toStringAsFixed(2)),
      'count': count + 1,
    });

    if (kDebugMode) {
      print("Updated consultant data: Rate = $newRate, Count = ${count + 1}");
    }
  }

  // Method to send a message
  Future<void> sendMessage(String chatId, String senderId, String receiverId, String message) async {
    setIsLoadingTrue(); // Start loading
    try {
      await _firestore.collection('human_chats').doc(chatId).collection('messages').add({
        'senderId': senderId,
        'receiverId': receiverId,
        'message': message,
        'timestamp': Timestamp.now(),
      });
      emit(MessageSentSuccess()); // Emit success state
    } catch (e) {
      emit(MessageSentError(error: e.toString())); // Emit error state
    } finally {
      setIsLoadingFalse(); // Stop loading
    }
  }

  // Method to fetch messages in real-time
  Stream<QuerySnapshot> getMessages(String chatId) {
    return _firestore.collection('human_chats').doc(chatId).collection('messages').orderBy('timestamp', descending: false).snapshots();
  }

  // Fetch all chat rooms for the consultant
  Stream<List<Map<String, dynamic>>> getChatRoomsForConsultant(String consultantUid, bool isActive,isApproved) {
    return _firestore
        .collection('human_chats')
        .where('participants', arrayContains: consultantUid)
        .snapshots()
        .map((querySnapshot) {
      List<Map<String, dynamic>> activeChatRooms = [];
      List<Map<String, dynamic>> inactiveChatRooms = [];
      List<Map<String, dynamic>> notApprovedChatRooms = [];

      for (var doc in querySnapshot.docs) {
        final chatId = doc.id;
        final participants = doc['participants'] as List<dynamic>;
        final otherUserId = participants.firstWhere((uid) => uid != consultantUid) as String;
        final String otherUserName = doc['userName'];
        final bool isChatActive = doc['isActive'];
        final bool isChatApprove = doc['isApproved'];

        if (isChatActive) {
          if(!isChatApprove){
            notApprovedChatRooms.add({
              'chatId': chatId,
              'otherUserId': otherUserId,
              'lastMessage': null, // Will fetch below
              'otherUserName': otherUserName,
              'isActive': isChatActive,
              'isApproved': isChatApprove,
            });
          }
          else{
            activeChatRooms.add({
              'chatId': chatId,
              'otherUserId': otherUserId,
              'lastMessage': null, // Will fetch below
              'otherUserName': otherUserName,
              'isActive': isChatActive,
              'isApproved': isChatApprove,
            });
          }
        }
        else{
          inactiveChatRooms.add({
            'chatId': chatId,
            'otherUserId': otherUserId,
            'lastMessage': null, // Will fetch below
            'otherUserName': otherUserName,
            'isActive': isChatActive,
            'isApproved': isChatApprove,
          });
        }


      }

      return isActive ? (isApproved ? activeChatRooms : notApprovedChatRooms) : inactiveChatRooms;
    });
  }

  Stream<List<Map<String, dynamic>>> getChatRoomsForUser(String userId, bool isActive,isApproved) {
    return _firestore
        .collection('human_chats')
        .where('participants', arrayContains: userId)
        .snapshots()
        .map((querySnapshot) {
      List<Map<String, dynamic>> activeChatRooms = [];
      List<Map<String, dynamic>> inactiveChatRooms = [];
      List<Map<String, dynamic>> notApprovedChatRooms = [];

      for (var doc in querySnapshot.docs) {
        final chatId = doc.id;
        final participants = doc['participants'] as List<dynamic>;
        final otherUserId = participants.firstWhere((uid) => uid != userId) as String;
        final String otherUserName = doc['consultantName'];
        final bool isChatActive = doc['isActive'];
        final bool isChatApprove = doc['isApproved'];

        if (isChatActive) {
          if(!isChatApprove){
            notApprovedChatRooms.add({
              'chatId': chatId,
              'otherUserId': otherUserId,
              'lastMessage': null, // Will fetch below
              'otherUserName': otherUserName,
              'isActive': isChatActive,
              'isApproved': isChatApprove,
            });
          }
          else{
            activeChatRooms.add({
              'chatId': chatId,
              'otherUserId': otherUserId,
              'lastMessage': null, // Will fetch below
              'otherUserName': otherUserName,
              'isActive': isChatActive,
              'isApproved': isChatApprove,
            });
          }
        }
        else{
          inactiveChatRooms.add({
            'chatId': chatId,
            'otherUserId': otherUserId,
            'lastMessage': null, // Will fetch below
            'otherUserName': otherUserName,
            'isActive': isChatActive,
            'isApproved': isChatApprove,
          });
        }


      }

      return isActive ? (isApproved ? activeChatRooms : notApprovedChatRooms) : inactiveChatRooms;
    });
  }

  QuerySnapshot<Map<String, dynamic>>? activeRooms;
  QuerySnapshot<Map<String, dynamic>>? inActiveRooms;
  QuerySnapshot<Map<String, dynamic>>? notApprovedRooms;

  Future getRooms() async {
    activeRooms =  await _firestore.collection('human_chats').where('isActive', isEqualTo: true).get();
    inActiveRooms =  await _firestore.collection('human_chats').where('isActive', isEqualTo: false).get();
    notApprovedRooms =  await _firestore.collection('human_chats').where('isApproved', isEqualTo: false).get();
    emit(ChatInitial());
  }

  double? rating;

  setRating(double rate){
    rating = rate;
    emit(ChatInitial());
  }

}
