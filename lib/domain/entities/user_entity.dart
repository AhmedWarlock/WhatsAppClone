import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String name;
  final String email;
  final String phoneNumber;
  final String uid;
  final String status;
  final String profileURL;
  final bool isOnline;
  UserEntity({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.uid,
    this.status = 'Hi There I am Using this App',
    required this.profileURL,
    required this.isOnline,
  });

  Map<String, dynamic> toDocument() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'isOnline': isOnline,
      'uid': uid,
      'status': status,
      'profileURL': profileURL
    };
  }

  @override
  List<Object?> get props =>
      [name, email, phoneNumber, profileURL, isOnline, uid, status];
}
