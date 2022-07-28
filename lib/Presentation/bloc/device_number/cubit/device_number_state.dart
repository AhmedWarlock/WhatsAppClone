part of 'device_number_cubit.dart';

abstract class DeviceNumberState extends Equatable {
  const DeviceNumberState();

  @override
  List<Object> get props => [];
}

class DeviceNumberInitial extends DeviceNumberState {
  @override
  List<Object> get props => [];
}

class DeviceNumberLoadingState extends DeviceNumberState {
  @override
  List<Object> get props => [];
}

class DeviceNumberLoadedState extends DeviceNumberState {
  final List<ContactEntity> contacts;
  DeviceNumberLoadedState({
    required this.contacts,
  });
  @override
  List<Object> get props => [contacts];
}

class DeviceNumberFailureState extends DeviceNumberState {
  @override
  List<Object> get props => [];
}
