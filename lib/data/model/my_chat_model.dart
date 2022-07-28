import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone/domain/entities/my_chat_entity.dart';

class MyChatModel extends MyChatEntity {
  MyChatModel(
      {required String senderName,
      required String senderUID,
      required String recipientName,
      required String recipientUID,
      required String recipientPhoneNumber,
      required String profileURL,
      required String channelID,
      required String senderPhoneNumber,
      required Timestamp time,
      required String recentTextMessage,
      bool isArchieved = false,
      bool isRead = false})
      : super(
            senderName: senderName,
            senderPhoneNumber: senderPhoneNumber,
            senderUID: senderUID,
            recentTextMessage: recentTextMessage,
            time: time,
            channelID: channelID,
            profileURL: profileURL,
            recipientName: recipientName,
            isArchieved: isArchieved,
            isRead: isRead,
            recipientPhoneNumber: recipientPhoneNumber,
            recipientUID: recipientUID);

  factory MyChatModel.fromSnapShot(DocumentSnapshot snapshot) {
    return MyChatModel(
        senderName: (snapshot.data() as Map)['senderName'],
        senderUID: (snapshot.data() as Map)['senderUID'],
        recipientName: (snapshot.data() as Map)['recipientName'],
        recipientUID: (snapshot.data() as Map)['recipientUID'],
        recipientPhoneNumber: (snapshot.data() as Map)['recipientPhoneNumber'],
        profileURL: (snapshot.data() as Map)['profileURL'],
        channelID: (snapshot.data() as Map)['channelID'],
        senderPhoneNumber: (snapshot.data() as Map)['senderPhoneNumber'],
        time: (snapshot.data() as Map)['time'],
        isArchieved: (snapshot.data() as Map)['isArchieved'],
        isRead: (snapshot.data() as Map)['isRead'],
        recentTextMessage: (snapshot.data() as Map)['recentTextMessage']);
  }

  Map<String, dynamic> toDocument() {
    return {
      'senderName': senderName,
      'senderUID': senderUID,
      'recipientName': recipientName,
      'recipientUID': recipientUID,
      'recipientPhoneNumber': recipientPhoneNumber,
      'profileURL': profileURL,
      'channelID': channelID,
      'senderPhoneNumber': senderPhoneNumber,
      'time': time,
      'recentTextMessage': recentTextMessage,
      'isArchieved': isArchieved,
      'isRead': isRead,
    };
  }
}
