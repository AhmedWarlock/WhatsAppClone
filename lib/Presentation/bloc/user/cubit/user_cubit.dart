import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_clone/domain/entities/user_entity.dart';

import 'package:whatsapp_clone/domain/usecases/user_cases.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetAllUsersUseCase getAllUsersUseCase;
  final CreateOnetoOneChatChannelUseCase createOnetoOneChatChannelUseCase;
  UserCubit(
    this.getAllUsersUseCase,
    this.createOnetoOneChatChannelUseCase,
  ) : super(UserInitial());

  Future<void> getAllUsers() async {
    try {
      final Stream<List<UserEntity>> allUsersStream =
          await getAllUsersUseCase.call();
      allUsersStream.listen((usersList) {
        emit(UserLoadedState(usersList: usersList));
      });
    } on SocketException catch (_) {
      print('GET ALL USERS FAILED INSIDE CUBIT');
      emit(UserFailedLoadingState());
    } catch (_) {
      emit(UserFailedLoadingState());
    }
  }

  Future<void> create121ChatChannel(String uid, String otherUid) async {
    try {
      await createOnetoOneChatChannelUseCase.call(uid, otherUid);
    } on SocketException catch (_) {
      print('CREATE 121 CHANNEL FAILED INSIDE CUBIT');
      emit(UserFailedLoadingState());
    } catch (_) {
      emit(UserFailedLoadingState());
    }
  }
}
