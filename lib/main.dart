import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/Presentation/bloc/auth/auth_cubit.dart';
import 'package:whatsapp_clone/Presentation/bloc/camera/cubit/camera_cubit.dart';
import 'package:whatsapp_clone/Presentation/bloc/comms/cubit/comms_cubit.dart';
import 'package:whatsapp_clone/Presentation/bloc/device_number/cubit/device_number_cubit.dart';
import 'package:whatsapp_clone/Presentation/bloc/mychat/cubit/mychat_cubit.dart';
import 'package:whatsapp_clone/Presentation/bloc/phone_auth/phone_auth_cubit.dart';
import 'package:whatsapp_clone/Presentation/bloc/user/cubit/user_cubit.dart';
import 'package:whatsapp_clone/Presentation/screens/home_screen.dart';
import 'package:whatsapp_clone/Presentation/screens/registeration.dart';
import 'package:whatsapp_clone/Presentation/screens/welcome.dart';
import 'package:whatsapp_clone/Presentation/widgets/theme/style.dart';
import 'package:whatsapp_clone/data/model/user_moder.dart';
import 'injection_container.dart' as inj;
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await inj.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
              create: (context) => inj.sl<AuthCubit>()..appStartUp()),
          BlocProvider<PhoneAuthCubit>(
              create: (context) => inj.sl<PhoneAuthCubit>()),
          BlocProvider<DeviceNumberCubit>(
              create: (context) =>
                  inj.sl<DeviceNumberCubit>()..getDeviceNumbers()),
          BlocProvider<UserCubit>(
              create: (context) => inj.sl<UserCubit>()..getAllUsers()),
          BlocProvider<CameraCubit>(
              create: (context) => inj.sl<CameraCubit>()..initilizeCamera()),
          BlocProvider<CommsCubit>(create: (context) => inj.sl<CommsCubit>()),
          BlocProvider<MychatCubit>(create: (context) => inj.sl<MychatCubit>()),
        ],
        child: MaterialApp(
          theme: ThemeData(
            primaryColor: primaryColor,
          ),
          debugShowCheckedModeBanner: false,
          title: 'Flutter WhatsApp Clone',
          home: RegisterationScreen(),
          // routes: {
          //   "/": (context) {
          //     return BlocBuilder<AuthCubit, AuthState>(
          //         builder: (context, authState) {
          //       if (authState is AuthenticatedState) {
          //         return BlocBuilder<UserCubit, UserState>(
          //           builder: (context, userState) {
          //             if (userState is UserLoadedState) {
          //               return BlocBuilder<CameraCubit, CameraState>(
          //                   builder: (context, cameraState) {
          //                 if (cameraState is CameraInitializedState) {
          //                   final currentUserInfo = userState.usersList
          //                       .firstWhere((user) => user.uid == authState.uID,
          //                           orElse: () => UserModel(
          //                               name: 'name',
          //                               email: 'email',
          //                               phoneNumber: 'phoneNumber',
          //                               isOnline: false,
          //                               uid: 'uid',
          //                               status: 'status',
          //                               profileURL: 'profileURL'));
          //                   return HomeScreen(
          //                     userInfo: currentUserInfo,
          //                     camera: cameraState.camera,
          //                     cameraController: cameraState.cameraController,
          //                   );
          //                 } else {
          //                   return Scaffold(
          //                     body: Center(
          //                       child: Column(
          //                         children: const [
          //                           CircularProgressIndicator(),
          //                           SizedBox(
          //                             height: 20,
          //                           ),
          //                           Text('Loading Camera'),
          //                         ],
          //                       ),
          //                     ),
          //                   );
          //                 }
          //               });
          //             } else {
          //               return const Scaffold(
          //                 body: Center(
          //                   child: Text('UserFailuer State UserCubit'),
          //                 ),
          //               );
          //             }
          //           },
          //         );
          //       } else if (authState is UnAuthenticatedState) {
          //         return const WelcomeScreen();
          //       } else {
          //         return const Center(
          //           child: Text('error reading State'),
          //         );
          //       }
          //     });
          //   }
          // },
        ));
  }
}
