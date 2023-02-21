part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();
}

class ChatInitial extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatLoaded extends ChatState {
  final List<TextMessageEntity> chats;

  ChatLoaded({required this.chats});
  @override
  List<Object> get props => [chats];
}

class ChatSuccess extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatFailure extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatLoading extends ChatState {
  @override
  List<Object> get props => [];
}
