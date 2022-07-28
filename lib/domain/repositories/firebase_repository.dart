import 'package:whatsapp_clone/domain/entities/my_chat_entity.dart';
import 'package:whatsapp_clone/domain/entities/text_message_entity.dart';
import 'package:whatsapp_clone/domain/entities/user_entity.dart';

abstract class FireBaseRepository {
  Future<void> verifyPhoneNum(String phoneNum);
  Future<void> signInWithPhoneNum(String smsPinCode);
  Future<void> signOut();
  Future<void> getCreateUser(UserEntity userEntity);
  Future<bool> isLoggedIn();
  Future<String> getCurrentUID();

  Stream<List<UserEntity>> getAllUsers();
  Stream<List<TextMessageEntity>> getMessages(String channelID);
  Stream<List<MyChatEntity>> getMyChat(String uid);

  Future<void> createOnetoOneChatChannel(String uid, otherUid);
  Future<String> getOnetoOneSingleUserChannelID(String uid, otherUid);
  Future<void> addToMyChat(MyChatEntity myChatEntity);
  Future<void> sendTextMessage(
      TextMessageEntity textMessageEntity, String channelID);
}
