// ignore_for_file: must_be_immutable

part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class SendMassageEvent extends ChatEvent {
  final ChatMessage chatMessage;

  SendMassageEvent({required this.chatMessage});
}
//add RemoveChatEvent
final class RemoveChatEvent extends ChatEvent {
  final ChatMessage messageToRemove;
   List<ChatMessage> oldMessageList;

  RemoveChatEvent({required this.messageToRemove, required this.oldMessageList});
}
