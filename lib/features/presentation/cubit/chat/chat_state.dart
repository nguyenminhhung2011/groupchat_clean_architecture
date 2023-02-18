part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();
}

class ChatInitial extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatLoaded extends ChatState {
  final List<ChatEntity> users;

  ChatLoaded({required this.users});
  @override
  List<Object> get props => [users];
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
