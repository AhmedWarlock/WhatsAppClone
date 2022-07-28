part of 'phone_auth_cubit.dart';

abstract class PhoneAuthState extends Equatable {
  const PhoneAuthState();

  @override
  List<Object> get props => [];
}

class PhoneAuthInitial extends PhoneAuthState {}

class PhoneAuthLoading extends PhoneAuthState {
  @override
  List<Object> get props => [];
}

class PhoneAuthSuccess extends PhoneAuthState {
  @override
  List<Object> get props => [];
}

class PhoneAuthFailure extends PhoneAuthState {
  @override
  List<Object> get props => [];
}

class PhoneAuthSMSCodeReceived extends PhoneAuthState {
  @override
  List<Object> get props => [];
}

class PhoneAuthProfileInfo extends PhoneAuthState {
  @override
  List<Object> get props => [];
}
