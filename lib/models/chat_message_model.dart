import 'dart:convert';

class AIChatMessage {
  final String text;
  final bool isUser; // true = User, false = AI
  final DateTime timestamp;

  AIChatMessage({required this.text, required this.isUser, required this.timestamp});

  // Convert to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "isUser": isUser,
      "timestamp": timestamp.toIso8601String(),
    };
  }

  // Convert from JSON
  factory AIChatMessage.fromJson(Map<String, dynamic> json) {
    return AIChatMessage(
      text: utf8.decode(latin1.encode(json["text"])),
      isUser: json["isUser"],
      timestamp: DateTime.parse(json["timestamp"]),
    );
  }
}