import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../core/constants/constants.dart';
import '../models/ai_response_model.dart';
import '../models/chat_message_model.dart';

part 'ai_state.dart';

class AiCubit extends Cubit<AiState> {
  AiCubit() : super(AiInitial());

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController questionController = TextEditingController();

  List<AIChatMessage> chatMessages = [];
  AiResponseModel? aiResponse;

  bool isLoading = false;

  void setIsLoadingTrue() {
    isLoading = true;
    emit(AiLoading());
  }

  void setIsLoadingFalse() {
    isLoading = false;
    emit(AiInitial());
  }


  Stream<List<AIChatMessage>> getChatStream() {
    String userId = _firebaseAuth.currentUser?.uid ?? "guest";
    return _firestore
        .collection("chats")
        .doc(userId)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => AIChatMessage.fromJson(doc.data()))
        .toList());
  }

  /// **1️⃣ Send Message & Store Response**
  Future<void> sendMessage(String question) async {
    if (question.trim().isEmpty) return;

    setIsLoadingTrue();

    // Store User Message
    AIChatMessage userMessage = AIChatMessage(
      text: question,
      isUser: true,
      timestamp: DateTime.now(),
    );
    await _saveMessageToFirestore(userMessage);

    String apiUrl = "https://www.futuretech.website/api/chat/";
    String token = "492ba0ee031c45d6185218f8f8bed5f3db954eb4";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Token $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({"question": question}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        aiResponse = AiResponseModel.fromJson(responseData);

        // Store AI Response
        AIChatMessage aiMessage = AIChatMessage(
          text: aiResponse?.answer ?? "No response",
          isUser: false,
          timestamp: DateTime.now(),
        );
        await _saveMessageToFirestore(aiMessage);

        emit(AiSuccess(responseData.toString()));
      } else {
        emit(AiFailure("Error ${response.statusCode}: ${response.body}"));
      }
    } catch (e) {
      emit(AiFailure("Exception: $e"));
    }
    setIsLoadingFalse();
  }

  /// **2️⃣ Save Messages to Firestore**
  Future<void> _saveMessageToFirestore(AIChatMessage message) async {
    String userId = _firebaseAuth.currentUser?.uid ?? "guest";
    await _firestore.collection("chats").doc(userId).collection("messages").add(message.toJson());
  }

  /// **3️⃣ Clear Chat History**
  Future<void> clearChatHistory() async {
    emit(AiLoading());
    String userId = _firebaseAuth.currentUser?.uid ?? "guest";

    try {
      var messages = await _firestore.collection("chats").doc(userId).collection("messages").get();
      for (var doc in messages.docs) {
        await doc.reference.delete();
      }
      emit(AiSuccess("Chat history cleared"));
    } catch (e) {
      emit(AiFailure("Failed to clear chat history: $e"));
    }
  }
}