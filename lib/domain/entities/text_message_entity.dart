import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TextMessageEntity extends Equatable {
  final String senderName;
  final String senderUID;
  final String recipientName;
  final String recipientUID;
  final String message;
  final String messageType;
  final String messageID;
  final Timestamp time;

  TextMessageEntity(
      {required this.senderName,
      required this.senderUID,
      required this.recipientName,
      required this.recipientUID,
      required this.message,
      required this.messageType,
      required this.messageID,
      required this.time});

  @override
  List<Object?> get props => [
        senderName,
        senderUID,
        message,
        messageID,
        messageType,
        time,
        recipientName,
        recipientUID
      ];
}
