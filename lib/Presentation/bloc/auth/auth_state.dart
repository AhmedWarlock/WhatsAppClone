part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthenticatedState extends AuthState {
  final String uID;

  AuthenticatedState({required this.uID});

  @override
  List<Object> get props => [uID];
}

class UnAuthenticatedState extends AuthState {}
