import 'package:whatsapp_clone/domain/entities/contact_entity.dart';
import 'package:whatsapp_clone/domain/entities/my_chat_entity.dart';
import 'package:whatsapp_clone/domain/entities/text_message_entity.dart';
import 'package:whatsapp_clone/domain/entities/user_entity.dart';
import 'package:whatsapp_clone/domain/repositories/firebase_repository.dart';
import 'package:whatsapp_clone/domain/repositories/get_device_number_repository.dart';

class VerifyPhoneNumberUserCase {
  final FireBaseRepository repository;
  VerifyPhoneNumberUserCase({
    required this.repository,
  });

  Future<void> call(String phoneNum) async {
    return await repository.verifyPhoneNum(phoneNum);
  }
}

class SignInWithoneNumberUserCase {
  final FireBaseRepository repository;
  SignInWithoneNumberUserCase({
    required this.repository,
  });

  Future<void> call(String smsPinCode) async {
    return await repository.signInWithPhoneNum(smsPinCode);
  }
}

class SignOutUserCase {
  final FireBaseRepository repository;

  SignOutUserCase({required this.repository});

  Future<void> call() async {
    return await repository.signOut();
  }
}

class GetCreatedUserUserCase {
  final FireBaseRepository repository;
  GetCreatedUserUserCase({
    required this.repository,
  });

  Future<void> call(UserEntity userEntity) async {
    return await repository.getCreateUser(userEntity);
  }
}

class IsLoggedInUserCase {
  final FireBaseRepository repository;
  IsLoggedInUserCase({
    required this.repository,
  });

  Future<bool> call() async {
    return await repository.isLoggedIn();
  }
}

class GetCurrentUIDUserCase {
  final FireBaseRepository repository;
  GetCurrentUIDUserCase({
    required this.repository,
  });

  Future<String> call() async {
    return await repository.getCurrentUID();
  }
}
////////////////////////////////////////////////////////////////////////

class GetAllUsersUseCase {
  final FireBaseRepository repository;
  GetAllUsersUseCase({
    required this.repository,
  });

  Stream<List<UserEntity>> call() {
    return repository.getAllUsers();
  }
}

class GetMessagesUseCase {
  final FireBaseRepository repository;
  GetMessagesUseCase({
    required this.repository,
  });

  Stream<List<TextMessageEntity>> call(String channelID) {
    return repository.getMessages(channelID);
  }
}

class GetMyChatUseCase {
  final FireBaseRepository repository;
  GetMyChatUseCase({
    required this.repository,
  });

  Stream<List<MyChatEntity>> call(String uid) {
    return repository.getMyChat(uid);
  }
}

class CreateOnetoOneChatChannelUseCase {
  final FireBaseRepository repository;
  CreateOnetoOneChatChannelUseCase({
    required this.repository,
  });

  Future<void> call(String uid, String otherUid) async {
    return await repository.createOnetoOneChatChannel(uid, otherUid);
  }
}

class GetOnetoOneSingleUserChannelIDUseCase {
  final FireBaseRepository repository;
  GetOnetoOneSingleUserChannelIDUseCase({
    required this.repository,
  });

  Future<String> call(String uid, String otherUid) async {
    return await repository.getOnetoOneSingleUserChannelID(uid, otherUid);
  }
}

class AddToMyChatUseCase {
  final FireBaseRepository repository;
  AddToMyChatUseCase({
    required this.repository,
  });

  Future<void> call(MyChatEntity myChatEntity) async {
    return await repository.addToMyChat(myChatEntity);
  }
}

class SendTextMessageUseCase {
  final FireBaseRepository repository;
  SendTextMessageUseCase({
    required this.repository,
  });

  Future<void> call(
      TextMessageEntity textMessageEntity, String channelID) async {
    return await repository.sendTextMessage(textMessageEntity, channelID);
  }
}

class GetDeviceNumbersUseCase {
  final GetDeviceNumberRepository repository;
  GetDeviceNumbersUseCase({
    required this.repository,
  });

  Future<List<ContactEntity>> call() async {
    return await repository.getDeviceNumbers();
  }
}
