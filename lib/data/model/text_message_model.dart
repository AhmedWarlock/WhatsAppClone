import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone/domain/entities/text_message_entity.dart';

class TextMessageModel extends TextMessageEntity {
  TextMessageModel(
      {required String senderName,
      required String senderUID,
      required String recipientName,
      required String recipientUID,
      required String message,
      required String messageType,
      required String messageID,
      required Timestamp time})
      : super(
            senderName: senderName,
            senderUID: senderUID,
            recipientName: recipientName,
            recipientUID: recipientUID,
            message: message,
            messageType: messageType,
            messageID: messageID,
            time: time);

  factory TextMessageModel.fromSnapshot(DocumentSnapshot snapshot) {
    return TextMessageModel(
        senderName: (snapshot.data() as Map)['senderName'],
        senderUID: (snapshot.data() as Map)['senderUID'],
        recipientName: (snapshot.data() as Map)['recipientName'],
        recipientUID: (snapshot.data() as Map)['recipientUID'],
        message: (snapshot.data() as Map)['message'],
        messageType: (snapshot.data() as Map)['messageType'],
        messageID: (snapshot.data() as Map)['messageID'],
        time: (snapshot.data() as Map)['time']);
  }

  Map<String, dynamic> toDocument() {
    return {
      'senderName': senderName,
      'senderUID': senderUID,
      'recipientName': recipientName,
      'recipientUID': recipientUID,
      'message': message,
      'messageType': messageType,
      'messageID': messageID,
      'time': time
    };
  }
}
