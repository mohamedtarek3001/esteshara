part of 'chat_cubit.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {}

class MessageSentSuccess extends ChatState {}

class MessageSentError extends ChatState {
  final String error;
  MessageSentError({required this.error});
}