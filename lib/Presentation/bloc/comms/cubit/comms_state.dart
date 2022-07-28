part of 'comms_cubit.dart';

abstract class CommsState extends Equatable {
  const CommsState();

  @override
  List<Object> get props => [];
}

class CommsInitial extends CommsState {}

class CommsEstablishedState extends CommsState {
  final List<TextMessageEntity> messages;
  CommsEstablishedState({
    required this.messages,
  });
  @override
  List<Object> get props => [messages];
}

class CommsFailedState extends CommsState {
  @override
  List<Object> get props => [];
}

class CommsLoadingState extends CommsState {
  @override
  List<Object> get props => [];
}
