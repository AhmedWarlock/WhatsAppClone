import 'package:equatable/equatable.dart';

class ContactEntity {
  final String? phoneNumber;
  final String status;
  final String? label;
  final String uId;
  ContactEntity({
    required this.phoneNumber,
    required this.status,
    required this.label,
    required this.uId,
  });
}
