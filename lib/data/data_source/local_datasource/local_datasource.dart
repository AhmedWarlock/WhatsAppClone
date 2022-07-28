import 'package:whatsapp_clone/domain/entities/contact_entity.dart';
import 'package:contacts_service/contacts_service.dart';

abstract class GetDeviceNumbersLocalDataSource {
  Future<List<ContactEntity>> getDeviceNumbers();
}

class GetDeviceNumbersLocalDSImlementation
    implements GetDeviceNumbersLocalDataSource {
  @override
  Future<List<ContactEntity>> getDeviceNumbers() async {
    List<ContactEntity> contacts = [];
    final myContacts = await ContactsService.getContacts();
    myContacts.forEach((myContact) {
      myContact.phones!.forEach((element) {
        contacts.add(ContactEntity(
            phoneNumber: element.value,
            status: 'status',
            label: myContact.displayName,
            uId: 'uId'));
      });
    });
    return contacts;
  }
}
