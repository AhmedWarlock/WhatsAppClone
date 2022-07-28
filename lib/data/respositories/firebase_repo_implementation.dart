import 'package:whatsapp_clone/data/data_source/firebase_datasource.dart';
import 'package:whatsapp_clone/domain/entities/text_message_entity.dart';
import 'package:whatsapp_clone/domain/entities/my_chat_entity.dart';
import 'package:whatsapp_clone/domain/entities/user_entity.dart';
import 'package:whatsapp_clone/domain/repositories/firebase_repository.dart';

class FirebaseRepoImplementation implements FireBaseRepository {
  final FireBaseRemoteDataSource remoteDataSource;

  FirebaseRepoImplementation({required this.remoteDataSource});

  @override
  Future<void> getCreateUser(UserEntity userEntity) async =>
      await remoteDataSource.getCreateUser(userEntity);
  @override
  Future<String> getCurrentUID() async =>
      await remoteDataSource.getCurrentUID();

  @override
  Future<bool> isLoggedIn() async => await remoteDataSource.isLoggedIn();
  @override
  Future<void> signInWithPhoneNum(String smsPinCode) async =>
      await remoteDataSource.signInWithPhoneNum(smsPinCode);

  @override
  Future<void> signOut() async => await remoteDataSource.signOut();

  @override
  Future<void> verifyPhoneNum(String phoneNum) async =>
      await remoteDataSource.verifyPhoneNum(phoneNum);

  @override
  Future<void> addToMyChat(MyChatEntity myChatEntity) async =>
      await remoteDataSource.addToMyChat(myChatEntity);

  @override
  Future<void> createOnetoOneChatChannel(String uid, otherUid) async =>
      await remoteDataSource.createOnetoOneChatChannel(uid, otherUid);

  @override
  Stream<List<UserEntity>> getAllUsers() => remoteDataSource.getAllUsers();

  @override
  Stream<List<TextMessageEntity>> getMessages(String channelID) =>
      remoteDataSource.getMessages(channelID);

  @override
  Stream<List<MyChatEntity>> getMyChat(String uid) =>
      remoteDataSource.getMyChat(uid);

  @override
  Future<String> getOnetoOneSingleUserChannelID(String uid, otherUid) async =>
      await remoteDataSource.getOnetoOneSingleUserChannelID(uid, otherUid);

  @override
  Future<void> sendTextMessage(
          TextMessageEntity textMessageEntity, String channelID) async =>
      await remoteDataSource.sendTextMessage(textMessageEntity, channelID);
}
