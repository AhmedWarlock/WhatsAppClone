part of 'mychat_cubit.dart';

abstract class MychatState extends Equatable {
  const MychatState();

  @override
  List<Object> get props => [];
}

class MychatInitial extends MychatState {}

class MychatLoadedState extends MychatState {
  final List<MyChatEntity> myChats;
  MychatLoadedState({
    required this.myChats,
  });
  @override
  List<Object> get props => [];
}

class MychatLoadingState extends MychatState {
  @override
  List<Object> get props => [];
}

class MychatFailedState extends MychatState {
  @override
  List<Object> get props => [];
}
