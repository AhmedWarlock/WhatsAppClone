import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:whatsapp_clone/domain/entities/my_chat_entity.dart';
import 'package:whatsapp_clone/domain/usecases/user_cases.dart';

part 'mychat_state.dart';

class MychatCubit extends Cubit<MychatState> {
  final GetMyChatUseCase getMyChatUseCase;
  MychatCubit({
    required this.getMyChatUseCase,
  }) : super(MychatInitial());

  Future<void> getMyChats({required String uid}) async {
    emit(MychatLoadingState());
    try {
      final myChatsStream = getMyChatUseCase.call(uid);
      myChatsStream.listen((MychatsList) {
        emit(MychatLoadedState(myChats: MychatsList));
      });
    } on SocketException catch (_) {
      print('Get my chats failed inside cubit');
      emit(MychatFailedState());
    } catch (_) {
      print('Get my chats failed inside cubit');
      emit(MychatFailedState());
    }
  }
}
