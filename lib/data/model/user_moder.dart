import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required String name,
    required String email,
    required String phoneNumber,
    required bool isOnline,
    required String uid,
    required String status,
    required String profileURL,
  }) : super(
          name: name,
          email: email,
          phoneNumber: phoneNumber,
          isOnline: isOnline,
          uid: uid,
          status: status,
          profileURL: profileURL,
        );

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
        name: (snapshot.data() as Map)['name'],
        email: (snapshot.data() as Map)['email'],
        phoneNumber: (snapshot.data() as Map)['phoneNumber'],
        isOnline: (snapshot.data() as Map)['isOnline'],
        uid: (snapshot.data() as Map)['uid'],
        status: (snapshot.data() as Map)['status'],
        profileURL: (snapshot.data() as Map)['profileURL']);
  }
}

Map<String, dynamic> toDocument() {
  return toDocument();
}
