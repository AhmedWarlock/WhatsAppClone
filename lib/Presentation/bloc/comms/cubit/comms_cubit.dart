import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_clone/const.dart';
import 'package:whatsapp_clone/domain/entities/my_chat_entity.dart';

import 'package:whatsapp_clone/domain/entities/text_message_entity.dart';
import 'package:whatsapp_clone/domain/usecases/user_cases.dart';

part 'comms_state.dart';

class CommsCubit extends Cubit<CommsState> {
  final SendTextMessageUseCase sendTextMessageUseCase;
  final GetOnetoOneSingleUserChannelIDUseCase
      getOnetoOneSingleUserChannelIDUseCase;
  final GetMessagesUseCase getMessagesUseCase;
  final AddToMyChatUseCase addToMyChatUseCase;
  CommsCubit(
      {required this.sendTextMessageUseCase,
      required this.getMessagesUseCase,
      required this.addToMyChatUseCase,
      required this.getOnetoOneSingleUserChannelIDUseCase})
      : super(CommsInitial());

  Future<void> sendTextMessage(
      {required String message,
      required String senderName,
      required String senderId,
      required String senderPhoneNumber,
      required String recipientName,
      required String recipientId,
      required String recipientPhoneNumber}) async {
    try {
      final channelID = await getOnetoOneSingleUserChannelIDUseCase.call(
          senderId, recipientId);
      await sendTextMessageUseCase.call(
          TextMessageEntity(
              senderName: senderName,
              senderUID: senderId,
              recipientName: recipientName,
              recipientUID: recipientId,
              message: message,
              messageType: AppConst.text,
              messageID: '',
              time: Timestamp.now()),
          channelID);
      await addToMyChatUseCase.call(MyChatEntity(
          senderName: senderName,
          senderUID: senderId,
          recipientName: recipientName,
          recipientUID: recipientId,
          recipientPhoneNumber: recipientPhoneNumber,
          profileURL: '',
          channelID: channelID,
          senderPhoneNumber: senderPhoneNumber,
          time: Timestamp.now(),
          isRead: true,
          isArchieved: false,
          recentTextMessage: message));
    } on SocketException catch (_) {
      print('CommsFailedInsideCubit');
      emit(CommsFailedState());
    } catch (_) {
      print('CommsFailedInsideCubit');
      emit(CommsFailedState());
    }
  }

  Future<void> getMessages(
      {required String senderID, required String recipientID}) async {
    emit(CommsLoadingState());
    try {
      final channelID = await getOnetoOneSingleUserChannelIDUseCase.call(
          senderID, recipientID);
      final messagesStream = getMessagesUseCase.call(channelID);
      messagesStream.listen((messgesList) {
        emit(CommsEstablishedState(messages: messgesList));
      });
    } on SocketException catch (_) {
      print('Failed Loading Messages');
      emit(CommsFailedState());
    } catch (_) {
      print('Failed Loading Messages');
      emit(CommsFailedState());
    }
  }
}
