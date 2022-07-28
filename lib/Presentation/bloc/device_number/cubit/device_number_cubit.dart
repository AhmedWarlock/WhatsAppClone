import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:whatsapp_clone/domain/entities/contact_entity.dart';
import 'package:whatsapp_clone/domain/usecases/user_cases.dart';

part 'device_number_state.dart';

class DeviceNumberCubit extends Cubit<DeviceNumberState> {
  final GetDeviceNumbersUseCase getDeviceNumbersUseCase;
  DeviceNumberCubit(
    this.getDeviceNumbersUseCase,
  ) : super(DeviceNumberInitial());

  Future<void> getDeviceNumbers() async {
    try {
      final List<ContactEntity> contacts = await getDeviceNumbersUseCase.call();
      emit(DeviceNumberLoadedState(contacts: contacts));
    } catch (_) {
      print('Fetching Device Numbers Failed Inside Cubit');
      emit(DeviceNumberFailureState());
    }
  }
}
