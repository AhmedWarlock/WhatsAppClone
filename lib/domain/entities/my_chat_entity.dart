import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MyChatEntity extends Equatable {
  final String senderName;
  final String senderUID;
  final String recipientName;
  final String recipientUID;
  final String recipientPhoneNumber;
  final String profileURL;
  final String channelID;
  final bool isArchieved;
  final bool isRead;
  final String senderPhoneNumber;
  final Timestamp time;
  final String recentTextMessage;
  MyChatEntity(
      {required this.senderName,
      required this.senderUID,
      required this.recipientName,
      required this.recipientUID,
      required this.recipientPhoneNumber,
      required this.profileURL,
      required this.channelID,
      required this.senderPhoneNumber,
      required this.time,
      required this.recentTextMessage,
      this.isArchieved = false,
      this.isRead = false});

  @override
  List<Object?> get props => [
        senderName,
        senderPhoneNumber,
        senderUID,
        recipientName,
        recipientPhoneNumber,
        recipientUID,
        channelID,
        isArchieved,
        isRead,
        profileURL,
        time,
        recentTextMessage
      ];
}
