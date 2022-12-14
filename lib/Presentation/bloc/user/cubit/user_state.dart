part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoadingState extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoadedState extends UserState {
  List<UserEntity> usersList;
  UserLoadedState({
    required this.usersList,
  });
  @override
  List<Object> get props => [];
}

class UserFailedLoadingState extends UserState {
  @override
  List<Object> get props => [];
}
