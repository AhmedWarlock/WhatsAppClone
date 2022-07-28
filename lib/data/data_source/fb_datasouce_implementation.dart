import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:whatsapp_clone/data/data_source/firebase_datasource.dart';
import 'package:whatsapp_clone/data/model/my_chat_model.dart';
import 'package:whatsapp_clone/data/model/text_message_model.dart';
import 'package:whatsapp_clone/data/model/user_moder.dart';
import 'package:whatsapp_clone/domain/entities/text_message_entity.dart';
import 'package:whatsapp_clone/domain/entities/my_chat_entity.dart';
import 'package:whatsapp_clone/domain/entities/user_entity.dart';

class FirebaseDataSourceImplementation implements FireBaseRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  String _verificationID = '';
  FirebaseDataSourceImplementation({
    required this.auth,
    required this.firestore,
  });

  @override
  Future<void> getCreateUser(UserEntity userEntity) async {
    try {
      final userRefrence = firestore.collection('users');
      final uid = await getCurrentUID();
      await userRefrence.doc(uid).get().then((userDoc) {
        final newUserMap = UserModel(
                name: userEntity.name,
                email: userEntity.email,
                phoneNumber: userEntity.phoneNumber,
                isOnline: userEntity.isOnline,
                uid: uid,
                status: userEntity.status,
                profileURL: userEntity.profileURL)
            .toDocument();
        if (!userDoc.exists) {
          print('=====================================');
          print('Created new User');
          print('====================================');

          userRefrence.doc(uid).set(newUserMap);
        } else {
          print('=========================================');
          print('Created new User');

          print('========================================');

          userRefrence.doc(uid).update(newUserMap);
        }
      });
    } catch (_) {
      print('firestore Access NOT SUCCESSFULL');
    }
  }

  @override
  Future<String> getCurrentUID() async => auth.currentUser!.uid;
  @override
  Future<bool> isLoggedIn() async => auth.currentUser!.uid != null;

  @override
  Future<void> signInWithPhoneNum(String smsPinCode) async {
    try {
      final AuthCredential authCredential = PhoneAuthProvider.credential(
          verificationId: _verificationID, smsCode: smsPinCode);
      await auth.signInWithCredential(authCredential);

      print('GREAT SUCCESS');
    } catch (_) {
      print('Try Failed in SignInmethod Inside Implementation');
    }
  }

  @override
  Future<void> signOut() async => await auth.signOut();

  @override
  Future<void> verifyPhoneNum(String phoneNum) async {
    final PhoneVerificationCompleted phoneVerificationCompleted =
        (PhoneAuthCredential credential) async {
      print('Phone verified : token ${credential.token}');
      // await auth.signInWithCredential(credential);
    };

    final PhoneVerificationFailed phoneVerificationFailed =
        (FirebaseAuthException exception) {
      print('==========================================');

      print('Verification FAILED :' +
          exception.message.toString() +
          exception.code.toString());
      print('==========================================');
    };

    final PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout =
        (String verificationID) {
      _verificationID = verificationID;
      print('==========================================');

      print('Time out: ' + verificationID);
      print('==========================================');
    };

    final PhoneCodeSent phoneCodeSent =
        (String verificationID, int? forceResendToken) async {
      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: '123456');

      // Sign the user in (or link) with the credential
      await auth.signInWithCredential(credential);
    };

    await auth.verifyPhoneNumber(
        phoneNumber: phoneNum,
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout,
        timeout: const Duration(minutes: 2));
  }

// New Implements
//========================================================================================================
//========================================================================================================
//========================================================================================================

  @override
  Future<void> addToMyChat(MyChatEntity myChatEntity) async {
    final myChatRef = firestore
        .collection('users')
        .doc(myChatEntity.senderUID)
        .collection('myChat');
    final otherChatRef = firestore
        .collection('users')
        .doc(myChatEntity.recipientUID)
        .collection('myChat');

    final newChat = MyChatModel(
            senderName: myChatEntity.senderName,
            senderUID: myChatEntity.senderUID,
            recipientName: myChatEntity.recipientName,
            recipientUID: myChatEntity.recipientUID,
            recipientPhoneNumber: myChatEntity.recipientPhoneNumber,
            profileURL: myChatEntity.profileURL,
            channelID: myChatEntity.channelID,
            senderPhoneNumber: myChatEntity.senderPhoneNumber,
            time: myChatEntity.time,
            recentTextMessage: myChatEntity.recentTextMessage)
        .toDocument();

    final otherChat = MyChatModel(
            senderName: myChatEntity.recipientName,
            senderUID: myChatEntity.recipientUID,
            recipientName: myChatEntity.senderName,
            recipientUID: myChatEntity.senderUID,
            recipientPhoneNumber: myChatEntity.senderPhoneNumber,
            profileURL: myChatEntity.profileURL,
            channelID: myChatEntity.channelID,
            senderPhoneNumber: myChatEntity.recipientPhoneNumber,
            time: myChatEntity.time,
            recentTextMessage: myChatEntity.recentTextMessage)
        .toDocument();

    await myChatRef.doc(myChatEntity.recipientUID).get().then((myChatDoc) {
      if (myChatDoc.exists) {
        myChatRef.doc(myChatEntity.recipientUID).update(newChat);
        otherChatRef.doc(myChatEntity.senderUID).update(otherChat);
      } else {
        myChatRef.doc(myChatEntity.recipientUID).set(newChat);
        otherChatRef.doc(myChatEntity.senderUID).set(otherChat);
      }
      return;
    });
  }

  @override
  Future<String> getOnetoOneSingleUserChannelID(
      String uid, String otherUid) async {
    String returnValue = '';
    final CollectionReference userRef = firestore.collection('users');
    await userRef
        .doc(uid)
        .collection('engagedChatChannel')
        .doc(otherUid)
        .get()
        .then((engagedChatChannelDocument) {
      if (engagedChatChannelDocument.exists) {
        returnValue = (engagedChatChannelDocument.data() as Map)['channelID'];
      }
    });

    return returnValue;
  }

  @override
  Future<void> createOnetoOneChatChannel(String uid, String otherUid) async {
    final CollectionReference userRef = firestore.collection('users');
    final CollectionReference one2oneChatChannelRef =
        firestore.collection('myChatChannel');
    await userRef
        .doc(uid)
        .collection('engagedChatChannel')
        .doc(otherUid)
        .get()
        .then((engagedChatChannelDocument) {
      if (engagedChatChannelDocument.exists) {
        return;
      } else {
        final _chatChannelID = one2oneChatChannelRef.doc().id;
        var _chatChannelMap = {
          'channelID': _chatChannelID,
          'channelType': 'ONE 2 ONE CHAT'
        };
        // Updating Collections
        one2oneChatChannelRef.doc(_chatChannelID).set(_chatChannelMap);
        userRef
            .doc(uid)
            .collection('engagedChatChannel')
            .doc(otherUid)
            .set(_chatChannelMap);
        userRef
            .doc(otherUid)
            .collection('engagedChatChannel')
            .doc(uid)
            .set(_chatChannelMap);
        return;
      }
    });
  }

  @override
  Stream<List<UserEntity>> getAllUsers() {
    final CollectionReference userRef = firestore.collection('users');
    return userRef.snapshots().map((QuerySnapshot snapshot) {
      return snapshot.docs.map((QueryDocumentSnapshot documentSnapshot) {
        return UserModel.fromSnapshot(documentSnapshot);
      }).toList();
    });
  }

  @override
  Stream<List<TextMessageEntity>> getMessages(String channelID) {
    final ref = firestore
        .collection('myChatChannel')
        .doc(channelID)
        .collection('messages');

    return ref.orderBy('time').snapshots().map((querySnapshot) => querySnapshot
        .docs
        .map((doc) => TextMessageModel.fromSnapshot(doc))
        .toList());
  }

  @override
  Stream<List<MyChatEntity>> getMyChat(String uid) {
    final ref = firestore.collection('users').doc(uid).collection('myChat');

    return ref.orderBy('time', descending: true).snapshots().map((querySnap) =>
        querySnap.docs
            .map((docSnap) => MyChatModel.fromSnapShot(docSnap))
            .toList());
  }

  @override
  Future<void> sendTextMessage(
      TextMessageEntity textMessageEntity, String channelID) async {
    final channelref = firestore
        .collection('myChatChannel')
        .doc(channelID)
        .collection('messages');
    final messageId = channelref.doc().id;
    final newMessage = TextMessageModel(
            senderName: textMessageEntity.senderName,
            senderUID: textMessageEntity.senderUID,
            recipientName: textMessageEntity.recipientName,
            recipientUID: textMessageEntity.recipientUID,
            message: textMessageEntity.message,
            messageType: textMessageEntity.messageType,
            messageID: messageId,
            time: textMessageEntity.time)
        .toDocument();
    await channelref.doc(messageId).set(newMessage);
  }
}
