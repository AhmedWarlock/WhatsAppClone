import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:whatsapp_clone/Presentation/bloc/auth/auth_cubit.dart';
import 'package:whatsapp_clone/Presentation/bloc/camera/cubit/camera_cubit.dart';
import 'package:whatsapp_clone/Presentation/bloc/comms/cubit/comms_cubit.dart';
import 'package:whatsapp_clone/Presentation/bloc/device_number/cubit/device_number_cubit.dart';
import 'package:whatsapp_clone/Presentation/bloc/mychat/cubit/mychat_cubit.dart';
import 'package:whatsapp_clone/Presentation/bloc/phone_auth/phone_auth_cubit.dart';
import 'package:whatsapp_clone/Presentation/bloc/user/cubit/user_cubit.dart';
import 'package:whatsapp_clone/data/data_source/fb_datasouce_implementation.dart';
import 'package:whatsapp_clone/data/data_source/firebase_datasource.dart';
import 'package:whatsapp_clone/data/data_source/local_datasource/local_datasource.dart';
import 'package:whatsapp_clone/data/respositories/firebase_repo_implementation.dart';
import 'package:whatsapp_clone/data/respositories/get_device_repo_implementation.dart';
import 'package:whatsapp_clone/domain/repositories/firebase_repository.dart';
import 'package:whatsapp_clone/domain/repositories/get_device_number_repository.dart';
import 'package:whatsapp_clone/domain/usecases/user_cases.dart';

final sl = GetIt.instance;

Future<void> init() async {
// Future bloc

  sl.registerFactory<AuthCubit>(() => AuthCubit(sl.call<IsLoggedInUserCase>(),
      sl.call<GetCurrentUIDUserCase>(), sl.call<SignOutUserCase>()));

  sl.registerFactory<PhoneAuthCubit>(() => PhoneAuthCubit(
      getCreatedUserUserCase: sl.call<GetCreatedUserUserCase>(),
      verifyPhoneNumberUserCase: sl.call<VerifyPhoneNumberUserCase>(),
      signInWithoneNumberUserCase: sl.call<SignInWithoneNumberUserCase>()));

  sl.registerFactory<DeviceNumberCubit>(
      () => DeviceNumberCubit(sl.call<GetDeviceNumbersUseCase>()));

  sl.registerFactory<UserCubit>(() => UserCubit(sl.call<GetAllUsersUseCase>(),
      sl.call<CreateOnetoOneChatChannelUseCase>()));

  sl.registerFactory(() => CameraCubit());

  sl.registerFactory<CommsCubit>(() => CommsCubit(
      sendTextMessageUseCase: sl.call<SendTextMessageUseCase>(),
      getMessagesUseCase: sl.call<GetMessagesUseCase>(),
      addToMyChatUseCase: sl.call<AddToMyChatUseCase>(),
      getOnetoOneSingleUserChannelIDUseCase:
          sl.call<GetOnetoOneSingleUserChannelIDUseCase>()));

  sl.registerFactory<MychatCubit>(
      () => MychatCubit(getMyChatUseCase: sl.call<GetMyChatUseCase>()));

// useCases
  sl.registerLazySingleton<GetCreatedUserUserCase>(
      () => GetCreatedUserUserCase(repository: sl.call<FireBaseRepository>()));
  sl.registerLazySingleton<GetCurrentUIDUserCase>(
      () => GetCurrentUIDUserCase(repository: sl.call<FireBaseRepository>()));
  sl.registerLazySingleton<IsLoggedInUserCase>(
      () => IsLoggedInUserCase(repository: sl.call<FireBaseRepository>()));
  sl.registerLazySingleton<SignOutUserCase>(
      () => SignOutUserCase(repository: sl.call<FireBaseRepository>()));
  sl.registerLazySingleton<VerifyPhoneNumberUserCase>(() =>
      VerifyPhoneNumberUserCase(repository: sl.call<FireBaseRepository>()));
  sl.registerLazySingleton<SignInWithoneNumberUserCase>(() =>
      SignInWithoneNumberUserCase(repository: sl.call<FireBaseRepository>()));

  sl.registerLazySingleton<GetAllUsersUseCase>(
      () => GetAllUsersUseCase(repository: sl.call<FireBaseRepository>()));
  sl.registerLazySingleton<GetMessagesUseCase>(
      () => GetMessagesUseCase(repository: sl.call<FireBaseRepository>()));
  sl.registerLazySingleton<GetMyChatUseCase>(
      () => GetMyChatUseCase(repository: sl.call<FireBaseRepository>()));
  sl.registerLazySingleton<CreateOnetoOneChatChannelUseCase>(() =>
      CreateOnetoOneChatChannelUseCase(
          repository: sl.call<FireBaseRepository>()));
  sl.registerLazySingleton<GetOnetoOneSingleUserChannelIDUseCase>(() =>
      GetOnetoOneSingleUserChannelIDUseCase(
          repository: sl.call<FireBaseRepository>()));
  sl.registerLazySingleton<AddToMyChatUseCase>(
      () => AddToMyChatUseCase(repository: sl.call<FireBaseRepository>()));
  sl.registerLazySingleton<SendTextMessageUseCase>(
      () => SendTextMessageUseCase(repository: sl.call<FireBaseRepository>()));

  sl.registerLazySingleton<GetDeviceNumbersUseCase>(() =>
      GetDeviceNumbersUseCase(
          repository: sl.call<GetDeviceNumberRepository>()));

//repository
  sl.registerLazySingleton<FireBaseRepository>(() => FirebaseRepoImplementation(
      remoteDataSource: sl.call<FireBaseRemoteDataSource>()));

  sl.registerLazySingleton<GetDeviceNumberRepository>(() =>
      GetDeviceNumRepoImplementation(
          dataSource: sl.call<GetDeviceNumbersLocalDataSource>()));

// remote Data
  sl.registerLazySingleton<FireBaseRemoteDataSource>(() =>
      FirebaseDataSourceImplementation(
          auth: sl.call<FirebaseAuth>(),
          firestore: sl.call<FirebaseFirestore>()));

// Local DataSOURCE

  sl.registerLazySingleton<GetDeviceNumbersLocalDataSource>(
      () => GetDeviceNumbersLocalDSImlementation());

// External

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  sl.registerLazySingleton<FirebaseAuth>(() => auth);
  sl.registerLazySingleton<FirebaseFirestore>(() => firestore);
}
