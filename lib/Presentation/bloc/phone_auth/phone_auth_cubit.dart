import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_clone/domain/entities/user_entity.dart';

import 'package:whatsapp_clone/domain/usecases/user_cases.dart';

part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  final GetCreatedUserUserCase getCreatedUserUserCase;
  final VerifyPhoneNumberUserCase verifyPhoneNumberUserCase;
  final SignInWithoneNumberUserCase signInWithoneNumberUserCase;
  PhoneAuthCubit({
    required this.getCreatedUserUserCase,
    required this.verifyPhoneNumberUserCase,
    required this.signInWithoneNumberUserCase,
  }) : super(PhoneAuthInitial());

  Future<void> submitPhoneNumber(String phoneNumber) async {
    emit(PhoneAuthLoading());
    try {
      await verifyPhoneNumberUserCase.call(phoneNumber);

      emit(PhoneAuthSMSCodeReceived());
    } on SocketException catch (_) {
      emit(PhoneAuthFailure());
    } catch (_) {
      emit(PhoneAuthFailure());
    }
  }

  Future<void> submitSMSCode(String pinCode) async {
    try {
      await signInWithoneNumberUserCase.call(pinCode);
      emit(PhoneAuthProfileInfo());
      print('SignInWithPN Completed');
    } on SocketException catch (_) {
      print('submitCode failed on cubit');

      emit(PhoneAuthFailure());
    } catch (_) {
      print('submitCode failed on cubit');

      emit(PhoneAuthFailure());
    }
  }

  Future<void> submitProfileInfo(
      String name, String profileURL, String phoneNumber) async {
    try {
      await getCreatedUserUserCase.call(UserEntity(
          name: name,
          email: '',
          phoneNumber: phoneNumber,
          uid: '',
          profileURL: profileURL,
          isOnline: true));
      emit(PhoneAuthSuccess());
    } on SocketException catch (_) {
      print('DIDNT Creat User In Cubit');

      emit(PhoneAuthFailure());
    } catch (_) {
      print('DIDNT Creat User In Cubit');

      emit(PhoneAuthFailure());
    }
  }
}
